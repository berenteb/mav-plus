import Foundation

class ApiRepository: ObservableObject, Updateable{
    static let shared = ApiRepository()
    
    @Published var cities: Cities = []
    @Published var customers: CustomersAndDiscounts?
    @Published var stationList: StationList = []
    @Published var services: ServicesDto?
    
    private init() {
        update()
    }
    
    func update(){
        updateCities()
        updateCustomersAndDiscounts()
        updateStationList()
        updateServices()
    }
    
    func updateCities(){
        citiesRequest(){cities, error in
            self.cities = cities
        }
    }
    func updateCustomersAndDiscounts(){
        customersRequest(){customers, error in
            self.customers = customers
        }
    }
    func updateStationList(){
        stationListRequest(){stationList, error in
            self.stationList = stationList
        }

    }
    func updateServices(){
        servicesRequest(){services, error in
            self.services = services
        }
    }
    
    
    func getOffer(startCode: String, endCode: String, completion: @escaping (Offer?, Error?) -> Void){
        offerRequest(startCode: startCode, endCode: endCode, completion: completion)
    }
    
}
