import Foundation


protocol OfferProtocol: RequestStatus, Updateable, ObservableObject {
    var offers: [OfferData] {get}
}

struct OfferData: Identifiable {
    var id: UUID = UUID()
    var startStationName: String
    var endStationName: String
    var price: String
    var travelTime: String
    var transferCount: Int
    var type: String?
    var name: String?
}

class OfferViewModel: OfferProtocol, ObservableObject {
    @Published var offers: [OfferData]
    @Published var isLoading: Bool
    @Published var isError: Bool
    private(set) var startCode: String
    private(set) var endCode: String
    private(set) var passengerCount: Int
    private(set) var startDate: Date
    
    init(start: String, end: String, count: Int, date: Date) {
        self.startCode = start
        self.endCode = end
        self.offers = []
        self.isLoading = true
        self.isError = false
        self.passengerCount = count
        self.startDate = date
    }
    
    func update() {
        isLoading = true
        isError = false
        ApiRepository.shared.getOffer(startCode: startCode, endCode: endCode, passengerCount: passengerCount, startDate: self.startDate){ offers, error in
            self.isError = error != nil
            self.offers = []
            guard let routes = offers?.route else { return }
            routes.forEach{route in
                guard let routeDetails = route.details?.routes?[0] else {return}
                let startName = routeDetails.startStation?.name ?? "Unknown"
                let sCode = routeDetails.startStation?.code
                let endName = routeDetails.destionationStation?.name ?? "Unknown"
                let eCode = routeDetails.destionationStation?.code
                let price = routeDetails.travelClasses?[0].price
                let priceTag = "\(price?.amount ?? 0) \(price?.currency?.name ?? "?")"
                let transferCount = route.transfersCount ?? 0
                let name = route.details?.trainFullName
                let type = routeDetails.trainDetails?.type
                let travelTime = routeDetails.travelTime ?? "Unknown"
                var offers: [OfferData] = []
                offers.append(OfferData(startStationName: startName, endStationName: endName, price: priceTag, travelTime: travelTime, transferCount: transferCount))
                StoreRepository.shared.saveRecentOffer(startCode: sCode ?? self.startCode, endCode: eCode ?? self.endCode)
                self.offers = offers
            }
            self.isLoading = false
        }
        
    }
}


