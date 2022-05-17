//
//  TaskStore.swift
//  SwiftUIProgressRing
//
//  Created by Trixie Lulamoon on 2022/5/17.
//

import Foundation


class TaskStore: ObservableObject {
    @Published var tasks = sampleTasks
}

#if DEBUG
var sampleTasks = [ Task(name: "Design", progress: 0.7),
                    Task(name: "Coding", progress: 0.5),
                    Task(name: "Documentation", progress: 0.1),
                    Task(name: "Unit Testing", progress: 0.2)
                    ]
#endif
