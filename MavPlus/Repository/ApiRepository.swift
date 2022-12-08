import Foundation
import Combine

/// Station location with code and coordinates
struct StationLocation: Decodable {
    var code: String
    var lat: Double?
    var lon: Double?
}

/// ApiProtocol singleton to store data which is barely updated and to proxy other requests
protocol ApiProtocol: Updateable, RequestStatus{
    /// Singleton instance
    static var shared: any ApiProtocol {get}
    /// Cities with postal codes
    var cities: Cities {get}
    /// Customer types and discounts
    var customers: CustomersAndDiscounts? {get}
    /// Station list
    var stationList: StationList {get}
    /// Station locations
    var stationLocationList: [StationLocation] {get}
    /// Search services
    var services: ServicesDto? {get}
    /// Get offer by start, end, passenger count and start date
    /// - Parameters:
    ///     - startCode: Start station code
    ///     - endCode: End station code
    ///     - passengerCount: Count of passengers (normal type)
    ///     - startDate: Date of travel
    ///     - completion: Callback with data or error
    func getOffer(startCode: String, endCode: String, passengerCount: Int, startDate: Date, completion: @escaping (Offer?, Error?) -> Void) -> Void
    /// Get train location list (for every train)
    /// - Parameters:
    ///     - completion: Callback with data or error
    func getTrainLocations(completion: @escaping (TrainLocationList?, Error?) -> Void)
    /// Get info for a single station
    /// - Parameters:
    ///     - stationNumberCode: code of station
    ///     - completion: Callback with data or error
    func getStationInfo(stationNumberCode: String, completion: @escaping (StationInfo?, Error?) -> Void)
    /// Get info for a single train
    /// - Parameters:
    ///     - trainId: id of train
    ///     - completion: Callback with data or error
    func getTrainInfo(trainId: Int, completion: @escaping (TrainInfo?, Error?)->Void)
    /// Notifies whether data is available
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
    var cities: Cities = []
    var customers: CustomersAndDiscounts?
    var stationList: StationList = []
    var services: ServicesDto?
    var stationLocationList: [StationLocation] = []
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
            .receive(on: DispatchQueue.main)
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
            })
            .store(in: &cancellableSet)
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
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
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
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
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
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
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
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
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
