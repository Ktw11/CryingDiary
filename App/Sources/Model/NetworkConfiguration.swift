//
//  NetworkConfiguration.swift
//  CryingDiary
//
//  Created by 공태웅 on 11/24/24.
//

import Foundation
import Network

final class NetworkConfiguration: NetworkConfigurable, Sendable {
    init(baseURLString: String) {
        self.baseURLString = baseURLString
    }

    let baseURLString: String
}
