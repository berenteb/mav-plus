import Foundation
import Alamofire


// MARK: Headers
let ContentType = HTTPHeader(name: "Content-Type", value: "application/json")
let Accept = HTTPHeader(name: "Accept", value: "application/json")
let Language = HTTPHeader(name: "Language", value: "hu")
let UserSessionId = HTTPHeader(name: "UserSessionId", value: "9e31260c-4b3e-4da4-825d-2daef339f98c")

// MARK: Cities
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
