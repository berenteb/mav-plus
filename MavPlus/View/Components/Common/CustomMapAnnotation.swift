//
//  CustomMapAnnotation.swift
//  MavPlus
//
//  Created by Márton Pfemeter on 2022-11-23.
//

import Foundation
import MapKit
import SwiftUI

let clusterID = "clustering"

/// Custom annotation view using MapIcon SwiftUI component
class CustomMapAnnotation: MKAnnotationView {
    
    /// ID for MapKit annotation reusability
    static let ReuseID = "customAnnotation"
    
    /// Default initializer
    /// - Parameters:
    ///   - annotation: The data behind this view
    ///   - reuseIdentifier: Optional, is overriden by self.ReuseID
    ///   - isStation: Whether to use the station or the train icon in the view
    init(annotation: MKAnnotation?, reuseIdentifier: String?, isStation: Bool) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        clusteringIdentifier = clusterID
        self.addSubview(UIHostingController(rootView: MapIcon(self.getImageName(isStation: isStation))).view)
    }
    
    /// Initializer for protocol conformance - not implemented
    /// - Parameter aDecoder: The decoder to initialize from
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Returns the name of the image asset for initalization
    /// - Parameter isStation: True if the station image's name is required, false if the name of the train image
    /// - Returns: If isStation then station image's name, otherwise the name of the train image
    private func getImageName(isStation: Bool) -> String {
        if (isStation) {
            return "Station"
        } else {
            return "Train"
        }
    }
    
    /// Sets the displayPriority attribute of this object to .defaultLow
    override func prepareForDisplay() {
        super.prepareForDisplay()
        displayPriority = .defaultLow
    }
}
