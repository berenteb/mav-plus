//
//  TrainListItem.swift
//  MavPlus
//
//  Created by Berente Bálint on 2022. 11. 08..
//

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
                        .foregroundColor(Color(hex: pictogram.foregroundColor))
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
        TrainListItem(trainData: TrainListItemData(pictogram: TrainPictogram(foregroundColor: "#0000FF", backgroundColor: "#FFFFFF", name: "IC"), trainName: "ARANYHOMOK", destination: "Kelenföld"))
    }
}
