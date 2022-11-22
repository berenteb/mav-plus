import SwiftUI

struct MapIcon: View {
    
    var imageName: String;
    init(_ imageName: String){
        self.imageName = imageName
    }
    
    var body: some View {
        Image(imageName)
            .resizable()
            .foregroundColor(Color.white)
            .frame(width: 30, height: 30).padding(5)
            .background(Color("Secondary"))
            .cornerRadius(10000)
    }
}

struct MapIcon_Previews: PreviewProvider {
    static var previews: some View {
        MapIcon("Train")
            .previewLayout(.sizeThatFits)
        MapIcon("Station")
            .previewLayout(.sizeThatFits)
    }
}
