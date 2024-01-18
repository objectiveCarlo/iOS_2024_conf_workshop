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
    @Query var dungeons: [Dungeon]
    @Environment(\.modelContext) private var context
    var body: some View {
        
        NavigationStack {
            VStack {
                List {
                    ForEach (dungeons, id: \.id) { dungeon in
                        Text("\(dungeon.name) is level \(dungeon.level) ")
                    }.onDelete(perform:deleteDungeons)
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
        
    func deleteDungeons(_ indexSet: IndexSet) {
        for item in indexSet {
            let object = dungeons[item]
            context.delete(object)
            
        }
        try? context.save()
    }
        
}

#Preview {
    ContentView()
}
