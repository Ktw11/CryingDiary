//
//  Diary.swift
//  Home
//
//  Created by 공태웅 on 12/28/24.
//

import Foundation

struct Diary: Equatable {
    let title: String
    #warning("Image 반영 필요")
//    let image: Image
    let content: String
    let year: Int
    let month: Int
    let day: Int
    let timeStamp: TimeInterval
}
