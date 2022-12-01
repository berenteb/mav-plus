//
//  MapKitMap.swift
//  MavPlus
//
//  Created by Márton Pfemeter on 2022-11-23.
//

import SwiftUI
import MapKit

/// SwiftUI embeddable UIKit based Map view
struct MapKitMap: UIViewRepresentable {
    
    /// Data for the view
    @ObservedObject public var model: MapViewModel
    
    /// The annotations that are displayed on the map
    @State private var activeAnnotationList: [LocationItem] = [LocationItem]()
    
    /// Internal class for MapKit compatibility
    class Coordinator: NSObject, MKMapViewDelegate {
        
        /// The original MapKit view
        var parent: MapKitMap
        
        /// Default initializer
        /// - Parameter parent: The original MapKit view this Coordinator uses
        init(_ parent: MapKitMap) {
            self.parent = parent
        }
        
        /// Creates the annotation view for the map
        /// - Parameters:
        ///   - mapView: The Map view
        ///   - annotation: The annotation that needs a view, must be LocationItem
        /// - Returns: The view for the annotation, or nil if the annotation passed was not a LocationItem
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard let location = annotation as? LocationItem else {
                return nil
            }
            
            return CustomMapAnnotation(annotation: location, reuseIdentifier: CustomMapAnnotation.ReuseID, isStation: location.isStation)
        }
        
        /// Handles the selection of an annotation on the map, by navigating to the relevant detailed view.
        /// - Parameters:
        ///   - mapView: The Map view
        ///   - annotation: The annotation selected
        func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
            guard let location: LocationItem = annotation as? LocationItem else {
                return
            }
            
            DispatchQueue.main.async {
                self.parent.model.locationNavStack.append(location)
            }
            
        }
    }
    
    /// Creates a Coordinator object
    /// - Returns: The object created
    public func makeCoordinator() -> Coordinator {
        MapKitMap.Coordinator(self)
    }
    
    /// Creates the Map view
    /// - Parameter context: The context for the view
    /// - Returns: The view created
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
    
    /// Handles updating of the annotation coordinates by adding an animation between the old and the new coordinates
    /// - Parameters:
    ///   - uiView: The Map view to update
    ///   - context: The context for the view
    public func updateUIView(_ uiView: MKMapView, context: Context) {
        var oldAnnotationList: [LocationItem] = [LocationItem]()
        oldAnnotationList.append(contentsOf: self.activeAnnotationList)
        
        var outputList: [LocationItem] = [LocationItem]()
        for item in self.model.locations {
            if let oldItemIndex: Int = oldAnnotationList.firstIndex(where: { iteratorItem in
                return (iteratorItem.id == item.id)
            }) {
                UIView.animate(withDuration: 0.25) {
                    var activeItem: LocationItem = oldAnnotationList.remove(at: oldItemIndex)
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

/// SwiftUI Preview
struct MapKitMap_Previews: PreviewProvider {
    
    /// SwiftUI Preview content generation.
    static var previews: some View {
        MapKitMap(model: MapViewModel())
    }
}
