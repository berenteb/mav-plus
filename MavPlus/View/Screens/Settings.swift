//
//  Settings.swift
//  mav-ui
//
//  Created by Márton Pfemeter on 2022-10-03.
//

import SwiftUI

struct Settings: View {
    var body: some View {
        NavigationStack {
            Text("Settings placeholder")
            .italic()
            .navigationTitle(Text("Settings", comment: "Settings tabview title"))
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
