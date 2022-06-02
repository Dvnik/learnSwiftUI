//
//  TestSomeViewApp.swift
//  TestSomeView
//
//  Created by Trixie Lulamoon on 2022/5/20.
//

import SwiftUI

@main
struct TestSomeViewApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
//            ContentView()
            ToDoListMainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
