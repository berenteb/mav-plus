//
//  StationInput.swift
//  mav-ui
//
//  Created by Márton Pfemeter on 2022-10-03.
//

import SwiftUI

struct StationInput: View {
    
    public let color: Color
    public let defaultText: String
    
    @State private var input: String = String()
    
    // Returns top matches to query from API
    private func getTopHitList() -> [String] {
        return [String]()
    }
    
    var body: some View {
        TextField(self.defaultText, text: self.$input)
        .background(self.color)
    }
}

struct StationInput_Previews: PreviewProvider {
    static var previews: some View {
        StationInput(color: Color.blue, defaultText: "Enter station name")
    }
}
