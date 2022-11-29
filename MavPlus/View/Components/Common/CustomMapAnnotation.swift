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

class CustomMapAnnotation: MKAnnotationView {

    static let ReuseID = "cultureAnnotation"

    init(annotation: MKAnnotation?, reuseIdentifier: String?, isStation: Bool) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        clusteringIdentifier = clusterID
        self.addSubview(UIHostingController(rootView: MapIcon(self.getImageName(isStation: isStation))).view)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func getImageName(isStation: Bool) -> String {
        if (isStation) {
            return "Station"
        } else {
            return "Train"
        }
    }

    override func prepareForDisplay() {
        super.prepareForDisplay()
        displayPriority = .defaultLow
    }
}
