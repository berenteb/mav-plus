//
//  TitledView.swift
//  mav-ui
//
//  Created by Márton Pfemeter on 2022-10-05.
//

import Foundation
import SwiftUI

class TitledView<Content: View>: UniqueObjectWithId {
    
    public let title: String
    public let content: Content
    
    public init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
        super.init()
    }
}
