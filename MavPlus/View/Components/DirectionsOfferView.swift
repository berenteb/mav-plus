//
//  DirectionsOfferView.swift
//  mav-ui
//
//  Created by Márton Pfemeter on 2022-10-04.
//

import SwiftUI

struct DirectionsOfferView: View {
    @State var offer: OfferData
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 10){
                HStack{
                    Text(offer.depDate.formatted(date: .omitted, time: .shortened))
                    Image(systemName: "arrow.forward")
                    Text(offer.arrDate.formatted(date: .omitted, time: .shortened))
                }
                IconField(iconName: "clock.arrow.circlepath", value: offer.travelTime)
                if offer.transferCount > 0 {
                    IconField(iconName: "arrow.left.arrow.right", value: String(offer.transferCount))
                }
            }
            Spacer()
            Text(offer.price)
                .foregroundColor(.white)
                .padding(5)
                .background(Color("Secondary"))
                .cornerRadius(5)
        }
    }
}

struct DirectionsOfferView_Previews: PreviewProvider {
    static var previews: some View {
        DirectionsOfferView(
            offer: OfferData(startStationName: "Vasalma", endStationName: "Budapest Keleti", depDate: Date(), arrDate: Date(), price: "2000 HUF", travelTime: "16min", transferCount: 1, route: [])
        )
    }
}
