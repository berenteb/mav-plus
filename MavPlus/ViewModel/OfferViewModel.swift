import Foundation


protocol OfferProtocol: RequestStatus, Updateable, ObservableObject {
    var offers: [OfferData] {get}
}

struct OfferData: Identifiable {
    var id: UUID = UUID()
    var startStationName: String
    var endStationName: String
    var depDate: Date
    var arrDate: Date
    var price: String
    var travelTime: String
    var transferCount: Int
    var route: [OfferRoutePart]
}

struct OfferRoutePart: Identifiable {
    var id: UUID
    var startStationName: String
    var endStationName: String
    var trainName: String
    var trainCode: String
    var startDate: Date?
    var endDate: Date?
    var trainPictogram: TrainPictogram?
    var travelTime: String
    init(startStationName: String, endStationName: String, trainName: String, trainCode: String, startDate: Date? = nil, endDate: Date? = nil, trainPictogram: TrainPictogram? = nil, travelTime: String) {
        self.id = UUID()
        self.startStationName = startStationName
        self.endStationName = endStationName
        self.trainName = trainName
        self.startDate = startDate
        self.endDate = endDate
        self.trainPictogram = trainPictogram
        self.travelTime = travelTime
        self.trainCode = trainCode
    }
}

class OfferViewModel: OfferProtocol, ObservableObject {
    @Published var offers: [OfferData] = []
    @Published var isLoading: Bool = true
    @Published var isError: Bool = false
     var start: FormStationListItem
     var end: FormStationListItem
     var passengerCount: Int
     var startDate: Date
    
    init(start: FormStationListItem, end: FormStationListItem, passengerCount: Int, startDate: Date) {
        self.start = start
        self.end = end
        self.passengerCount = passengerCount
        self.startDate = startDate
        update()
    }
    
    func update() {
        isLoading = true
        isError = false
        ApiRepository.shared.getOffer(startCode: start.code, endCode: end.code, passengerCount: passengerCount, startDate: startDate){ offers, error in
            self.isError = error != nil
            self.offers = []
            guard let routes = offers?.route else { return }
            var offers: [OfferData] = []
            routes.forEach{route in
                guard let depDate = DateFromIso(route.departure?.time ?? ""), let arrDate = DateFromIso(route.arrival?.time ?? "") else {return}
                let startName = route.details?.routes?[0].startStation?.name ?? "Unknown"
                let endName = route.lastStation ?? "Unknown"
                let tickets = route.travelClasses ?? []
                var priceTag = "Unknown"
                if !tickets.isEmpty{
                    priceTag = "\(Int(tickets[0].price?.amount ?? 0)) \(tickets[0].price?.currency?.name ?? "?")"
                }
                let transferCount = route.transfersCount ?? 0
                let travelTime = route.travelTimeMin ?? "Unknown"
                var routeParts: [OfferRoutePart] = []
                route.details?.routes?.forEach{route in
                    var pictogram: TrainPictogram? = nil
                    if let signName = route.trainDetails?.viszonylatiJel?.jel, let fgColor = route.trainDetails?.viszonylatiJel?.fontSzinKod, let bgColor = route.trainDetails?.viszonylatiJel?.hatterSzinKod {
                        pictogram = TrainPictogram(
                            foregroundColor: fgColor,
                            backgroundColor: bgColor,
                            name: signName
                        )
                    }else if let signName = route.trainDetails?.trainKind?.sortName,
                            let fgColor = route.trainDetails?.trainKind?.foregroundColorCode,
                            let bgColor = route.trainDetails?.trainKind?.backgroundColorCode {
                        pictogram = TrainPictogram(
                            foregroundColor: fgColor,
                            backgroundColor: bgColor,
                            name: signName
                        )
                    }
                    routeParts.append(
                        OfferRoutePart(
                            startStationName: route.startStation?.name ?? "Unknown",
                            endStationName: route.destionationStation?.name ?? "Unknown",
                            trainName: "\(route.trainDetails?.trainNumber ?? "") \(route.trainDetails?.name ?? "")",
                            trainCode: route.trainDetails?.jeId ?? "",
                            startDate: DateFromIso(route.departure?.time ?? ""),
                            endDate: DateFromIso(route.arrival?.time ?? ""), trainPictogram: pictogram,
                            travelTime: route.travelTime ?? "?"))
                }
                
                offers.append(
                    OfferData(
                        startStationName: startName,
                        endStationName: endName,
                        depDate: depDate,
                        arrDate: arrDate,
                        price: priceTag,
                        travelTime: travelTime,
                        transferCount: transferCount,
                        route: routeParts
                    )
                )
                StoreRepository.shared.saveRecentOffer(startCode: self.start.code, endCode: self.end.code)
            }
            
            self.offers = offers
            self.isLoading = false
        }
        
    }
}


