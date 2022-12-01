import SwiftUI

/// A UI component with text and an image
struct IconField: View {
    
    /// Name of the displayed image
    @State var iconName: String
    
    /// Text to display
    @State var value: String
    
    /// SwiftUI view generation.
    var body: some View {
        HStack{
            Image(systemName: iconName).foregroundColor(Color("Secondary"))
            Text(value)
        }
    }
}

/// SwiftUI Preview
struct IconField_Previews: PreviewProvider {
    
    /// SwiftUI Preview content generation.
    static var previews: some View {
        IconField(
            iconName: "arrow.left.arrow.right",
            value: "Test")
        .previewLayout(.sizeThatFits)
    }
}
