import Foundation

func citiesRequest(completion: @escaping (Cities, Error?) -> Void){
    let url = URL(string: CitiesRequestPath)!
    var request = URLRequest(url: url)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.httpMethod = "POST"
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if(error != nil){
            return
        }
        guard let data = data else {return}
        do{
            let parsed = try JSONDecoder().decode(Cities.self, from: data)
            DispatchQueue.main.async {
                completion(parsed, nil)
            }
        }catch{
            DispatchQueue.main.async {
                completion([], error)
            }
        }
    }
    
    task.resume()
}

func customersRequest(completion: @escaping (CustomersAndDiscounts?, Error?) -> Void){
    let url = URL(string: CustomersRequestPath)!
    var request = URLRequest(url: url)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.httpMethod = "POST"
    guard let encodedBody = try? JSONEncoder().encode(CustomersQueryDto(offerKind: "InternalTicket")) else {return}
    request.httpBody = encodedBody
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if(error != nil){
            return
        }
        guard let data = data else {return}
        do{
            let parsed = try JSONDecoder().decode(CustomersAndDiscounts.self, from: data)
            DispatchQueue.main.async {
                completion(parsed, nil)
            }
        }catch{
            DispatchQueue.main.async {
                completion(nil, error)
            }
        }
    }
    
    task.resume()
}

func stationListRequest(completion: @escaping (StationList, Error?) -> Void){
    let url = URL(string: StationsRequestPath)!
    var request = URLRequest(url: url)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.httpMethod = "POST"
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if(error != nil){
            return
        }
        guard let data = data else {return}
        do{
            let parsed = try JSONDecoder().decode(StationList.self, from: data)
            DispatchQueue.main.async {
                completion(parsed, nil)
            }
        }catch{
            DispatchQueue.main.async {
                completion([], error)
            }
        }
    }
    
    task.resume()
}

func servicesRequest(completion: @escaping (ServicesDto?, Error?) -> Void){
    let url = URL(string: ServicesRequestPath)!
    var request = URLRequest(url: url)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.httpMethod = "POST"
    guard let encodedBody = try? JSONEncoder().encode(ServiceQueryDto(offerKind: "InternalTicket")) else {return}
    request.httpBody = encodedBody
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if(error != nil){
            return
        }
        guard let data = data else {return}
        do{
            let parsed = try JSONDecoder().decode(ServicesDto.self, from: data)
            DispatchQueue.main.async {
                completion(parsed, nil)
            }
        }catch{
            DispatchQueue.main.async {
                completion(nil, error)
            }
        }
    }
    
    task.resume()
}

func stationInfoRequest(stationNumberCode: String,completion: @escaping (StationInfo?, Error?) -> Void){
    let url = URL(string: TimetableRequestPath)!
    var request = URLRequest(url: url)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("hu", forHTTPHeaderField: "Language")
    request.httpMethod = "POST"
    let body = StationInfoQueryDto(travelDate: Date().ISO8601Format(), stationNumberCode: stationNumberCode)
    guard let encodedBody = try? JSONEncoder().encode(body) else {return}
    request.httpBody = encodedBody
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if(error != nil){
            return
        }
        guard let data = data else {return}
        do{
            let parsed = try JSONDecoder().decode(StationInfo.self, from: data)
            DispatchQueue.main.async {
                completion(parsed, nil)
            }
        }catch{
            DispatchQueue.main.async {
                print(error)
                completion(nil, error)
            }
        }
    }
    
    task.resume()
}

func offerRequest(startCode: String, endCode: String, passengerCount: Int, startDate: Date, completion: @escaping (Offer?, Error?) -> Void){
    let url = URL(string: OfferRequestPath)!
    var request = URLRequest(url: url)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("hu", forHTTPHeaderField: "Language")
    request.setValue("9e31260c-4b3e-4da4-825d-2daef339f98c", forHTTPHeaderField: "UserSessionId")
    request.httpMethod = "POST"
    
    let passenger = Passenger(passengerCount: passengerCount, passengerId: 0, customerTypeKey: "HU_44_026-065")
    
    let body = OfferRequestQueryDto(startStationCode: startCode, endStationCode: endCode, passangers: [passenger], travelStartDate: startDate.ISO8601Format(), travelReturnDate: Date().ISO8601Format())
    
    guard let encodedBody = try? JSONEncoder().encode(body) else {return}
    request.httpBody = encodedBody
    print(body)
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if(error != nil){
            return
        }
        guard let data = data else {return}
        do{
            let parsed = try JSONDecoder().decode(Offer.self, from: data)
            DispatchQueue.main.async {
                completion(parsed, nil)
            }
        }catch{
            DispatchQueue.main.async {
                print(error)
                completion(nil, error)
            }
        }
    }
    
    task.resume()
}

func trainLocationRequest(completion: @escaping (TrainLocationList?, Error?) -> Void){
    let url = URL(string: TrainLocationRequestPath)!
    var request = URLRequest(url: url)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.httpMethod = "POST"
    let body = LocationQueryDto()
    guard let encodedBody = try? JSONEncoder().encode(body) else {return}
    request.httpBody = encodedBody
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if(error != nil){
            return
        }
        guard let data = data else {return}
        do{
            let parsed = try JSONDecoder().decode(TrainLocationList.self, from: data)
            DispatchQueue.main.async {
                completion(parsed, nil)
            }
        }catch{
            DispatchQueue.main.async {
                print(error)
                completion(nil, error)
            }
        }
    }
    
    task.resume()
}
