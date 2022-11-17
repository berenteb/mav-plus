import SwiftUI

struct IconField: View {
    @State var iconName: String
    @State var value: String
    
    var body: some View {
        HStack{
            Image(systemName: iconName).foregroundColor(Color("Secondary"))
            Text(value)
        }
    }
}

struct IconField_Previews: PreviewProvider {
    static var previews: some View {
        IconField(
            iconName: "arrow.left.arrow.right",
            value: "Test")
        .previewLayout(.sizeThatFits)
    }
}
