/// Data type representing a city
struct City: Codable {
    
    /// Name of the city
    let cityName: String
    
    /// List of postal codes in the city
    let postalCodes: [String]
}

typealias Cities = [City]
