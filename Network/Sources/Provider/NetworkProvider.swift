//
//  NetworkProvider.swift
//  Network
//
//  Created by 공태웅 on 9/27/24.
//

import Foundation

public final actor NetworkProvider: NetworkProvidable {
    
    // MARK: Lifecycle
    
    public init(
        session: URLSession = .shared,
        configuration: NetworkConfigurable
    ) {
        self.session = session
        self.configuration = configuration
    }
    
    // MARK: Properties
    
    private(set) weak var tokenStore: TokenStorable?
    private let configuration: NetworkConfigurable
    private let session: URLSession
    
    // MARK: Methods
    
    public func request<Response: ResponseType>(api: API, decodingType: Response.Type) async throws -> Response {
        try await request<Response>(api: api, decodingType: decodingType, retry: true)
    }
    
    public func request(api: API) async throws {
        _ = try await requestData(api: api, retry: true)
    }
    
    public func setTokenStore(_ store: TokenStorable) {
        self.tokenStore = store
    }
}

private extension NetworkProvider {
    func requestData(api: API, retry: Bool = true) async throws -> Data {
        let accessToken = await tokenStore?.accessToken
        let request: URLRequest = try api.makeURLRequest(baseURLString: configuration.baseURLString, accessToken: accessToken)
        
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
        guard let currentRefreshToken = await tokenStore?.refreshToken else { throw NetworkError.authenticationFailed }

        do {
            let api = RefreshAPI(refreshToken: currentRefreshToken)
            let response = try await request(api: api, decodingType: TokenResponse.self, retry: false)
            await tokenStore?.updateTokens(accessToken: response.accessToken, refreshToken: response.refreshToken)
        } catch {
            throw NetworkError.authenticationFailed
        }
    }
}

private struct TokenResponse: Decodable {
    let accessToken: String
    let refreshToken: String
}
