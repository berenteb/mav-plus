//
//  DirectionsOfferView.swift
//  mav-ui
//
//  Created by Márton Pfemeter on 2022-10-04.
//

import SwiftUI

/// View for an Offer item in the list of Offers
struct DirectionsOfferListItem: View {
    
    /// Data for the view.
    @State var offer: OfferData
    
    /// SwiftUI view generation.
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

/// SwiftUI Preview
struct DirectionsOfferView_Previews: PreviewProvider {
    
    /// SwiftUI Preview content generation.
    static var previews: some View {
        DirectionsOfferListItem(offer: MockOfferData)
            .previewLayout(.sizeThatFits)
    }
}
