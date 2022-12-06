// MARK: - Offer

/// Data type representing a direction offer
struct Offer: Codable {
    
    /// Whether the query resulting in this offer was in detailed mode
    let isOfDetailedSearch: Bool?
    
    /// The parts of the proposed route
    let route: [OfferRoute]?
    
    // TODO
    //let warningMessages: [JSONAny]
}

// MARK: - OfferRoute

/// Data type representing the parts of an Offer
struct OfferRoute: Codable {
    
    // TODO
    let sameOfferId: Int?
    
    // TODO
    let offerGroupCode: String?
    
    // TODO
    let offerIdentity: String?
    
    /// List of services on the part of the route
    let routeServices: [RouteService]?
    
    // TODO: number of transfers on this route?
    let transfersCount: Int?
    
    /// Length of this part of the route
    let travelRouteLength: String?
    
    /// Data of the departure of this part of the route
    let departure: Arrival?
    
    /// Data of the arrival of this part of the route
    let arrival: Arrival?
    
    /// The length of the part of the route in minutes
    let travelTimeMin: String?
    
    /// Name of the part of the route
    let name: String?
    
    /// Name of the last station along this part of the route
    let lastStation: String?
    
    /// The departure track for this part of the route
    let departureTrack: Track?
    
    /// The arrival track for this part of the route
    let arrivalTrack: Track?
    
    /// The list of services on the train, and along the route
    let services: Services?
    
    /// The available classes on the train on this part of the route
    let travelClasses: [TravelClass]?
    
    /// Details of this part of the route
    let details: Details?
    
    // TODO
    let serializedOfferData: String?
    
    /// Whether there is still available seats for this part of the route
    let szabadHelyAllapot: Int?
    
    // TODO
    let onlyForRegisteredUser: Bool
    
    // TODO
    let aggregatedServiceIds: [Int]
    
    /// Whether a ticket can be bought for this part of the route
    let orderDisabled: Bool
    
    /// If a ticket cannot be bought for this part of the route, the reasoning behind it
    let orderDisabledReason: String?
}

// MARK: - Arrival

/// The time data of the departure/arrival of a train at a station
struct Arrival: Codable {
    
    // TODO
    let time: String?
    
    /// The expected time of arrival at this point
    let timeExpected: String?
    
    /// The actual time of arrival at this point
    let timeFact: String?
    
    /// The number of minutes of delay the train accumulated
    let delayMin: Int?
    
    /// The time zone of the point where the train has to arrive at/depart from
    let timeZone: String?
}

// MARK: - Track

/// Data type representing the arrival/departing track of a train at a station
struct Track: Codable {
    
    /// Name of the track (e.g. 1, A, 3B, etc.)
    let name: String?
    
    /// Name of the track this arrival/departure was changed to
    let changedTrackName: String?
}

// MARK: - Details

/// Data type representing details of a part of a route (OfferRoute)
struct Details: Codable {
    
    /// The length of the part of the route
    let distance: Int?
    
    /// The full name of the train on the part of the route
    let trainFullName: String?
    
    // TODO
    //let days: JSONNull?
    
    /// The tickets associated with this part of the route
    let tickets: [Ticket]?
    
    /// Even more details for parts of this route
    let routes: [DetailsRoute]?
    
    /// Whether a seat reservation is required for this part of the route
    let hasPlaceTicket: Bool
    
    // TODO
    let placeTicketDutyDeviceNumber: Int?
}

// MARK: - DetailsRoute

/// Details of a part of a route in Details
struct DetailsRoute: Codable {
    
    /// List of IDs of services available on this part of the route
    let serviceIds: [Int]?
    
    /// Details of the train on this part of the route
    let trainDetails: TrainDetails?
    
    /// Data of the departure of this part of the route
    let departure: Arrival?
    
    /// Data of the arrival of this part of the route
    let arrival: Arrival?
    
    /// The available services on this part of the route
    let services: Services?
    
    /// The departure track for this part of the route
    let departureTrack: Track?
    
    /// The arrival track for this part of the route
    let arrivalTrack: Track?
    
    // TODO
    let sameCar: Bool
    
    /// The available travel classes on this part of the route
    let travelClasses: [TravelClass]?
    
    /// Data for the starting station of this part of the route
    let startStation: DestionationStationClass?
    
    /// Data for the ending station of this part of the route
    let destionationStation: DestionationStationClass?
    
    /// List of stations on this part of the route
    let touchedStationsString: String?
    
    /// Additional information in case of unexpected events
    let havariaInfo: String?
    
    /// The length of this part of the route
    let distance: Int?
    
    /// The description of this part of the route
    let description: String?
    
    // TODO
    let masodlagosEszkozSzolgaltatasok: [MasodlagosEszkozSzolgaltatasok]?
    
    /// The amount of time this part of the route takes
    let travelTime: String?
}

// MARK: - DestionationStationClass

/// Data for a station along a part of a route
struct DestionationStationClass: Codable {
    
    /// Name of the station
    let name: String?
    
    /// Code of the station
    let code: String?
    
    /// The time of arrival at the station
    let arrivalTime: String?
    
    /// The time of departure at the station
    let departureTime: String?
}

// MARK: - MasodlagosEszkozSzolgaltatasok

// TODO
struct MasodlagosEszkozSzolgaltatasok: Codable {
    
    // TODO
    let services: [String]?
    
    // TODO
    let eszkozSzam: String?
    
    // TODO
    let kozlekedesiTarsasagKod: String?
}

// MARK: - Services

/// The list of services on the train, and along a part of a route
struct Services: Codable {
    
    /// The list of services on the train
    let train: [RouteService]?
    
    /// The list of services at the station
    let station: [RouteService]?
}

// MARK: - RouteService

// TODO
struct RouteService: Codable {
    
    // TODO
    let listOrder: String?
    
    // TODO
    let description: String?
    
    // TODO
    let restrictiveStartStationCode: String?
    
    // TODO
    let restrictiveEndStationCode: String?
    
    /// Font to use with the station
    let sign: Sign?
    
    /// Kind of stop (station, stop, etc.)
    let trainStopKind: String?
}

// MARK: - TrainDetails

/// Details about a train
struct TrainDetails: Codable {
    
    /// Sign of the route it's traveling on
    let viszonylatiJel: ViszonylatiJel?
    
    /// The kind of the train
    let trainKind: TrainKind?
    
    /// The type of the train
    let type: String?
    
    /// The name of the train
    let name: String?
    
    /// The number of the train
    let trainNumber: String?
    
    /// The ID of the train
    let trainId: String?
    
    // TODO
    let jeId: String?
    
    /// The code of the company the train is operated by
    let kozlekedesiTarsasagKod: String?
}

// MARK: - Kind

/// Data type with the kind of a train
struct TrainKind: Codable {
    
    /// Name of the train type
    let name: String?
    
    // TODO
    let sortName: String?
    
    /// Code of the train type
    let code: String?
    
    // TODO
    let priority: Int?
    
    /// Color of the background of the train
    let backgroundColorCode: String?
    
    /// Color of the foreground of the train
    let foregroundColorCode: String?
    
    /// Font to use with the train
    let sign: Sign?
    
    /// Starting station of the train
    let startStation: EndStationClass?
    
    /// Ending station of the train
    let endStation: EndStationClass?
}

// MARK: - EndStationClass

/// Data about a starting/ending station of a train
struct EndStationClass: Codable {
    
    /// ID of the station
    let id: Int?
    
    /// Whether this is an alias name for a station
    let isAlias: Bool
    
    /// Name of the station
    let name: String?
    
    /// Code of the station
    let code: String?
    
    /// Base code of the station
    let baseCode: String?
    
    /// Whether the station is not located domestically
    let isInternational: Bool
    
    /// Whether the station can be used when planning a route
    let canUseForOfferRequest: Bool
    
    /// Whether the station has information for passengers
    let canUseForPessengerInformation: Bool
    
    /// Country the station is located in
    let country: String?
    
    /// ISO code of the country the station is located in
    let coutryIso: String?
    
    // TODO
    let isIn108_1: Bool
}

// MARK: - TravelClass

/// Data about a travel class on a train
struct TravelClass: Codable {
    
    /// Name of the class
    let name: String?
    
    /// How full the class is on this train
    let fullness: Int?
    
    /// Price information on the class
    let price: Price?
}

// MARK: - Price

/// Price of a TravelClass on a train
struct Price: Codable {
    
    /// Price
    let amount: Int?
    
    /// Price in default currency
    let amountInDefaultCurrency: Int?
    
    /// Currency of amount
    let currency: PriceCurrency?
}

// MARK: - PriceCurrency

/// Currency associated with a Price
struct PriceCurrency: Codable {
    
    /// Name of the currency
    let name: String?
    
    /// UIC code of the currency
    let uicCode: String?
}

// MARK: - Ticket

/// Data type of a ticket
struct Ticket: Codable {
    
    /// ID of the Offer this ticket is valid for
    let offerId: String?
    
    // TODO
    let serviceId: String?
    
    // TODO
    let serverServiceInformation: String?
    
    /// Name of the ticket
    let name: String?
    
    /// Price of the first class
    let price1stClass: Int?
    
    /// Price of the second class
    let price2ndClass: Int?
    
    /// How full the train is
    let fullness: Int?
    
    /// ID of the passenger this ticket is for
    let passengerId: Int?
    
    // TODO
    let takeOverModes: [String]?
    
    /// Starting of the validity of the ticket
    let offerValidFrom: String?
    //let namedAdditionals: [JSONAny]
    
    /// Ending of the validity of the ticket
    let offerValidTo: String?
    
    /// Discounts the client has for this ticket
    let clientDiscounts: [ClientDiscount]
    
    /// Name of the discount the client has for this ticket
    let customerCountDiscountName: String?
    
    /// Class of the car this ticket is valid in
    let carClassNumber: String?
    
    /// Whether the class of this car is independent from the rest of the train
    let carClassIndependent: Bool
    
    /// Whether a seat reservation is required
    let placeReservationNeeded: Bool
    
    // TODO
    let quotaReservationNeeded: Bool
    
    /// The kind of invoice allowed
    let allowedInvoiceKind: Int?
    
    /// The discounted gross price of the ticket
    let discountedGrossPrice: DiscountedGrossPrice?
    
    /// The gross price of the ticket
    let grossPrice: DiscountedGrossPrice?
    
    /// The gross unit price of the ticket
    let grossUnitPrice: DiscountedGrossPrice?
    
    // TODO
    let grossPriceExchanged: DiscountedGrossPrice?
    
    // TODO
    let grossUnitPriceExchanged: DiscountedGrossPrice?
    
    /// Whether the ticket belongs to a group
    let isGroup: Bool
    
    /// Direction of the ticket
    let direction: Int?
    
    /// Description of the direction of the ticket
    let directionDescription: String?
    
    /// The discount associated with the type of the customer
    let customerTypeDiscountName: String?
    
    /// Name of the discount
    let discountName: String?
    
    /// Whether the ticket is for a particular train
    let trainDependent: Bool
    
    /// Whether the ticket is refundable
    let refundable: Bool
    
    // TODO
    let cacheRenewParams: Params?
    
    /// The discounts the client has for this ticket
    let clientDiscount: [ClientDiscount]?
    
    /// Whether the ticket is an international ticket
    let isInternational: Bool
    
    /// Seat resevation associated with the ticket
    let placeTicket: PlaceTicket?
    
    /// Serialized version of the seat reservation
    let placeTicketSerialized: String?
    
    /// Reference code of the ticket
    let ticketReferenceCode: String?
    
    /// The starting station of the ticket
    let startStation: EndStationClass?
    
    /// The stations along the route of the ticket
    let touchedStations: [EndStationClass]?
    
    /// The ending station of the ticket
    let endStation: EndStationClass?
    
    /// The number of tickets
    let amount: Int?
    
    /// The code of the company this ticket is valid for
    let companyCode: String?
    
    /// The length of the route of the ticket
    let distance: Int?
}

// MARK: - Params

// TODO
struct Params: Codable {
    
    // TODO
    let reserved: Bool
    
    // TODO
    let reservationFixed: Bool
    
    // TODO
    let reservationCode: String?
    
    // TODO
    let allowedOvertime: Int?
    
    // TODO
    let lastReservationTime: String?
    
    // TODO
    let paymentDeadline: String?
    
    // TODO
    let reservationID: String?
}

// MARK: - ClientDiscount

/// A discount a client has
struct ClientDiscount: Codable {
    
    /// The scale of the discount
    let discountScale: Int?
    
    /// Gross price of the discount
    let grossPrice: DiscountedGrossPrice?
    
    /// Net price of the discount
    let netPrice: DiscountedGrossPrice?
    
    // TODO
    let takeoverMode: Int?
    
    /// The payment method used
    let paymentMode: String?
    
    /// The reason for the discount
    let discountReason: String?
}

// MARK: - DiscountedGrossPrice

/// Gross price after a discount
struct DiscountedGrossPrice: Codable {
    
    /// Price in default currency
    let amountInDefaultCurrency: Double?
    
    /// Price
    let amount: Double?
    
    /// Currency of the price
    let currency: DiscountedGrossPriceCurrency?
}

// MARK: - DiscountedGrossPriceCurrency

/// Currency of a discounted price
struct DiscountedGrossPriceCurrency: Codable {
    
    /// Key of the currency
    let key: String?
    
    /// Name of the currency
    let name: String?
    
    /// Whether this is the default currency
    let isDefault: Bool?
}

// MARK: - PlaceTicket

/// Seat reservation data
struct PlaceTicket: Codable {
    
    /// ID of the ticket
    let ticketId: Int?

//    let certificateID: String?
//    let placeReservationServices: String?
//    let nearCarriageNumber: String?
//    let nearSeatPosition: String?
    
    /// The enum type of the reservation
    let reservationType: Int?
    
    /// The name of the seat reservation type
    let reservationKind: String?
    
    // TODO
    let placeReservationServicesFilled: Bool
    
    /// UIC code for the reservation
    let uicReservationCode: String?
    
    /// The number of the car of the reservation
    let carriageNumber: String?
    
    /// The number of the seat of the reservation
    let seatPosition: String?
    
    /// The position of reservation (e.g. window, aisle, etc.)
    let location: String?
    
    /// The name of the discount for the customer type
    let customerTypeDiscountName: String?
    
    /// Whether this reservation belongs to a group
    let isGroup: Bool
    
    // TODO
    let forGrouppedFareTicket: Bool
    
    /// The train this ticket is for
    let train: TicketTrain?
    
    /// The code of the train this ticket is for
    let trainCode: String?
    
    /// The code of the starting station
    let startStationCode: String?
    
    /// The code of the ending station
    let endStationCode: String?
    
    /// The time of departure
    let startTime: String?
    
    /// The time of arrival
    let arriveTime: String?
    
    /// Additional information
    let specialisHelyAdatok: String?
    
    // TODO
    let serviceCode: String?
    
    // TODO
    let hkGuid: String?
    
    // TODO
    let tarifa: String?
    
    /// Whether the ticket is international
    let isInternational: Bool
    
    // TODO
    let kapcsoltHelyfoglalasID: String?
    
    // TODO
    let kapcsoltAjanlat: String?
    
    // TODO
    let globalDij: Bool
    
    /// Number of vacant seats
    let vacantPlaceCount: Int?
    
    /// Time the number of vacant seats was last updated
    let vacantPlaceCountUpdateTime: String?
    
    // TODO
    let quotaReservationHandlingParams: Params?
    
    // TODO
    let reserved: Bool
    
    // TODO
    let reservationFixed: Bool
    
    // TODO
    let reservationCode: String?
    
    // TODO
    let allowedOvertime: Int?
    
    // TODO
    let lastReservationTime: String?
    
    // TODO
    let paymentDeadline: String?
    
    // TODO
    let reservationID: String?
}

// MARK: - Train

/// Train associated with a ticket
struct TicketTrain: Codable {
    
    /// List of service IDs for this train
    let aggregatedServiceIds: [String]?
    
    /// Name of the train
    let name: String?
    
    /// Code of the seat reservation
    let seatReservationCode: String?
    
    /// Code of the train
    let code: String?
    
    /// Code of the company operating the train
    let companyCode: String?
    
    // TODO
    let startStationReservationCode: String?
    
    // TODO
    let endStationReservationCode: String?
    
    /// Start station for the train
    let startStation: EndStationClass?
    
    /// End station for the train
    let endStation: EndStationClass?
    
    /// Date of deprarture
    let startDate: String?
    
    /// Original start station for the train
    let origStartStation: EndStationClass?
    
    /// Original end station for the train
    let origEndStation: EndStationClass?
    
    /// Starting time for the train
    let start: String?
    
    /// Whether the starting time is only scheduled
    let virtualStart: Bool
    
    /// Arrival time for the train
    let arrive: String?
    
    /// Whether the arrival time is only scheduled
    let virtualArrive: Bool
    
    /// The length of the route of the train
    let distance: Int
    
    // TODO
    let closedTrackway: Bool
    
    /// Full name of the train
    let fullName: String?
    
    /// Full name, and type of the train
    let fullNameAndType: String?
    
    // TODO
    let kinds: [Kind]
    
    // TODO
    let kindsToDisplay: String?
    
    // TODO
    let kind: Kind?
    
    /// Services available on the train
    let services: [RouteService]
    
    /// Estimated start time of the train
    let actualOrEstimatedStart: String?
    
    /// Estimated time of arrival (ETA) for the train
    let actualOrEstimatedArrive: String?
    
    /// Additional information in case of service disturbance
    let havarianInfok: HavarianInfok
    
    // TODO
    let directTrains: String?
    
    // TODO
    let carrierTrains: String?
    
    /// Starting track for the train
    let startTrack: String?
    
    /// Ending track for the train
    let endTrack: String?
    
    // TODO
    let jeEszkozAlapId: Int?
    
    /// Full type of the train
    let fullType: String?
    
    /// Shortened type of the train
    let fullShortType: String?
    
    /// Full name and icon for the train
    let fullNameAndPiktogram: FullNameAndPiktogram?
    
    /// Footer for the train
    let footer: String?
    
    /// Name of the route the train is operating on
    let viszonylatiJel: String?
    
    /// Sign of the route this train is operating on
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

/// Data Transfer Object (DTO) for an Offer request
struct OfferRequestQueryDto: Codable {
    
    /// The kind of the offer
    var offerkind = "1"
    
    /// The code of the starting station
    let startStationCode: String
    
    /// The code of the ending station
    let endStationCode: String
    
    /// The list of codes of the stations to include in the routing
    var innerStationsCodes: [String] = []
    
    /// The list of passengers
    var passangers: [Passenger]
    
    /// Whether this ia an offer for a one way ticket
    var isOneWayTicket: Bool = true
    
    /// Whether the time given is the time to arrive by
    var isTravelEndTime: Bool = false
    
    /// Whether only buying supplementary tickets
    var isSupplementaryTicketsOnly: Bool = false
    
    /// The start date of the offer
    let travelStartDate: String
    
    /// The date for the return trip
    let travelReturnDate: String
    
    /// The list of selected services
    var selectedServices: [Int] = [52]
    
    /// The list of selected search parameters
    var selectedSearchServices: [String] = []
    
    // TODO
    var eszkozSzamok: [Int] = []
    
    /// Whether this is a detailed search
    var isOfDetailedSearch: Bool = true
}

// MARK: - Passenger

/// Data type representing passengers
struct Passenger: Codable {
    
    /// The number of tickets for this type of passenger
    let passengerCount: Int
    
    /// The ID of this type of passenger
    let passengerId: Int
    
    /// The key for the customer using this passenger type
    let customerTypeKey: String
    
    /// The list of keys of discounts for the customer
    var customerDiscountsKeys: [String] = []
}
