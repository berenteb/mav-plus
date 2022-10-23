//
//  MavMap.swift
//  mav-ui
//
//  Created by Márton Pfemeter on 2022-10-03.
//

import SwiftUI
import MapKit

struct MavMap: View {
    
    // Coordinates of zero km stone in bp (Clark Adam square)
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 47.497854,
                                       longitude: 19.040170),
        latitudinalMeters: 10000,
        longitudinalMeters: 10000
    )
    
    @StateObject private var model: MapViewModel = MapViewModel()
    
    var body: some View {
        Map(coordinateRegion: self.$region, annotationItems: self.model.locations) { place in
            MapAnnotation(coordinate: place.location) {
                Image(systemName: "tram.circle.fill")
                .font(.title2)
            }
        }
//        .onAppear {
//            self.model.stepUpdate()
//        }
    }
}

struct MavMap_Previews: PreviewProvider {
    static var previews: some View {
        MavMap()
    }
}
