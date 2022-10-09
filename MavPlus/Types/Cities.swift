struct City: Codable {
    let cityName: String
    let postalCodes: [String]
}

typealias Cities = [City]
