import Foundation
// MARK: - TrainInfo

/// Data on train schedules
struct TrainInfo: Codable {
    
    /// List of scheduled trains
    let trainSchedulerDetails: [TrainSchedulerDetail]?
}

// MARK: - TrainSchedulerDetail

/// Data for a scheduled arrivals/departures of a train
struct TrainSchedulerDetail: Codable {
    
    /// The scheduled train
    let train: Train?
    
    /// List of scheduled arrivals/departures
    let scheduler: [TrainScheduler]?
}

// MARK: - Scheduler

/// Scheduled arrival/departure of a train at a station
struct TrainScheduler: Codable {
    
    /// The relevant station
    let station: Station?
    
    /// Scheduled arrival time
    let arrive: String?
    
    /// Scheduled departure time
    let start: String?
    
    /// Estimated arrival time
    let actualOrEstimatedArrive: String?
    
    /// Estimated departure time
    let actualOrEstimatedStart: String?
    
    /// The arrival track
    let startTrack: String?
    
    /// The departure track
    let endTrack: String?
    
    /// List of services
    let services: [Service]?
    
    /// Kind of stop for the train (e.g. station, stop, etc.)
    let stopKind: Int?
    
    // TODO
    let stopService: Service?
    
    /// Length of the route of the train
    let distance: Int?
    
    /// Departure time zone
    let startTimeZone: String?
    
    /// Arrival time zone
    let arriveTimeZone: String?
}

// MARK: - Train

/// Data on a train
struct Train: Codable {
    
    /// List of services on the train
    let aggregatedServiceIds: [String]?
    
    /// Name of the train
    let name: String?
    
    /// Seat reservation code for the train
    let seatReservationCode: String?
    
    /// Code of the train
    let code: String?
    
    /// Code of the company operating the train
    let companyCode: String?
    
    // TODO
    let startStationReservationCode: String?
    
    // TODO
    let endStationReservationCode: String?
    
    /// Starting station fot the train
    let startStation: Station?
    
    /// Ending station for the train
    let endStation: Station?
    
    /// Starting date for the train
    let startDate: String?
    
    /// Original starting station for the train
    let origStartStation: String?
    
    /// Original ending station for the train
    let origEndStation: String?
    
    /// Starting time for the train
    let start: String?
    
    /// Whether the starting time is only a scheduled
    let virtualStart: Bool
    
    /// Arrival time for the train
    let arrive: String?
    
    /// Whether the arrival time is only scheduled
    let virtualArrive: Bool
    
    /// Length of the route of the train
    let distance: Int?
    
    // TODO
    let closedTrackway: Bool
    
    /// Full name of the train
    let fullName: String?
    
    /// Full name and type of the train
    let fullNameAndType: String?
    
    // TODO
    let kinds: [Kind]?
    
    // TODO
    let kindsToDisplay: [Kind]?
    
    // TODO
    let kind: Kind?
    
    /// List of services at the stations
    let services: [StationService]?
    
    /// Estimated departure time
    let actualOrEstimatedStart: String?
    
    /// Estimated time of arrival (ETA)
    let actualOrEstimatedArrive: String?
    
    /// Additional information in case of a service disturbance
    let havarianInfok: HavarianInfok?
    
    //let directTrains: [Train]
    
    /// Starting track of the train
    let startTrack: String?
    
    /// Ending track of the train
    let endTrack: String?
    
    // TODO
    let jeEszkozAlapId: Int?
    
    /// Full type of the train
    let fullType: String?
    
    /// Shortened type of the train
    let fullShortType: String?
    
    /// Full name with icon of the train
    let fullNameAndPiktogram: FullNameAndPiktogram?
    
    /// Footer data for the train
    let footer: String?
    
    /// Sign of the route the train is operating on
    let viszonylatiJel: ViszonylatiJel?
    
    /// The route the train is operating on
    let viszonylatObject: ViszonylatObject?
    
    /// Description of the train
    let description: String?
    
    // TODO
    let sameCar: Bool
    
    /// Starting station's time zone
    let startTimeZone: String?
    
    /// Ending station's time zone
    let arriveTimeZone: String?
    
    /// ID of the train
    let trainId: String?
}


/// Data Transfer Object (DTO) for train info queries
struct TrainInfoQueryDto: Encodable{
    
    /// Type of query
    let type = "TrainInfo"
    
    /// Date of travel
    let travelDate: String
    
    // TODO
    let minCount = "0"
    
    // TODO
    let maxCount = "9999999"
    
    /// ID of the train
    let trainId: Int
}
