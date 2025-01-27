//
//  ContentView.swift
//  To-Do-List
//
//  Created by Delaney Blaszinski on 1/22/25.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var toDoList = ToDoList()
    @State private var showingAddItemView = false
    class ToDoList: ObservableObject {
        @Published var items = [ToDoItem(priority: "High", description: "Take out trash", dueDate: Date()),
                                ToDoItem(priority: "Medium", description: "Pick up clothes", dueDate: Date()),
                                ToDoItem(priority: "Low", description: "Eat a donut", dueDate: Date())]
    }
    var body: some View {
        NavigationView {
            List {
                ForEach(toDoList.items) { item in
                    HStack {
                        VStack(alignment: .leading, content: {
                            Text(item.priority).font(.headline)
                            Text(item.description)
                        })
                        Spacer()
                        Text(item.dueDate, style: .date)
                    }
                }
                .onMove(perform: { indices, newOffset in
                    toDoList.items.move(fromOffsets: indices, toOffset: newOffset)
                })
                .onDelete(perform: { indexSet in
                    toDoList.items.remove(atOffsets: indexSet)
                })
            }
            .navigationBarTitle("To Do List", displayMode: .inline)
            .navigationBarItems(leading: EditButton())
        }
    }
}

#Preview {
    ContentView()
}
struct ToDoItem: Identifiable {
  var id = UUID()
    var priority = String()
    var description = String()
    var dueDate = Date()
}
