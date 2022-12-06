import Foundation

// MARK: - Cities

/// Data type representing discounts and customer types
struct CustomersAndDiscounts: Codable {
    
    /// List of the type of customers
    let customerTypes: [CustomerType]?
    
    /// List of possible discounts
    let discounts: [Discount]?
}

// MARK: - CustomerType

/// Data type representing the different types of customers
struct CustomerType: Codable {
    
    /// Name of the customer type
    let name: String?
    
    /// Key of the customer type
    let key: String?
    
    /// Maximum age of the customer type in years
    let maxAge: Int?
    
    /// Minimum age of the customer type in years
    let minAge: Int?
    
    // TODO
    let discountProps: [DiscountProp]
    
    /// Name of the customer type in foreign languages
    let foreignNames: Foreign
    
    /// Description of the customer type in foreign languages
    let foreignDescriptions: ForeignDescriptions
    
    /// Name of the icon of the customer type
    let iconName: String?
    
    /// Name of the secondary icon of the customer type
    let secondaryIconName: String?
}

// MARK: - DiscountProp

// TODO
struct DiscountProp: Codable {
    
    /// ID of the discount
    let discountID: String?
    
    // TODO
    let offerKind: String?
}

// MARK: - ForeignDescriptions

/// Data type representing the description of CustomerType objects in foreign languages
struct ForeignDescriptions: Codable {
}

// MARK: - Foreign

/// Data type representing the name of CustomerType objects in foreign languages
struct Foreign: Codable {
    
    /// Name in English
    let en: String?
    
    /// Name in German
    let de: String?
}

// MARK: - Discount

/// Data type representing the types of discounts
struct Discount: Codable {
    
    /// Name of the discount type in foreign languages
    let foreignNames: Foreign
    
    /// Description of the discount type in foreign languages
    let foreignDescriptions: Foreign
    
    /// Name of the discount type
    let name: String?
    
    /// Description of the discount type
    let description: String?
    
    /// Key of the discount type
    let key: String?
    
    /// ID of the discount type
    let id: String?
    
    /// Whether the discount is regional
    let isRegional: Bool
    
    /// The value of the discount
    let discountValue: DiscountValue?
    
    // TODO
    let question: String?
    
    /// Whether the discount is available internationally
    let isInternational: Bool
    
    /// Whether the discount is available domestically
    let isInternal: Bool
}

// MARK: - DiscountValue

/// Data type representing the value of a discount type
struct DiscountValue: Codable {
    
    // TODO percentage or absolute value
    let value: Int?
    
    /// Name of the discount value
    let name: String?
}

// TODO
struct CustomersQueryDto: Codable {
    
    // TODO
    let offerKind: String
}
