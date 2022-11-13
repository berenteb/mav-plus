//
//  TrainDetailsScreen.swift
//  MavPlus
//
//  Created by Berente Bálint on 2022. 11. 08..
//

import SwiftUI

struct TrainDetailsScreen: View {
    @ObservedObject var model: TrainViewModel
    
    init(trainId: Int) {
        self.model = TrainViewModel(trainId: trainId)
    }
    
    var body: some View {
        VStack{
            if model.isLoading {
                SpinnerView()
            }else if let train = model.trainData{
                List{
                    Section(content: {
                        HStack{
                            Image("Directions").foregroundColor(Color("Secondary")).rotationEffect(Angle(degrees: 90))
                            VStack(alignment: .leading){
                                Text(train.startStationName)
                                Text(train.endStationName)
                            }
                        }
                        HStack{
                            if let pictogram = train.trainPictogram{
                                Text(pictogram.name)
                                    .bold()
                                    .foregroundColor(Color(hex: pictogram.foregroundColor))
                            }
                            Text(train.name)
                        }
                        
                    }, header: {
                        Text("Details", comment: "Train details screen, details title")
                    })
                    Section(content: {
                        ForEach(train.stations, id: \.name){ stop in
                            Text("\(stop.date?.formatted(date: .omitted, time: .shortened) ?? "?") - \(stop.name)")
                        }
                    }, header: {
                        Text("Route", comment: "Train details route heading")
                    })
                }
            }else{
                Text("Error", comment: "Error text")
            }
        }
        .navigationTitle(
            Text(self.model.trainData?.name ?? NSLocalizedString("Loading", comment: "Loading text") )
        ).onAppear{
            model.update()
        }
    }
}

struct TrainDetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        TrainDetailsScreen(trainId: 649641)
    }
}
