//
//  NetworkProvider.swift
//  CryingDiary
//
//  Created by 공태웅 on 9/27/24.
//

import Foundation

final actor NetworkProvider: NetworkProvidable {
    
    // MARK: Lifecycle
    
    init(
        session: URLSession = .shared,
        tokenStore: TokenStorable
    ) {
        self.session = session
        self.tokenStore = tokenStore
    }
    
    // MARK: Properties
    
    private let tokenStore: TokenStorable
    private let session: URLSession
    
    // MARK: Methods
    
    func request<Response: ResponseType>(api: API, decodingType: Response.Type) async throws -> Response {
        try await request<Response>(api: api, decodingType: decodingType, retry: true)
    }
    
    func request(api: API) async throws {
        _ = try await requestData(api: api, retry: true)
    }
}

private extension NetworkProvider {
    func requestData(api: API, retry: Bool = true) async throws -> Data {
        let accessToken = await tokenStore.accessToken
        let request: URLRequest = try api.makeURLRequest(accessToken: accessToken)
        
        let (data, response): (Data, URLResponse)
        do {
            (data, response) = try await session.data(for: request)
        } catch {
            throw NetworkError.failedInGeneral(error)
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        if httpResponse.statusCode == 401 && retry {
            try await refreshTokens()
            
            return try await requestData(api: api, retry: false)
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.unacceptableStatusCode
        }
        
        return data
    }
    
    func request<Response: ResponseType>(
        api: API,
        decodingType: Response.Type,
        retry: Bool = true
    ) async throws -> Response {
        let data = try await requestData(api: api, retry: retry)
        
        do {
            return try JSONDecoder().decode(decodingType.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
    
    func refreshTokens() async throws {
        guard let currentRefreshToken = await tokenStore.refreshToken else { throw NetworkError.authenticationFailed }

        do {
            let api = RefreshAPI(refreshToken: currentRefreshToken)
            let response = try await request(api: api, decodingType: TokenResponse.self, retry: false)
            await tokenStore.updateTokens(accessToken: response.accessToken, refreshToken: response.refreshToken)
        } catch {
            throw NetworkError.authenticationFailed
        }
    }
}

private struct TokenResponse: Decodable {
    let accessToken: String
    let refreshToken: String
}
