//
//  RssView.swift
//  mav-ui
//
//  Created by Márton Pfemeter on 2022-10-03.
//

import SwiftUI

struct RssView: View {
    
    public let content: RssItem
    public let selectColor: Color
    public let unSelectColor: Color
    
    @State private var isSelected: Bool = false
    
    var body: some View {
        SelectableTile(selectColor: self.selectColor, unSelectColor: self.unSelectColor, isSelected: self.$isSelected) {
            VStack(alignment: .leading) {
                Text(self.content.title)
                .font(.title)
                .bold()
                Group {
                    Text(self.content.preview)
                    .font(.headline)
                    
                    if (self.isSelected) {
                        Text(self.content.content)
                        .font(.body)
                    }
                }
            }
        }
    }
}

struct RssView_Previews: PreviewProvider {
    static var previews: some View {
        RssView(content: RssItem(title: "MyTitle", preview: "Something happened...", content: "Lorem ipsum dolor."), selectColor: Color.teal, unSelectColor: Color.blue)
    }
}
