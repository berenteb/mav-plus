import Foundation
// MARK: - TrainInfo
struct TrainInfo: Codable {
    let trainSchedulerDetails: [TrainSchedulerDetail]?
}

// MARK: - TrainSchedulerDetail
struct TrainSchedulerDetail: Codable {
    let train: Train?
    let scheduler: [TrainScheduler]?
}

// MARK: - Scheduler
struct TrainScheduler: Codable {
    let station: Station?
    let arrive, start, actualOrEstimatedArrive, actualOrEstimatedStart: String?
    let startTrack, endTrack: String?
    let services: [Service]?
    let stopKind: Int?
    let stopService: Service?
    let distance: Int?
    let startTimeZone, arriveTimeZone: String?
}

// MARK: - Train
struct Train: Codable {
    let aggregatedServiceIds: [String]?
    let name, seatReservationCode, code: String?
    let companyCode: String?
    let startStationReservationCode, endStationReservationCode: String?
    let startStation, endStation: Station?
    let startDate, origStartStation, origEndStation: String?
    let start: String?
    let virtualStart: Bool
    let arrive: String?
    let virtualArrive: Bool
    let distance: Int?
    let closedTrackway: Bool
    let fullName, fullNameAndType: String?
    let kinds, kindsToDisplay: [Kind]?
    let kind: Kind?
    let services: [StationService]?
    let actualOrEstimatedStart, actualOrEstimatedArrive: String?
    let havarianInfok: HavarianInfok?
    let directTrains, startTrack, endTrack: String?
    let jeEszkozAlapId: Int?
    let fullType, fullShortType: String?
    let fullNameAndPiktogram: FullNameAndPiktogram?
    let footer: String?
    let viszonylatiJel: ViszonylatiJel?
    let viszonylatObject: ViszonylatObject?
    let description: String?
    let sameCar: Bool
    let startTimeZone, arriveTimeZone: String?
    let trainId: String?
}


struct TrainInfoQueryDto: Encodable{
    let type = "TrainInfo"
    let travelDate: String
    let minCount = "0"
    let maxCount = "9999999"
    let trainId: Int
}
