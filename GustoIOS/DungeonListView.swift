//
//  DungeonListView.swift
//  GustoIOS
//
//  Created by Carlo Luis Martinez on 18/1/24.
//

import SwiftUI
import SwiftData

struct DungeonListView: View {
    @State private var showingAddView = false
    @Query var dungeons: [Dungeon]
    @Environment(\.modelContext) private var context
    
    init(sort: SortDescriptor<Dungeon>, search: String?) {
        if let search, !search.isEmpty {
            _dungeons = Query(filter: #Predicate {
                $0.name.starts(with: search)
            }, sort: [sort])

        } else {
            _dungeons = Query(sort: [sort])
        }
    }
    
    
    var body: some View {
            VStack {
                if (dungeons.isEmpty) {
                    Text("So Empty Dungeon")
                } else {
                    Spacer()
                    List {
                        ForEach (dungeons, id: \.id) { dungeon in
                            NavigationLink(value: dungeon) {
                                Text("\(dungeon.name) is level \(dungeon.level) ")
                            }
                        }.onDelete(perform:deleteDungeons)
                    }.navigationDestination(for: Dungeon.self) { dungeon in
                        EditDungeonView(dungeon: dungeon)
                    }
                
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
        
    func deleteDungeons(_ indexSet: IndexSet) {
        for item in indexSet {
            let object = dungeons[item]
            context.delete(object)
            
        }
        try? context.save()
    }
}
#Preview {
    DungeonListView(sort: SortDescriptor(\Dungeon.level, order: .reverse), search: nil)
}
