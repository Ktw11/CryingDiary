//
//  NetworkProvidable.swift
//  Network
//
//  Created by 공태웅 on 9/27/24.
//

import Foundation

public typealias ResponseType = Decodable & Sendable

public protocol NetworkProvidable: Sendable {
    func request<Response: ResponseType>(api: API, decodingType: Response.Type) async throws -> Response
    func request(api: API) async throws
}
