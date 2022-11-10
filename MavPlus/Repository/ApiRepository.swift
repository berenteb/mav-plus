import Foundation
import Combine

struct StationLocation: Decodable {
    var code: String
    var name: String
    var lat: Double?
    var lon: Double?
}

protocol ApiProtocol: Updateable, RequestStatus{
    static var shared: any ApiProtocol {get}
    var cities: Cities {get}
    var customers: CustomersAndDiscounts? {get}
    var stationList: StationList {get}
    var stationLocationList: [StationLocation] {get}
    var services: ServicesDto? {get}
    func getOffer(startCode: String, endCode: String, passengerCount: Int, startDate: Date, completion: @escaping (Offer?, Error?) -> Void) -> Void
    func getTrainLocations(completion: @escaping (TrainLocationList?, Error?) -> Void)
    func getStationInfo(stationNumberCode: String, completion: @escaping (StationInfo?, Error?) -> Void)
    func getTrainInfo(trainId: Int, completion: @escaping (TrainInfo?, Error?)->Void)
    var notifier: PassthroughSubject<(), Never> {get}
}

struct ApiRepositoryFields {
    var cities: Cities
    var customers: CustomersAndDiscounts?
    var stationList: StationList
    var services: ServicesDto?
}

class ApiRepository: ApiProtocol{
    static var shared = ApiRepository() as (any ApiProtocol)
    // Idea: implement fields as CurrentValueSubject
    var cities: Cities = []
    var customers: CustomersAndDiscounts?
    var stationList: StationList = []
    var services: ServicesDto?
    var stationLocationList: [StationLocation] = []
    // TODO: remove this
    var isLoading: Bool
    var isError: Bool
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    public var notifier = PassthroughSubject<(), Never>()
    
    private init() {
        self.isLoading = true;
        self.isError = false;
        getStationLocation()
        update()
    }
    
    public func update(){
        Publishers
            .CombineLatest4(updateCities(), updateServices(), updateStationList(), updateCustomersAndDiscounts())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.isError = false;
                    break
                case .failure(_):
                    self.isError = true;
                    break
                }
            }, receiveValue: {values in
                self.cities = values.0
                self.services = values.1
                self.stationList = values.2
                self.customers = values.3
                self.isLoading = false
                self.notifier.send()
            }).store(in: &cancellableSet)
    }
    
    private func updateCities()->AnyPublisher<Cities, Error>{
        Future{promise in
            citiesRequest(){cities, error in
                if let error = error{
                    promise(.failure(error))
                }else{
                    promise(.success(cities))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    private func updateCustomersAndDiscounts()->AnyPublisher<CustomersAndDiscounts?, Error>{
        Future{promise in
            customersRequest(){customers, error in
                if let error = error{
                    promise(.failure(error))
                }else{
                    promise(.success(customers))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    private func updateStationList()->AnyPublisher<StationList, Error>{
        Future{promise in
            stationListRequest(){stationList, error in
                if let error = error{
                    promise(.failure(error))
                }else{
                    promise(.success(stationList.filter{!$0.isAlias}))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    private func updateServices()->AnyPublisher<ServicesDto?, Error>{
        Future{promise in
            servicesRequest(){services, error in
                if let error = error{
                    promise(.failure(error))
                }else{
                    promise(.success(services))
                }
            }
        }.eraseToAnyPublisher()
    }
    // MARK: Ad-hoc queries
    
    func getOffer(startCode: String, endCode: String, passengerCount: Int, startDate: Date, completion: @escaping (Offer?, Error?) -> Void){
        offerRequest(startCode: startCode, endCode: endCode, passengerCount: passengerCount, startDate: startDate, completion: completion)
    }
    
    func getStationLocation(){
        var result: [StationLocation] = []
        if let path = Bundle.main.path(forResource: "Stations", ofType: "plist"), let xml = FileManager.default.contents(atPath: path)
        {
            if let list = try? PropertyListDecoder().decode([StationLocation].self, from: xml) {
                result = list
            }
        }
        self.stationLocationList = result
    }
    
    func getTrainLocations(completion: @escaping (TrainLocationList?, Error?) -> Void){
        trainLocationRequest(completion: completion)
    }
    
    func getStationInfo(stationNumberCode: String, completion: @escaping (StationInfo?, Error?) -> Void){
        stationInfoRequest(stationNumberCode: stationNumberCode, completion: completion)
    }
    
    func getTrainInfo(trainId: Int, completion: @escaping (TrainInfo?, Error?)->Void){
        trainInfoRequest(trainId: trainId, completion: completion)
    }
}
