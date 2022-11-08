//
//  IconField.swift
//  MavPlus
//
//  Created by Berente Bálint on 2022. 10. 14..
//

import SwiftUI

struct IconField: View {
    @State var iconName: String
    @State var value: String
    
    var body: some View {
        HStack{
            Image(systemName: iconName).foregroundColor(Color("Secondary"))
            Text(value)
        }
    }
}

extension IconField {
    
}

struct IconField_Previews: PreviewProvider {
    static var previews: some View {
        IconField(iconName: "arrow.left.arrow.right", value: "Test")
    }
}
