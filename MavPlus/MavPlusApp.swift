import SwiftUI

@main
struct MavPlusApp: App {
    let persistenceController = PersistenceController.shared
    let storeViewModel = StoreRepository(controller: PersistenceController.shared)
    let apiViewModel = ApiRepository()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(apiViewModel)
                .environmentObject(storeViewModel)
        }
    }
}
