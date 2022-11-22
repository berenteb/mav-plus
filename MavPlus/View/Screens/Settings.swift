import SwiftUI

struct Settings: View {
    var body: some View {
        NavigationStack {
            Text("Settings placeholder")
            .italic()
            .navigationTitle(Text("Settings"))
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
