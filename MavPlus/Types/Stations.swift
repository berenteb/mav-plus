
/// Data on a station
struct Station: Codable {
    
    /// ID of the station
    let id: Int?
    
    /// Whether this station name is an alias for another station
    let isAlias: Bool
    
    /// Name of the station
    let name: String?
    
    /// Code of the station
    let code: String?
    
    /// Base code of the station
    let baseCode: String?
    
    /// Whether this is an international station
    let isInternational: Bool
    
    /// Whether this station can be used for route queries
    let canUseForOfferRequest: Bool
    
    /// Whether this station has information for passengers (e.g. departures, arrivals, etc.)
    let canUseForPessengerInformation: Bool
    
    /// Name of the country this station is in
    let country: String?
    
    /// ISO code of the country this station is in
    let coutryIso: String?
    
    // TODO
    let isIn108_1: Bool
}

typealias StationList = [Station]
