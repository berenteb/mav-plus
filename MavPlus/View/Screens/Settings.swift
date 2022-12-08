import SwiftUI

/// Placeholder view for settings
struct Settings: View {
    
    /// SwiftUI view generation.
    var body: some View {
        NavigationStack {
            Text("Settings placeholder")
            .italic()
            .navigationTitle(Text("Settings"))
        }
    }
}

/// SwiftUI Preview
struct Settings_Previews: PreviewProvider {
    
    /// SwiftUI Preview content generation.
    static var previews: some View {
        Settings()
    }
}
