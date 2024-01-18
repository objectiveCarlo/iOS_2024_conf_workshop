//
//  ContentView.swift
//  GustoIOS
//
//  Created by Carlo Luis Martinez on 18/1/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var showingAddView = false
    @Query var dugeons: [Dungeon]
    var body: some View {
        
        NavigationStack {
            VStack {
                List(dugeons) { dungeon in
                  Text("\(dungeon.name) is level \(dungeon.level) ")
                }
            }
            .navigationTitle("Solo Leveling")
            .toolbar {
                Button {
                    showingAddView.toggle()
                } label: {
                    Label("Add Dungeon", systemImage: "plus")
                }
            }
            .sheet(isPresented: $showingAddView) {
                AddDungeonView()
            }
        }
        }
        
        
}

#Preview {
    ContentView()
}
