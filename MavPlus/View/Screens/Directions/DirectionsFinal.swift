//
//  DirectionsFinal.swift
//  mav-ui
//
//  Created by Márton Pfemeter on 2022-10-05.
//

import SwiftUI

struct DirectionsFinal: View {
    var offer: OfferData
    
    var body: some View {
        List{
            Section(content: {
                HStack{
                    Image(systemName: "clock").foregroundColor(Color("Secondary"))
                    Text(offer.depDate.formatted(date: .omitted, time: .shortened))
                    Image(systemName: "arrow.forward")
                    Text(offer.arrDate.formatted(date: .omitted, time: .shortened))
                }
                IconField(iconName: "clock.arrow.circlepath", value: offer.travelTime)
                if offer.transferCount > 0 {
                    IconField(iconName: "arrow.left.arrow.right", value: String(offer.transferCount))
                }
                IconField(iconName: "banknote", value: offer.price)
            }, header: {
                Text("Details", comment: "Directions result details heading")
            })
            Section(content: {
                ForEach(offer.route, id: \.id){ part in
                    NavigationLink(destination: {
                        if let id = Int(part.trainCode){
                            TrainDetailsScreen(trainId: id)
                        }else {
                            EmptyView()
                        }
                    }, label: {
                        HStack{
                            VStack(alignment: .leading, spacing: 10){
                                HStack{
                                    Text(part.startDate?.formatted(date: .omitted, time: .shortened) ?? "")
                                    Text(part.startStationName)
                                }
                                HStack{
                                    Image(systemName: "arrow.down")
                                    if let pictogram = part.trainPictogram{
                                        Text(pictogram.name)
                                            .bold()
                                            .foregroundColor(Color(hex: pictogram.foregroundColor))
                                    }
                                    Text(part.trainName)
                                }
                                HStack{
                                    Text(part.endDate?.formatted(date: .omitted, time: .shortened) ?? "")
                                    Text(part.endStationName)
                                }
                            }
                        }
                    })
                }
            }, header: {
                Text("Route", comment: "Directions result itinerary heading")
            })
        }.navigationTitle(Text("Offer", comment: "Directions result screen title"))
    }
}


struct DirectionsFinal_Previews: PreviewProvider {
    
    @State private static var navPath: NavigationPath = NavigationPath()
    
    static var previews: some View {
        DirectionsFinal(
            offer: OfferData(startStationName: "Vasalma", endStationName: "Jónásapátfalva", depDate: Date(), arrDate: Date(), price: "2000 HUF", travelTime: "234min", transferCount: 0, route: [])
        )
    }
}
