//
//  NormalButton.swift
//  mav-ui
//
//  Created by Márton Pfemeter on 2022-10-05.
//

import SwiftUI

struct NormalButton: View {
    
    public let name: String
    public let geo: GeometryProxy
    public let backgroundColor: Color
    public let action: () -> Void
    
    
    var body: some View {
        Button(action: self.action, label: {
            Text(self.name)
            .frame(maxWidth: (self.geo.size.width / 3), maxHeight: (self.geo.size.height / 12))
            .background(self.backgroundColor)
            .cornerRadius(CGFloat(5))
        })
    }
}

struct NormalButton_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { root in
            NormalButton(
                name: "cancel",
                geo: root,
                backgroundColor: Color.red,
                action: {print("hel")})
        }
    }
}
