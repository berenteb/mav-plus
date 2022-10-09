//
//  MavPlusApp.swift
//  MavPlus
//
//  Created by Berente Bálint on 2022. 10. 09..
//

import SwiftUI

@main
struct MavPlusApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
