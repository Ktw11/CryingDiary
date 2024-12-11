//
//  HomeBuilder.swift
//  Home
//
//  Created by 공태웅 on 12/11/24.
//

import SwiftUI

public protocol HomeBuilder {
    associatedtype SomeView: View
    
    var view: SomeView { get }
}
