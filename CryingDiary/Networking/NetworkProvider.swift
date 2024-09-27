//
//  NetworkProvider.swift
//  CryingDiary
//
//  Created by 공태웅 on 9/27/24.
//

import Foundation

final actor NetworkProvider: NetworkProvidable {
    
    // MARK: Lifecycle
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    // MARK: Properties
    
    private let session: URLSession
    
    // MARK: Methods
    
    func request<Response: ResponseType>(api: API) async throws -> Response {
        let data = try await requestData(api: api)
        
        do {
            return try JSONDecoder().decode(Response.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}

private extension NetworkProvider {
    func requestData(api: API, retry: Bool = true) async throws -> Data {
        let request: URLRequest = try api.makeURLRequest()
        
        let (data, response): (Data, URLResponse)
        do {
            (data, response) = try await session.data(for: request)
        } catch {
            throw NetworkError.failedInGeneral(error)
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unacceptableStatusCode
        }
        
        if httpResponse.statusCode == 401 && retry {
            #warning("token 갱신 로직 추가 필요")
//            try await refreshAuthToken()
            
            return try await requestData(api: api, retry: false)
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.unacceptableStatusCode
        }
        
        return data
    }
}
