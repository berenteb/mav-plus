import Foundation


protocol OfferProtocol: RequestStatus, Updateable, ObservableObject {
    var offers: [OfferData] {get}
}

struct OfferData {
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
    private var startCode: String
    private var endCode: String
    
    init(start: String, end: String) {
        self.startCode = start
        self.endCode = end
        self.offers = []
        self.isLoading = true
        self.isError = false
    }
    
    func update() {
        isLoading = true
        isError = false
        ApiRepository.shared.getOffer(startCode: startCode, endCode: endCode){ offers, error in
            self.isError = error != nil
            self.offers = []
            guard let routes = offers?.route else { return }
            routes.forEach{route in
                guard let routeDetails = route.details?.routes?[0] else {return}
                let startName = routeDetails.startStation?.name ?? "Unknown"
                let sCode = routeDetails.startStation?.code
                let endName = routeDetails.destionationStation?.name ?? "Unknown"
                let eCode = routeDetails.startStation?.code
                let price = routeDetails.travelClasses?[0].price
                let priceTag = "\(price?.amount ?? 0) \(price?.currency?.name ?? "?")"
                let transferCount = route.transfersCount ?? 0
                let name = route.details?.trainFullName
                let type = routeDetails.trainDetails?.type
                let travelTime = routeDetails.travelTime ?? "Unknown"
                self.offers.append(OfferData(startStationName: startName, endStationName: endName, price: priceTag, travelTime: travelTime, transferCount: transferCount))
                StoreRepository.shared.saveRecentOffer(startCode: sCode ?? self.startCode, endCode: eCode ?? self.endCode)
            }
            self.isLoading = false
        }
        
    }
}


