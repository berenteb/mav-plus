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
    @State private var activeAnnotationList: [LocationItem] = [LocationItem]()

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
        DispatchQueue.main.async {
            self.activeAnnotationList.append(contentsOf: self.model.locations)
        }
        
        return localView
    }

    public func updateUIView(_ uiView: MKMapView, context: Context) {
        var oldAnnotationList: [LocationItem] = [LocationItem]()
        oldAnnotationList.append(contentsOf: self.activeAnnotationList)
        
        var outputList: [LocationItem] = [LocationItem]()
        for item in self.model.locations {
            if let oldItemIndex: Int = oldAnnotationList.firstIndex(where: { iteratorItem in
                return (iteratorItem.id == item.id)
            }) {
                UIView.animate(withDuration: 0.25) {
                    let activeItem: LocationItem = oldAnnotationList.remove(at: oldItemIndex)
                    activeItem.coordinate = item.coordinate
                    outputList.append(activeItem)
                }
            } else {
                uiView.addAnnotation(item)
                outputList.append(item)
            }
        }
        
        uiView.removeAnnotations(oldAnnotationList)
        
        DispatchQueue.main.async {
            self.activeAnnotationList = outputList
        }
    }
}

struct MapKitMap_Previews: PreviewProvider {
    static var previews: some View {
        MapKitMap(model: MapViewModel())
    }
}
