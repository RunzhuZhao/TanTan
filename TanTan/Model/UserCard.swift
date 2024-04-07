//
//  UserCard.swift
//  TanTan
//
//  Created by Run on 2024/4/7.
//

import Foundation

struct UserCard: Identifiable {
    let id = UUID()
    let name: String
    let age: Int
    let place: String
    let zodiac: String
    let photos: [String]
}
