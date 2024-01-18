//
//  Player.swift
//  GustoIOS
//
//  Created by Carlo Luis Martinez on 18/1/24.
//

import Foundation
import SwiftData

@Model
class Player {
    var name: String
    var stats: String
    
    init(name: String, stats: String) {
        self.name = name
        self.stats = stats
    }
}
