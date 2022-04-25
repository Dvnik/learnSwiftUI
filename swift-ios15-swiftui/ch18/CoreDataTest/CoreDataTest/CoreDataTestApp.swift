//
//  CoreDataTestApp.swift
//  CoreDataTest
//
//  Created by Trixie Lulamoon on 2022/4/25.
//

import SwiftUI

@main
struct CoreDataTestApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
