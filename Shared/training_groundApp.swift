//
//  training_groundApp.swift
//  Shared
//
//  Created by Роман on 07.05.2022.
//

import SwiftUI

@main
struct training_groundApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
