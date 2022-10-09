import Foundation
// MARK: - StationInfo
struct StationInfo: Codable {
    let trainSchedulerDetails: TrainSchedulerDetail?
    let stationSchedulerDetails: StationSchedulerDetails?
    let routeSchedulerDetails: TrainSchedulerDetail?
}

// MARK: - StationSchedulerDetails
struct StationSchedulerDetails: Codable {
    let station: Station?
    let arrivalScheduler, departureScheduler: [Scheduler]?
    let services: [StationService]?
    let moreResult: Bool
}

// MARK: - Scheduler
struct Scheduler: Codable {
    let aggregatedServiceIds: [String]
    let name: String?
    let seatReservationCode, code: String?
    let companyCode, startStationReservationCode, endStationReservationCode: String?
    //let route:
    let startStation, endStation: Station?
    //let startDate, origStartStation, origEndStation: JSONNull?
    let start: String?
    let virtualStart: Bool
    let arrive: String?
    let virtualArrive: Bool
    let distance: Int?
    let closedTrackway: Bool
    let fullName, fullNameAndType: String?
    let kinds, kindsToDisplay: [Kind]
    let kind: Kind?
    //let services: [Service?]?
    let actualOrEstimatedStart, actualOrEstimatedArrive: String?
    let havarianInfok: HavarianInfok?
    //let directTrains, carrierTrains, startTrack, endTrack: JSONNull?
    let jeEszkozAlapId: Int?
    let fullType: String?
    let fullShortType: String?
    let fullNameAndPiktogram: FullNameAndPiktogram?
    let footer: String?
    let viszonylatiJel: ViszonylatiJel?
    let viszonylatObject: ViszonylatObject?
    let description: String?
    let sameCar: Bool
    let startTimeZone: String?
    let arriveTimeZone: String?
    let trainId: String?
}

// MARK: - FullNameAndPiktogram
struct FullNameAndPiktogram: Codable {
    let collection: String?

    enum CodingKeys: String, CodingKey {
        case collection = "(Collection)"
    }
}

// MARK: - HavarianInfok
struct HavarianInfok: Codable {
    let aktualisKeses: Int?
    let kesesiOk: String?
    let havariaInfo: [String]?
    let uzletiInfo: String?
    let kesesInfo: String?
}

// MARK: - Kind
struct Kind: Codable {
    let name: String?
    let sortName: String?
    let code: String?
    let priority: Int?
    let backgroundColorCode: String?
    let foregroundColorCode: String?
    let sign: Sign?
    let startStation, endStation: Station?
}

// MARK: - Sign
struct Sign: Codable {
    let fontName: String?
    let character: String?
}

// MARK: - Service
struct StationService: Codable {
    let listOrder: String?
    let description: String?
    let restrictiveStartStationCode, restrictiveEndStationCode: String?
    let sign: Sign?
    let trainStopKind: String?
}

// MARK: - ViszonylatObject
struct ViszonylatObject: Codable {
    let startStationCode: String?
    let startTime: String?
    let startTimeZone: String?
    let endStationCode: String?
    let endTime: String?
    let endTimeZone: String?
    let travelTime: Int?
    //let startTrack, endTrack: JSONNull?
    let innerStationCodes: [String]?
}

// MARK: - ViszonylatiJel
struct ViszonylatiJel: Codable {
    let piktogramFullName: String?
    let fontSzinKod: String?
    let hatterSzinKod: String?
    let sign: Sign?
    let jel: String?
}

struct StationInfoQueryDto: Encodable{
    let type = "StationInfo"
    let travelDate: String
    let minCount = "0"
    let maxCount = "9999999"
    let stationNumberCode: String
}
