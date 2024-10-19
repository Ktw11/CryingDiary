//
//  API.swift
//  CryingDiary
//
//  Created by 공태웅 on 9/27/24.
//

import Foundation

protocol API: Sendable {
    var baseURLString: String { get }
    var path: String { get }
    var method: HttpMethod { get }
    var headers: [String: String] { get }
    var queryParameters: [String: String]? { get }
    var bodyParameters: [String: String]? { get }
    var needsAuthorization: Bool { get }
}

extension API {
    var baseURLString: String { AppKeys.baseURL }
    var headers: [String: String] { [:] }
    var queryParameters: [String: String]? { nil }
    var bodyParameters: [String: String]? { nil }
    var needsAuthorization: Bool { true }
    
    func makeURLRequest(accessToken: String?) throws -> URLRequest {
        guard var urlComponents = URLComponents(string: baseURLString) else {
            throw NetworkError.invalidURL
        }
        
        if let queryParameters {
            urlComponents.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        if let accessToken, needsAuthorization {
            let item = URLQueryItem(name: "Authorization", value: "Bearer \(accessToken)")
            urlComponents.queryItems?.append(item)
        }
        
        guard let url = urlComponents.url?.appendingPathComponent(path) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let bodyParameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: bodyParameters, options: [])
        }
        
        headers.forEach {
            request.setValue($1, forHTTPHeaderField: $0)
        }
        
        return request
    }
}
