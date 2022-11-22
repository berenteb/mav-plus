//
//  StationPicker.swift
//  MavPlus
//
//  Created by Berente Bálint on 2022. 10. 14..
//

import SwiftUI
import Combine

struct StationPickerField: View{
    @State var label: Text
    @State var list: [FormStationListItem]
    @Binding var selectedStation: FormStationListItem?
    @State var modalPresented = false
    var body: some View {
        HStack{
            self.label
            Spacer()
            if let actualStationName: String = selectedStation?.name {
                Text(actualStationName)
            } else {
                Text("Select station...")
            }
            Image(systemName: "chevron.right")
        }.onTapGesture {
            modalPresented = true
        }.sheet(isPresented: $modalPresented){
            StationPickerModal(stationList: list, pickedStation: $selectedStation)
        }
    }
}

struct StationPickerModal: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var textField = TextFieldDebouncer()
    @State var stationList: [FormStationListItem]
    @Binding var pickedStation: FormStationListItem?
    var body: some View {
        NavigationView{
            List(filteredStations, id: \.name) {station in
                HStack{
                    Text(station.name)
                    Spacer()
                    if station.name == pickedStation?.name {
                        Image(systemName: "checkmark")
                    }
                }.onTapGesture {
                    pickedStation = station
                    presentationMode.wrappedValue.dismiss()
                }
            }.searchable(text: $textField.searchText, placement: .navigationBarDrawer(displayMode: .always))
                .toolbar{
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Cancel", comment: "Cancel button prompt")
                    })
                }
        }
        
    }
    
    var filteredStations: [FormStationListItem] {
            if textField.debouncedText.isEmpty {
                let result: [FormStationListItem] = stationList.sorted(by: >)
                return result
            } else {
                let resultList: [FormStationListItem] = stationList.filter { $0.name.localizedCaseInsensitiveContains(textField.debouncedText) }
                let result: [FormStationListItem] = resultList.sorted(by: >)
                return result
            }
        }
}

struct StationPicker_Previews: PreviewProvider {
    @State static var pickedStation: FormStationListItem?
    static var previews: some View {
        StationPickerField(
            label:Text("From"),
            list:MockStationList,
            selectedStation: $pickedStation)
        .previewLayout(.sizeThatFits)
        StationPickerModal(stationList: MockStationList, pickedStation: $pickedStation)
            .previewLayout(.sizeThatFits)
    }
}
