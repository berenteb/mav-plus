import Foundation

/// List of train locations
struct TrainLocationList: Codable {
    
    /// List of the location of the trains
    let Vonatok: [TrainLocation]?
}

/// Data on a train location
struct TrainLocation: Codable {
    
    /// The ID of the train
    let VonatID: String?
    
    /// Code of the train
    let Vonatszam: String?
    
    /// Name of the train
    let Vonatnev: String?
    
    /// Type of the train
    let Tipus: String?
    
    /// Route the train is operating on
    let Viszonylat: Viszonylat?
    
    /// Speed of the train
    let Sebesseg: Int?
    
    /// Delay of the train
    let Keses: Int?
    
    // TODO
    let Menetvonal: String?
    
    /// Latitude of the train's location
    let GpsLat: Double?
    
    /// Longitude of the train's location
    let GpsLon: Double?
    
    /// Latitude of the train's location
    let EGpsLat: Double?
    
    /// Longitude of the train's location
    let EGpsLon: Double?
}

/// Data on a route for trains
struct Viszonylat: Codable {
    
    /// Starting station code
    let InduloAllomasKod: String?
    
    /// Ending station code
    let CelAllomasKod: String?
    
    /// Starting time
    let IndulasIdeje: Int?
    
    /// Ending time
    let ErkezesIdeje: Int?
}

/// Data Transfer Object (DTO) for a location query
struct LocationQueryDto: Encodable{
    
    // TODO
    let UAID = "1-0xLbEm1FRGGO1ENXq912wtCy821e"
    
    /// Language of the query
    let Nyelv = "HU"
}
