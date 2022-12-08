import Foundation
// MARK: - StationInfo

/// Data on a station
struct StationInfo: Codable {
    
    /// Details on train scheduler
    let trainSchedulerDetails: TrainSchedulerDetail?
    
    /// Details on station scheduler
    let stationSchedulerDetails: StationSchedulerDetails?
    
    /// Details on route scheduler
    let routeSchedulerDetails: TrainSchedulerDetail?
}

// MARK: - StationSchedulerDetails

/// Station scheduler
struct StationSchedulerDetails: Codable {
    
    /// Data for the station
    let station: Station?
    
    /// Arrivals
    let arrivalScheduler: [Scheduler]?
    
    /// Departures
    let departureScheduler: [Scheduler]?
    
    /// Available services at the station
    let services: [StationService]?
    
    // TODO
    let moreResult: Bool
}

// MARK: - Scheduler

/// Schedule data
struct Scheduler: Codable {
    
    /// List of service IDs
    let aggregatedServiceIds: [String]
    
    /// Name of the scheduled train
    let name: String?
    
    /// Code of the seat reservations
    let seatReservationCode: String?
    
    /// Code of the train
    let code: String?
    
    /// Code of the company operating the train
    let companyCode: String?
    
    // TODO
    let startStationReservationCode: String?
    
    // TODO
    let endStationReservationCode: String?
    
    //let route:
    
    /// Name of the start station
    let startStation: Station?
    
    /// Name of the end station
    let endStation: Station?
    
//    let startDate: JSONNull?
//    let origStartStation: JSONNull?
//    let origEndStation: JSONNull?
    
    /// Starting time
    let start: String?
    
    /// Whether the starting time is only scheduled
    let virtualStart: Bool
    
    /// Arrival time
    let arrive: String?
    
    /// Whether the arrival time is only scheduled
    let virtualArrive: Bool
    
    /// Length of the route of the train
    let distance: Int?
    
    // TODO
    let closedTrackway: Bool
    
    /// Full name of the train
    let fullName: String?
    
    /// Full name and type ofthe train
    let fullNameAndType: String?
    
    // TODO
    let kinds: [Kind]
    
    // TODO
    let kindsToDisplay: [Kind]
    
    // TODO
    let kind: Kind?
    
    /// Starting track of the train
    let startTrack: String?
    
    /// Ending track of the train
    let endTrack: String?
    
    //let services: [Service?]?
    
    /// Estimated start time
    let actualOrEstimatedStart: String?
    
    /// Estimated Time of Arrival (ETA)
    let actualOrEstimatedArrive: String?
    
    /// Additional informatino in case of a service disturbance
    let havarianInfok: HavarianInfok?
    
//    let directTrains: JSONNull?
//    let carrierTrains: JSONNull?
//    let startTrack: JSONNull?
//    let endTrack: JSONNull?
    
    // TODO
    let jeEszkozAlapId: Int?
    
    /// Full type of the train
    let fullType: String?
    
    /// Shortened type of the train
    let fullShortType: String?
    
    /// Full name with icon of the train
    let fullNameAndPiktogram: FullNameAndPiktogram?
    
    /// Footer data of the train
    let footer: String?
    
    /// Sign of the route the train is operating on
    let viszonylatiJel: ViszonylatiJel?
    
    /// Sign of the train is operating on
    let viszonylatObject: ViszonylatObject?
    
    /// Description of the train
    let description: String?
    
    // TODO
    let sameCar: Bool
    
    /// Time zone of the starting station
    let startTimeZone: String?
    
    /// Time zone of the ending station
    let arriveTimeZone: String?
    
    /// ID of the train
    let trainId: String?
}

// MARK: - FullNameAndPiktogram

/// Full name and icon of a train
struct FullNameAndPiktogram: Codable {
    
    // TODO
    let collection: String?

    // TODO
    enum CodingKeys: String, CodingKey {
        // TODO
        case collection = "(Collection)"
    }
}

// MARK: - HavarianInfok

/// Additional information in case of a service disturbance
struct HavarianInfok: Codable {
    
    /// Current delay
    let aktualisKeses: Int?
    
    /// Reason for the delay
    let kesesiOk: String?
    
    /// Additional information
    let havariaInfo: [String]?
    
    // TODO
    let uzletiInfo: String?
    
    /// Information on the delay
    let kesesInfo: String?
}

// MARK: - Kind

// TODO
struct Kind: Codable {
    
    /// Name of the Kind
    let name: String?
    
    // TODO
    let sortName: String?
    
    /// Code for the Kind
    let code: String?
    
    // TODO
    let priority: Int?
    
    /// Color code of the background
    let backgroundColorCode: String?
    
    /// Color code of the foreground
    let foregroundColorCode: String?
    
    /// Sign
    let sign: Sign?
    
    /// Starting station
    let startStation: Station?
    
    /// Ending station
    let endStation: Station?
}

// MARK: - Sign

/// An icon
struct Sign: Codable {
    
    /// Name of the font for the icon
    let fontName: String?
    
    /// Character of the icon
    let character: String?
}

// MARK: - Service

// TODO
struct StationService: Codable {
    
    // TODO
    let listOrder: String?
    
    /// Description of the service
    let description: String?
    
    // TODO
    let restrictiveStartStationCode: String?
    
    // TODO
    let restrictiveEndStationCode: String?
    
    /// Sign of the service
    let sign: Sign?
    
    /// Kind of stop (e.g. station, stop, etc.)
    let trainStopKind: String?
}

// MARK: - ViszonylatObject

/// Data on a route
struct ViszonylatObject: Codable {
    
    /// Code of the starting station of the route
    let startStationCode: String?
    
    /// Starting time
    let startTime: String?
    
    /// Time zone of the starting station
    let startTimeZone: String?
    
    /// Code of the ending station of the route
    let endStationCode: String?
    
    /// Ending time
    let endTime: String?
    
    /// Time zone of the ending station
    let endTimeZone: String?
    
    /// Estimated travel time
    let travelTime: Int?
    
//    let startTrack: JSONNull?
//    let endTrack: JSONNull?
    
    /// Code of stations on the route
    let innerStationCodes: [String]?
}

// MARK: - ViszonylatiJel

/// Icon for a route
struct ViszonylatiJel: Codable {
    
    /// Name of the icon
    let piktogramFullName: String?
    
    /// Code of the text's color
    let fontSzinKod: String?
    
    /// Code of the background's color
    let hatterSzinKod: String?
    
    /// Sign of the route
    let sign: Sign?
    
    /// Name of the route
    let jel: String?
}

/// Data Transfer Object (DTO) for station info queries
struct StationInfoQueryDto: Encodable{
    
    /// Type of query
    let type = "StationInfo"
    
    /// Date of travel
    let travelDate: String
    
    // TODO
    let minCount = "0"
    
    // TODO
    let maxCount = "9999999"
    
    /// Code of the station
    let stationNumberCode: String
}
