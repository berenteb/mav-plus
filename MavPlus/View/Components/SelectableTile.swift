//
//  SelectableTile.swift
//  mav-ui
//
//  Created by Márton Pfemeter on 2022-10-04.
//

import SwiftUI

struct SelectableTile<Content: View>: View {
    
    public let selectColor: Color
    public let unSelectColor: Color
    public let content: Content
    
    @Binding public var isSelected: Bool
    
    init(selectColor: Color, unSelectColor: Color, isSelected: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self.selectColor = selectColor
        self.unSelectColor = unSelectColor
        self.content = content()
        self._isSelected = isSelected
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
            .cornerRadius(CGFloat(20))
            .foregroundColor(self.isSelected ? self.selectColor : self.unSelectColor)
            
            self.content
            .padding()
        }
        .onTapGesture {
            self.isSelected = !self.isSelected
        }
    }
}

struct SelectableTile_Previews: PreviewProvider {
    
    @State private static var isSelected: Bool = false
    
    static var previews: some View {
        SelectableTile(selectColor: Color.blue, unSelectColor: Color.teal, isSelected: self.$isSelected) {
            Text("hi")
        }
    }
}
