//
//  NetworkConfigurable.swift
//  Network
//
//  Created by 공태웅 on 11/24/24.
//

import Foundation

public protocol NetworkConfigurable: Sendable {
    var baseURLString: String { get }
}
