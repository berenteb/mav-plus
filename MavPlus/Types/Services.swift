// MARK: - Cities

/// Data Transfer Object (DTO) for services
struct ServicesDto: Codable {
    
    /// The list of services
    let services: [Service]?
    
    /// The list of search parameters
    let searchServices: [SearchService]?
}

// MARK: - SearchService

/// Data type for search parameters
struct SearchService: Codable {
    
    /// The ID of the search parameter
    let id: String?
    
    /// The code of the search parameter
    let code: String?
    
    /// The value of the search parameter
    let value: String?
    
    /// The name of the search parameter
    let megnevezes: String?
    
    /// Name of the search parameter in foreign languages
    let foreignNames: ForeignNames?
    
    // TODO
    let order: Int?
    
    // TODO
    let newSearchIfNotFound: Bool
    
    // TODO
    let fordib: Bool
    
    /// Services associated with search parameter
    let services: [Service]?
    
    /// Whether the search parameter is currently selected
    let isSelected: Bool
    
    /// Whether the selection of the search parameter can be changed
    let canChangeSelection: Bool
}

// MARK: - ForeignNames

/// Name of a service/parameter in foreign languages
struct ForeignNames: Codable {
    
    /// Name in English
    let en: String
    
    /// Name in German
    let de: String
}

// MARK: - Service

/// Data type for services
struct Service: Codable {
    
    /// ID of the service
    let id: String?
    
    /// Name of the service
    let name: String?
    
    /// Name of the service in foreign languages
    let foreignNames: ForeignNames?
    
    /// ID of the group of the service
    let groupID: String?
    
    /// Name of the group of the service
    let groupName: String?
    
    // TODO
    let groupNameForExclusion: String?
    
    /// ID of the main group of the service
    let mainGroupID: String?
    
    /// Name of the main group of the service
    let mainGroupName: String?
    
    /// Whether the service is related to ticket fares
    let isFare: Bool
    
    /// Whether the service is an extra charge
    let isExtraCharge: Bool?
    
    /// Type of the service
    let serviceType: Int?
    
    /// Description of the service
    let description: String?
    
    /// UIC code of the service
    let uicCode: String?
    
    /// Code of the service
    let code: Int?
    
    /// Name of the image for the ticket associated with this service
    let ticketImageName: String?
    
    /// Code of the class of this service
    let classCode: String?
    
    /// Name of the class of this service
    let className: String?
    
    // TODO
    let classFromCode: String?
    
    // TODO
    let classFromName: String?
    
    // TODO
    let classIndependent: Bool?
    
    // TODO
    let classChanger: Bool?
    
    /// List of allowed IDs of allowed customer types for this service
    let allowedCustomerTypeID: [String]?
    
    /// List of allowed codes of allowed customer types for this service
    let allowedCustomerTypeCode: [String]?
    
    /// Whether this service is only available for customers within a range of age
    let hasAllowedCustomerTypeWidthAge: Bool?
    
    /// Whether the service has a seasonal ticket sign
    let isSeasonTicketSign: Bool?
    
    /// Whether this a default service
    let isDefault: Bool?
    
    /// Whether this is a seat reservation service
    let isPlaceReservationService: Bool?
    
    /// Whether the service is only available domestically
    let isInternal: Bool?
    
    /// Whether this service is a ticket
    let isTicket: Bool?
    
    /// VAT value associated with this service
    let vatValue: Double?
    
    /// Type of place for this service
    let placeType: String?
    
    // TODO
    let orderID: Int?
    
    // TODO
    let groupOrderID: Int?
    
    // TODO
    let hasDefaultInGroup: Bool?
    
    // TODO
    let offerKind: Int?
    
    /// Whether this service is currently selected
    let isSelected: Bool?
    
    /// Whether the selection of this service can be changed
    let canChangeSelection: Bool?
    
    /// Number of passengers for this service
    let passengerCount: Int?
    
    /// The kind of reservation for this service
    let reservationKind: Int?
}

// TODO
struct ServiceQueryDto: Codable {
    
    // TODO
    let offerKind: String
}
