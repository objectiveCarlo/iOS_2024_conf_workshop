//
//  Monster.swift
//  GustoIOS
//
//  Created by Carlo Luis Martinez on 18/1/24.
//

import Foundation
import SwiftData

@Model
class Monster {
    @Attribute(.unique) var id: String = UUID().uuidString
    @Attribute(.unique) var name: String
    var level: Int
    init(id: String, name: String, level: Int) {
        self.id = id
        self.name = name
        self.level = level
    }
}
