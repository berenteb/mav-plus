import SwiftUI

@main
struct MavPlusApp: App {
    var body: some Scene {
        WindowGroup {
            RootNavigation()
                .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
        }
    }
}
