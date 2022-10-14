import Foundation
import Combine

protocol ApiProtocol: Updateable{
    static var shared: any ApiProtocol {get}
    var cities: Cities {get}
    var customers: CustomersAndDiscounts? {get}
    var stationList: StationList {get}
    var services: ServicesDto? {get}
    func updateCities() -> Void
    func updateCustomersAndDiscounts() -> Void
    func updateStationList() -> Void
    func updateServices() -> Void
    func getOffer(startCode: String, endCode: String, passengerCount: Int, startDate: Date, completion: @escaping (Offer?, Error?) -> Void) -> Void
    var publisher: PassthroughSubject<ApiRepositoryFields, Never> {get}
}

struct ApiRepositoryFields {
    var cities: Cities
    var customers: CustomersAndDiscounts?
    var stationList: StationList
    var services: ServicesDto?
}

class ApiRepository: ApiProtocol{
    static var shared = ApiRepository() as (any ApiProtocol)
    
    var cities: Cities = []
    var customers: CustomersAndDiscounts?
    var stationList: StationList = []
    var services: ServicesDto?
    
    var publisher = PassthroughSubject<ApiRepositoryFields, Never>()
    
    private init() {
        update()
    }
    
    private func notify(){
        publisher.send(ApiRepositoryFields(cities: cities, customers: customers, stationList: stationList, services: services))
    }
    
    func update(){
        updateCities()
        updateCustomersAndDiscounts()
        updateStationList()
        updateServices()
    }
    
    func updateCities(){
        citiesRequest(){ [weak self] cities, error in
            self?.cities = cities
            self?.notify()
        }
    }
    func updateCustomersAndDiscounts(){
        customersRequest(){ [weak self] customers, error in
            self?.customers = customers
            self?.notify()
        }
    }
    func updateStationList(){
        stationListRequest(){ [weak self] stationList, error in
            self?.stationList = stationList
            self?.notify()
        }
        
    }
    func updateServices(){
        servicesRequest(){ [weak self] services, error in
            self?.services = services
            self?.notify()
        }
    }
    
    
    func getOffer(startCode: String, endCode: String, passengerCount: Int, startDate: Date, completion: @escaping (Offer?, Error?) -> Void){
        offerRequest(startCode: startCode, endCode: endCode, passengerCount: passengerCount, startDate: startDate, completion: completion)
    }
    
}
