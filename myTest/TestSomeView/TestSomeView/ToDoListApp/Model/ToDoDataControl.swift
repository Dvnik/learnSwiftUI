//
//  ToDoDataControl.swift
//  TestSomeView
//
//  Created by Trixie Lulamoon on 2022/6/2.
//

import Foundation
import SwiftUI


class ToDoDataControl: NSObject {
    @Environment(\.managedObjectContext) var context
    
    
    
    func deleteTask(item: ToDoItem) {
        
        
        DispatchQueue.main.async {
            do {
                try self.context.save()
            } catch {
                print(error)
            }
        }
    }
}
