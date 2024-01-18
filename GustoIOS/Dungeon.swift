//
//  Dungeon.swift
//  GustoIOS
//
//  Created by Carlo Luis Martinez on 18/1/24.
//

import Foundation
import SwiftData

@Model
class Dungeon {
    @Attribute(.unique) var id: String = UUID().uuidString
    @Attribute(.unique) var name: String
    var level: Int
    var difficulty: Int
    var skillNeedded: Int
    var monsters: [Monster]
    
    init(name: String, level: Int, difficulty: Int, skillNeedded: Int, monsters: [Monster]) {
        self.name = name
        self.level = level
        self.difficulty = difficulty
        self.skillNeedded = skillNeedded
        self.monsters = monsters
    }
}
