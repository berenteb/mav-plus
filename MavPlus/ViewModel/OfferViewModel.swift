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
    var type: String?
    var name: String?
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
                guard let routeDetails = route.details?.routes?[0] else {return}
                guard let depDate = DateFromIso(route.departure?.time ?? ""), let arrDate = DateFromIso(route.arrival?.time ?? "") else {return}
                let startName = routeDetails.startStation?.name ?? "Unknown"
                let endName = routeDetails.destionationStation?.name ?? "Unknown"
                let tickets = route.details?.tickets ?? []
                var priceTag = "Unknown"
                if !tickets.isEmpty{
                    priceTag = "\(Int(tickets[0].grossPrice?.amount ?? 0)) \(tickets[0].grossPrice?.currency?.name ?? "?")"
                }
                let transferCount = route.transfersCount ?? 0
                let name = route.details?.trainFullName
                let type = routeDetails.trainDetails?.type
                let travelTime = routeDetails.travelTime ?? "Unknown"
                
                offers.append(
                    OfferData(
                        startStationName: startName,
                        endStationName: endName,
                        depDate: depDate,
                        arrDate: arrDate,
                        price: priceTag,
                        travelTime: travelTime,
                        transferCount: transferCount,
                        type: type,
                        name: name))
            }
            StoreRepository.shared.saveRecentOffer(startCode: self.start.code, endCode: self.end.code)
            
            self.offers = offers
            self.isLoading = false
        }
        
    }
}


