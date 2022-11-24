//
//  MapKitMap.swift
//  MavPlus
//
//  Created by Márton Pfemeter on 2022-11-23.
//

import SwiftUI
import MapKit

struct MapKitMap: UIViewRepresentable {
    
    @ObservedObject public var model: MapViewModel

    class Coordinator: NSObject, MKMapViewDelegate {
        
        var parent: MapKitMap

        init(_ parent: MapKitMap) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard let location = annotation as? LocationItem else {
                return nil
            }
            
            return CustomMapAnnotation(annotation: location, reuseIdentifier: CustomMapAnnotation.ReuseID, isStation: location.isStation)
        }
        
        func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
            guard let location: LocationItem = annotation as? LocationItem else {
                return
            }
            
            DispatchQueue.main.async {
                self.parent.model.locationNavStack.append(location)
            }
            
        }
    }

    public func makeCoordinator() -> Coordinator {
        MapKitMap.Coordinator(self)
    }

    public func makeUIView(context: Context) -> MKMapView {

        let localView: MKMapView = MKMapView()

        localView.delegate = context.coordinator
        localView.setRegion(self.model.region, animated: false)
        localView.mapType = .standard
        
        localView.addAnnotations(self.model.locations)
        
        return localView
    }

    public func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeAnnotations(uiView.annotations)
        uiView.addAnnotations(self.model.locations)
    }
}

struct MapKitMap_Previews: PreviewProvider {
    static var previews: some View {
        MapKitMap(model: MapViewModel())
    }
}
