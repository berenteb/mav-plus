import SwiftUI

@main
struct MavPlusApp: App {
    var body: some Scene {
        WindowGroup {
            LoadingScreen()
                .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
        }
    }
}
