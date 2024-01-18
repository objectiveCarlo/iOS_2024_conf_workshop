//
//  GustoIOSApp.swift
//  GustoIOS
//
//  Created by Carlo Luis Martinez on 18/1/24.
//

import SwiftUI
import SwiftData

@main
struct GustoIOSApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: Player.self)
    }
}
