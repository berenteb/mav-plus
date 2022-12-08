import Foundation
import Alamofire


// MARK: Headers
let ContentType = HTTPHeader(name: "Content-Type", value: "application/json")
let Accept = HTTPHeader(name: "Accept", value: "application/json")
let Language = HTTPHeader(name: "Language", value: "hu")
let UserSessionId = HTTPHeader(name: "UserSessionId", value: "9e31260c-4b3e-4da4-825d-2daef339f98c")

// MARK: Cities
/// Gets the cities with postal codes
/// - Parameters:
///     - completion: Callback with data or error
func citiesRequest(completion: @escaping (Cities, Error?) -> Void){
    let request = AF.request(
        CitiesRequestPath,
        method: .post,
        headers: HTTPHeaders(arrayLiteral: ContentType, Accept)
    )
    
    request.responseDecodable(of:Cities.self){ (response) in
        guard let value = response.value else {
            completion([], response.error)
            return
        }
        completion(value, nil)
    }
}

// MARK: Customers
/// Gets customer types and dicount types
/// - Parameters:
///     - completion: Callback with data or error
func customersRequest(completion: @escaping (CustomersAndDiscounts?, Error?) -> Void){
    let body = CustomersQueryDto(offerKind: "InternalTicket")
    let request = AF.request(
        CustomersRequestPath,
        method: .post,
        parameters: body,
        encoder: JSONParameterEncoder.default,
        headers: HTTPHeaders(arrayLiteral: ContentType, Accept)
    )
    
    request.responseDecodable(of:CustomersAndDiscounts.self){ (response) in
        guard let value = response.value else {
            completion(nil, response.error)
            return
        }
        completion(value, nil)
    }
}

// MARK: StationList
/// Gets the station list
/// - Parameters:
///     - completion: Callback with data or error
func stationListRequest(completion: @escaping (StationList, Error?) -> Void){
    let request = AF.request(
        StationsRequestPath,
        method: .post,
        headers: HTTPHeaders(arrayLiteral: ContentType, Accept)
    )
    
    request.responseDecodable(of: StationList.self){ (response) in
        guard let value = response.value else {
            completion([], response.error)
            return
        }
        completion(value, nil)
    }
}

// MARK: Services
/// Gets available services to search for in offers
/// - Parameters:
///     - completion: Callback with data or error
func servicesRequest(completion: @escaping (ServicesDto?, Error?) -> Void){
    let body = ServiceQueryDto(offerKind: "InternalTicket")
    let request = AF.request(
        ServicesRequestPath,
        method: .post,
        parameters: body,
        encoder: JSONParameterEncoder.default,
        headers: HTTPHeaders(arrayLiteral: ContentType, Accept)
    )
    
    request.responseDecodable(of: ServicesDto.self){ (response) in
        guard let value = response.value else {
            completion(nil, response.error)
            return
        }
        completion(value, nil)
    }
}

// MARK: TrainInfo
/// Gets data of a single train
/// - Parameters:
///     - trainId: id of the train to look for
///     - completion: Callback with data or error
func trainInfoRequest(trainId: Int, completion: @escaping (TrainInfo?, Error?) -> Void){
    let body = TrainInfoQueryDto(travelDate: Date().ISO8601Format(), trainId: trainId)
    let request = AF.request(
        TimetableRequestPath,
        method: .post,
        parameters: body,
        encoder: JSONParameterEncoder.default,
        headers: HTTPHeaders(arrayLiteral: ContentType, Language)
    )
    
    request.responseDecodable(of: TrainInfo.self){ (response) in
        guard let value = response.value else {
            completion(nil, response.error)
            return
        }
        completion(value, nil)
    }
}

// MARK: StationInfo
/// Gets data of a single station
/// - Parameters:
///     - stationNumberCode: code of the station to look for
///     - completion: Callback with data or error
func stationInfoRequest(stationNumberCode: String,completion: @escaping (StationInfo?, Error?) -> Void){
    let body = StationInfoQueryDto(travelDate: Date().ISO8601Format(), stationNumberCode: stationNumberCode)
    let request = AF.request(
        TimetableRequestPath,
        method: .post,
        parameters: body,
        encoder: JSONParameterEncoder.default,
        headers: HTTPHeaders(arrayLiteral: ContentType, Language)
    )
    
    request.responseDecodable(of: StationInfo.self){ (response) in
        guard let value = response.value else {
            completion(nil, response.error)
            return
        }
        completion(value, nil)
    }
}

// MARK: Offer
/// Get offer by start, end, passenger count and start date
/// - Parameters:
///     - startCode: Start station code
///     - endCode: End station code
///     - passengerCount: Count of passengers (normal type)
///     - startDate: Date of travel
///     - completion: Callback with data or error
func offerRequest(startCode: String, endCode: String, passengerCount: Int, startDate: Date, completion: @escaping (Offer?, Error?) -> Void){
    let passenger = Passenger(
        passengerCount: passengerCount,
        passengerId: 0,
        customerTypeKey: "HU_44_026-065")
    
    let body = OfferRequestQueryDto(
        startStationCode: startCode,
        endStationCode: endCode,
        passangers: [passenger],
        travelStartDate: startDate.ISO8601Format(),
        travelReturnDate: Date().ISO8601Format()
    )
    
    let request = AF.request(
        OfferRequestPath,
        method: .post,
        parameters: body,
        encoder: JSONParameterEncoder.default,
        headers: HTTPHeaders(arrayLiteral: ContentType, Language, UserSessionId)
    )
    
    request.responseDecodable(of: Offer.self){ (response) in
        guard let value = response.value else {
            completion(nil, response.error)
            return
        }
        completion(value, nil)
    }
}

// MARK: TrainLocation
/// Get train location list (for every train)
/// - Parameters:
///     - completion: Callback with data or error
func trainLocationRequest(completion: @escaping (TrainLocationList?, Error?) -> Void){
    let body = LocationQueryDto()
    let request = AF.request(
        TrainLocationRequestPath,
        method: .post,
        parameters: body,
        encoder: JSONParameterEncoder.default,
        headers: HTTPHeaders(arrayLiteral: ContentType, Accept)
    )
    
    request.responseDecodable(of: TrainLocationList.self){ (response) in
        guard let value = response.value else {
            completion(nil, response.error)
            return
        }
        completion(value, nil)
    }
}
