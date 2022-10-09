// MARK: - Cities
struct ServicesDto: Codable {
    let services: [Service]?
    let searchServices: [SearchService]?
}

// MARK: - SearchService
struct SearchService: Codable {
    let id: String?
    let code: String?
    let value, megnevezes: String?
    let foreignNames: ForeignNames?
    let order: Int?
    let newSearchIfNotFound, fordib: Bool
    let services: [Service]?
    let isSelected, canChangeSelection: Bool
}

// MARK: - ForeignNames
struct ForeignNames: Codable {
    let en, de: String
}

// MARK: - Service
struct Service: Codable {
    let id, name: String?
    let foreignNames: ForeignNames?
    let groupID, groupName, groupNameForExclusion, mainGroupID: String?
    let mainGroupName: String?
    let isFare, isExtraCharge: Bool
    let serviceType: Int?
    let description, uicCode: String?
    let code: Int?
    let ticketImageName: String?
    let classCode: String?
    let className: String?
    let classFromCode: String?
    let classFromName: String?
    let classIndependent, classChanger: Bool
    let allowedCustomerTypeID, allowedCustomerTypeCode: [String]?
    let hasAllowedCustomerTypeWidthAge: Bool
    let isSeasonTicketSign, isDefault, isPlaceReservationService, isInternal: Bool
    let isTicket: Bool
    let vatValue: Double?
    let placeType: String?
    let orderID: Int?
    let groupOrderID: Int?
    let hasDefaultInGroup: Bool
    let offerKind: Int?
    let isSelected, canChangeSelection: Bool
    let passengerCount, reservationKind: Int?
}

struct ServiceQueryDto: Codable {
    let offerKind: String
}
