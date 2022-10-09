// MARK: - Offer
struct Offer: Codable {
    let isOfDetailedSearch: Bool?
    let route: [OfferRoute]?
    //let warningMessages: [JSONAny]
}

// MARK: - OfferRoute
struct OfferRoute: Codable {
    let sameOfferId: Int?
    let offerGroupCode, offerIdentity: String?
    let routeServices: [RouteService]?
    let transfersCount: Int?
    let travelRouteLength: String?
    let departure, arrival: Arrival?
    let travelTimeMin: String?
    let name: String?
    let lastStation: String?
    let departureTrack, arrivalTrack: Track?
    let services: Services?
    let travelClasses: [TravelClass]?
    let details: Details?
    let serializedOfferData: String?
    let szabadHelyAllapot: Int?
    let onlyForRegisteredUser: Bool
    let aggregatedServiceIds: [Int]
    let orderDisabled: Bool
    let orderDisabledReason: String?
}

// MARK: - Arrival
struct Arrival: Codable {
    let time, timeExpected, timeFact: String?
    let delayMin: Int?
    let timeZone: String?
}

// MARK: - Track
struct Track: Codable {
    let name, changedTrackName: String?
}

// MARK: - Details
struct Details: Codable {
    let distance: Int?
    let trainFullName: String?
    //let days: JSONNull?
    let tickets: [Ticket]?
    let routes: [DetailsRoute]?
    let hasPlaceTicket: Bool
    let placeTicketDutyDeviceNumber: Int?
}

// MARK: - DetailsRoute
struct DetailsRoute: Codable {
    let serviceIds: [Int]?
    let trainDetails: TrainDetails?
    let departure, arrival: Arrival?
    let services: Services?
    let departureTrack, arrivalTrack: Track?
    let sameCar: Bool
    let travelClasses: [TravelClass]?
    let startStation, destionationStation: DestionationStationClass?
    let touchedStationsString: String?
    let havariaInfo: HavarianInfok?
    let distance: Int?
    let description: String?
    let masodlagosEszkozSzolgaltatasok: [MasodlagosEszkozSzolgaltatasok]?
    let travelTime: String?
}

// MARK: - DestionationStationClass
struct DestionationStationClass: Codable {
    let name: String?
    let code: String?
    let arrivalTime, departureTime: String?
}

// MARK: - MasodlagosEszkozSzolgaltatasok
struct MasodlagosEszkozSzolgaltatasok: Codable {
    let services: [String]?
    let eszkozSzam, kozlekedesiTarsasagKod: String?
}

// MARK: - Services
struct Services: Codable {
    let train, station: [RouteService]?
}

// MARK: - RouteService
struct RouteService: Codable {
    let listOrder: String?
    let description: String?
    let restrictiveStartStationCode: String?
    let restrictiveEndStationCode: String?
    let sign: Sign?
    let trainStopKind: String?
}

// MARK: - TrainDetails
struct TrainDetails: Codable {
    let viszonylatiJel: ViszonylatiJel?
    let trainKind: TrainKind?
    let type: String?
    let name, trainNumber, trainId, jeId: String?
    let kozlekedesiTarsasagKod: String?
}

// MARK: - Kind
struct TrainKind: Codable {
    let name: String?
    let sortName: String?
    let code: String?
    let priority: Int?
    let backgroundColorCode: String?
    let foregroundColorCode: String?
    let sign: Sign?
    let startStation, endStation: EndStationClass?
}

// MARK: - EndStationClass
struct EndStationClass: Codable {
    let id: Int?
    let isAlias: Bool
    let name: String?
    let code: String?
    let baseCode: String?
    let isInternational, canUseForOfferRequest, canUseForPessengerInformation: Bool
    let country: String?
    let coutryIso: String?
    let isIn108_1: Bool
}

// MARK: - TravelClass
struct TravelClass: Codable {
    let name: String?
    let fullness: Int?
    let price: Price?
}

// MARK: - Price
struct Price: Codable {
    let amount, amountInDefaultCurrency: Int?
    let currency: PriceCurrency?
}

// MARK: - PriceCurrency
struct PriceCurrency: Codable {
    let name, uicCode: String?
}

// MARK: - Ticket
struct Ticket: Codable {
    let offerId: String?
    let serviceId, serverServiceInformation: String?
    let name: String?
    let price1stClass, price2ndClass, fullness, passengerId: Int?
    let takeOverModes: [String]?
    let offerValidFrom: String?
    //let namedAdditionals: [JSONAny]
    let offerValidTo: String?
    let clientDiscounts: [ClientDiscount]
    let customerCountDiscountName, carClassNumber: String?
    let carClassIndependent, placeReservationNeeded, quotaReservationNeeded: Bool
    let allowedInvoiceKind: Int?
    let discountedGrossPrice, grossPrice, grossUnitPrice, grossPriceExchanged: DiscountedGrossPrice?
    let grossUnitPriceExchanged: DiscountedGrossPrice?
    let isGroup: Bool
    let direction: Int?
    let directionDescription: String?
    let customerTypeDiscountName: String?
    let discountName: String?
    let trainDependent, refundable: Bool
    let cacheRenewParams: Params?
    let clientDiscount: [ClientDiscount]?
    let isInternational: Bool
    let placeTicket: PlaceTicket?
    let placeTicketSerialized: String?
    let ticketReferenceCode: String?
    let startStation: EndStationClass?
    let touchedStations: [EndStationClass]?
    let endStation: EndStationClass?
    let amount: Int?
    let companyCode: String?
    let distance: Int?
}

// MARK: - Params
struct Params: Codable {
    let reserved, reservationFixed: Bool
    let reservationCode: String?
    let allowedOvertime: Int?
    let lastReservationTime: String?
    let paymentDeadline: String?
    let reservationID: String?
}

// MARK: - ClientDiscount
struct ClientDiscount: Codable {
    let discountScale: Int?
    let grossPrice, netPrice: DiscountedGrossPrice?
    let takeoverMode: Int?
    let paymentMode: String?
    let discountReason: String?
}

// MARK: - DiscountedGrossPrice
struct DiscountedGrossPrice: Codable {
    let amountInDefaultCurrency, amount: Double?
    let currency: DiscountedGrossPriceCurrency?
}

// MARK: - DiscountedGrossPriceCurrency
struct DiscountedGrossPriceCurrency: Codable {
    let key, name: String?
    let isDefault: Bool?
}

// MARK: - PlaceTicket
struct PlaceTicket: Codable {
    let ticketId: Int?
    //let certificateID, placeReservationServices, nearCarriageNumber, nearSeatPosition: String?
    let reservationType: Int?
    let reservationKind: String?
    let placeReservationServicesFilled: Bool
    let uicReservationCode, carriageNumber, seatPosition, location: String?
    let customerTypeDiscountName: String?
    let isGroup, forGrouppedFareTicket: Bool
    let train: TicketTrain?
    let trainCode: String?
    let startStationCode: String?
    let endStationCode: String?
    let startTime, arriveTime, specialisHelyAdatok: String?
    let serviceCode: String?
    let hkGuid: String?
    let tarifa: String?
    let isInternational: Bool
    let kapcsoltHelyfoglalasID, kapcsoltAjanlat: String?
    let globalDij: Bool
    let vacantPlaceCount: Int?
    let vacantPlaceCountUpdateTime: String?
    let quotaReservationHandlingParams: Params?
    let reserved, reservationFixed: Bool
    let reservationCode: String?
    let allowedOvertime: Int?
    let lastReservationTime: String?
    let paymentDeadline: String?
    let reservationID: String?
}

// MARK: - Train
struct TicketTrain: Codable {
    let aggregatedServiceIds: [String]?
    let name, seatReservationCode, code, companyCode: String?
    let startStationReservationCode, endStationReservationCode: String?
    let startStation, endStation: EndStationClass?
    let startDate: String?
    let origStartStation, origEndStation: EndStationClass?
    let start: String?
    let virtualStart: Bool
    let arrive: String?
    let virtualArrive: Bool
    let distance: Int
    let closedTrackway: Bool
    let fullName, fullNameAndType: String?
    let kinds: [Kind]
    let kindsToDisplay: String?
    let kind: Kind?
    let services: [RouteService]
    let actualOrEstimatedStart, actualOrEstimatedArrive: String?
    let havarianInfok: HavarianInfok
    let directTrains, carrierTrains, startTrack, endTrack: String?
    let jeEszkozAlapId: Int?
    let fullType: String?
    let fullShortType: String?
    let fullNameAndPiktogram: FullNameAndPiktogram?
    let footer, viszonylatiJel: String?
    let viszonylatObject: ViszonylatObject?
    let description: String?
    let sameCar: Bool
    let startTimeZone, arriveTimeZone: String?
    let trainId: String?
}

struct OfferRequestQueryDto: Codable {
    var offerkind = "1"
    let startStationCode, endStationCode: String
    var innerStationsCodes: [String] = []
    var passangers: [Passenger]
    var isOneWayTicket: Bool = true
    var isTravelEndTime: Bool = false
    var isSupplementaryTicketsOnly: Bool = false
    let travelStartDate: String
    let travelReturnDate: String
    var selectedServices: [Int] = []
    var selectedSearchServices: [String] = []
    var eszkozSzamok: [Int] = []
    var isOfDetailedSearch: Bool = false
}

// MARK: - Passenger
struct Passenger: Codable {
    let passengerCount, passengerId: Int
    let customerTypeKey: String
    var customerDiscountsKeys: [String] = []
}
