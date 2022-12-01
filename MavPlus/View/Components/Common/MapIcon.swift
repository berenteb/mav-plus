import SwiftUI

/// An icon on the map with an image.
struct MapIcon: View {
    
    /// Name of the asset to display as image
    var imageName: String;
    
    /// Default initializer
    /// - Parameter imageName: The nem of the asset to display as image
    init(_ imageName: String){
        self.imageName = imageName
    }
    
    /// SwiftUI view generation.
    var body: some View {
        Image(imageName)
            .resizable()
            .foregroundColor(Color.white)
            .frame(width: 30, height: 30).padding(5)
            .background(Color("Secondary"))
            .cornerRadius(10000)
    }
}

/// SwiftUI view generation.
struct MapIcon_Previews: PreviewProvider {
    
    /// SwiftUI Preview content generation.
    static var previews: some View {
        MapIcon("Train")
            .previewLayout(.sizeThatFits)
        MapIcon("Station")
            .previewLayout(.sizeThatFits)
    }
}
