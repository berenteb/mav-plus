import SwiftUI

/// Data class representing a train in the trainlist.
struct TrainListItemData {
    
    /// The pictogram for the train.
    var pictogram: TrainPictogram?
    
    /// The name of the train.
    var trainName: String?
    
    /// The destination station of the train.
    var destination: String
}

/// View component representing a single train in the trainlist.
struct TrainListItem: View {
    
    /// Data for the view.
    var trainData: TrainListItemData
    
    /// SwiftUI view generation.
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                if let pictogram = trainData.pictogram{
                    Text(pictogram.name)
                        .bold()
                        .foregroundColor(
                            Color(hex:pictogram.foregroundColor))
                }
                if let name = trainData.trainName{
                    Text(name)
                }
            }
            Text(trainData.destination)
        }
    }
}

/// SwiftUI Preview
struct TrainListItem_Previews: PreviewProvider {
    
    /// SwiftUI Preview content generation.
    static var previews: some View {
        TrainListItem(trainData: MockTrainData)
            .previewLayout(.sizeThatFits)
    }
}
