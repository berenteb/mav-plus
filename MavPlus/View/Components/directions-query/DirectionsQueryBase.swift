//
//  DirectionsQueryBase.swift
//  mav-ui
//
//  Created by Márton Pfemeter on 2022-10-05.
//

import SwiftUI

struct DirectionsQueryBase<Content: View>: View {
    
    public let content: [TitledView<Content>]
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: CGFloat(5)) {
            ForEach(self.content) { viewItem in
                HStack {
                    Text(viewItem.title)
                    .bold()
                    
                    Spacer()
                    
                    viewItem.content
                }
            }

        }
    }
}

struct DirectionsQueryBase_Previews: PreviewProvider {
    static var previews: some View {
        DirectionsQueryBase(content: [
            TitledView(title: "hello") { HStack { Text("hi") } },
            TitledView(title: "hello") { HStack { Text("hi") } }
        ])
    }
}
