//
//  NetworkProvidable.swift
//  CryingDiary
//
//  Created by 공태웅 on 9/27/24.
//

import Foundation

typealias ResponseType = Decodable & Sendable

protocol NetworkProvidable: Sendable {
    func request<Response: ResponseType>(api: API, decodingType: Response.Type) async throws -> Response
}
