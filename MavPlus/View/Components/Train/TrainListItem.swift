import SwiftUI

struct TrainListItemData {
    var pictogram: TrainPictogram?
    var trainName: String?
    var destination: String
}

struct TrainListItem: View {
    
    var trainData: TrainListItemData
    
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

struct TrainListItem_Previews: PreviewProvider {
    static var previews: some View {
        TrainListItem(trainData: MockTrainData)
            .previewLayout(.sizeThatFits)
    }
}
