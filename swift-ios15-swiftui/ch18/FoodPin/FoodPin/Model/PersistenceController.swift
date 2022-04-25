//
//  Persistence.swift
//  FoodPin
//
//  Created by Trixie Lulamoon on 2022/4/25.
//

import CoreData
import UIKit

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "FoodPin")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext

        let restaurant = Restaurant(context: viewContext)

        restaurant.name = "Cafe Deadend"
        restaurant.type = "Coffee & Tea Shop"
        restaurant.location = "G/F, 72 Po Hing Fong, Sheung Wan, Hong Kong"
        restaurant.phone = "232-923423"
        restaurant.summary = "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at 9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal."
        restaurant.image = (UIImage(named: "cafedeadend")?.pngData())!
        restaurant.isFavorite = false

        do {
            try viewContext.save()
        } catch {
            // 在這裡實作程式碼以適切的方式處理錯誤
            // fatalError() 造成應用程式產生錯誤的紀錄與程式的終止，儘管在開發階段是有幫助的，你不能在正式的應                   //用程式中使用這個函數。
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    static var testData: [Restaurant]? = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Restaurant")
        return try? PersistenceController.preview.container.viewContext.fetch(fetchRequest) as? [Restaurant]
    }()
}
