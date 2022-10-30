import SwiftUI

@main
struct MavPlusApp: App {
    init(){
        for family in UIFont.familyNames {
             print(family)

             for names in UIFont.fontNames(forFamilyName: family){
             print("== \(names)")
             }
        }
    }
    var body: some Scene {
        WindowGroup {
            LoadingScreen()
                .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
        }
    }
}
