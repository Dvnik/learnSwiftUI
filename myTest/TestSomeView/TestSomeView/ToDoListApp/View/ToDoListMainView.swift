//
//  ToDoListMainView.swift
//  TestSomeView
//
//  Created by Trixie Lulamoon on 2022/6/2.
//

import SwiftUI

struct ToDoListMainView: View {
    @Environment(\.managedObjectContext) var context
    
    @FetchRequest(
        entity: ToDoItem.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \ToDoItem.priorityNum, ascending: false) ])
    var todoItems: FetchedResults<ToDoItem>
    
    @State private var newItemName: String = ""
    @State private var newItemPriority: Priority = .normal
    @State private var showNewTask = false
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("ToDo List")
                        .font(.system(size: 40, weight: .black, design: .rounded))
                        
                    Spacer()
                    
                    Button(action: {
                        self.showNewTask = true
                        
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.purple)
                    }
                }//end hstack
                .padding()
                
                List {
                    ForEach(todoItems) { todoItem in
                        ToDoListRow(todoItem: todoItem)
                    }
                    .onDelete(perform: deleteTask)
                }
               
            }//end Vstack
            .rotation3DEffect(Angle(degrees: showNewTask ? 5 : 0), axis: (x: 1, y: 0, z: 0))
            .offset(y: showNewTask ? -50 : 0)
            .animation(.easeOut, value: showNewTask)
            .onAppear {
                UITableView.appearance().separatorColor = .clear
            }
            // If there is no data, show an empty view
            if todoItems.count == 0 {
                NoDataView()
            }
            
            // Display the "Add new todo" view
            if showNewTask {
                BlankView(bgColor: .black)
                    .opacity(0.5)
                    .onTapGesture {
                        self.showNewTask = false
                    }
                
                NewToDoView(isShow: $showNewTask, name: "", priority: .normal)
                    .transition(.move(edge: .bottom))
                    .animation(.interpolatingSpring(stiffness: 200.0, damping: 25.0, initialVelocity: 10.0), value: showNewTask)
            }
            
        }//end ZStack
    }
    
    
    //MARK: Functions
    private func deleteTask(indexSet: IndexSet) {
        
        for index in indexSet {
            let itemToDelete = todoItems[index]
            context.delete(itemToDelete)
        }
        
        DispatchQueue.main.async {
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
}

struct ToDoListMainView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListMainView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}


struct NoDataView: View {
    var body: some View {
        Image("welcome")
            .resizable()
            .scaledToFit()
    }
}


struct ToDoListRow: View {
    @Environment(\.managedObjectContext) var context
    
    @ObservedObject var todoItem: ToDoItem
    
    var body: some View {
        Toggle(isOn: self.$todoItem.isComplete) {
            HStack {
                Text(self.todoItem.name)
                    .strikethrough(self.todoItem.isComplete, color: .black)
                    .bold()
                    .animation(.default)
                
                Spacer()
                
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(self.color(for: self.todoItem.priority))
            }//end hstack
        }// end Toggle
        .toggleStyle(CheckboxStyle())
        .onChange(of: todoItem, perform: { _ in
            if self.context.hasChanges {
                try? self.context.save()
            }
        })
    }
 
    private func color(for priority: Priority) -> Color {
        switch priority {
        case .high: return .red
        case .normal: return .orange
        case .low: return .green
        }
    }
}
