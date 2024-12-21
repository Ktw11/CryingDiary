//
//  Toast.swift
//  Domain
//
//  Created by 공태웅 on 12/21/24.
//

import Foundation

public struct Toast: Identifiable, Equatable {
    private(set) public var id: String = UUID().uuidString
    public let message: String
    public let duration: Duration
    
    public init(message: String, duration: Duration = .seconds(2)) {
        self.message = message
        self.duration = duration
    }
}
