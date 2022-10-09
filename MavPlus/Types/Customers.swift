import Foundation

// MARK: - Cities
struct CustomersAndDiscounts: Codable {
    let customerTypes: [CustomerType]?
    let discounts: [Discount]?
}

// MARK: - CustomerType
struct CustomerType: Codable {
    let name, key: String?
    let maxAge, minAge: Int?
    let discountProps: [DiscountProp]
    let foreignNames: Foreign
    let foreignDescriptions: ForeignDescriptions
    let iconName, secondaryIconName: String?
}

// MARK: - DiscountProp
struct DiscountProp: Codable {
    let discountID, offerKind: String?
}

// MARK: - ForeignDescriptions
struct ForeignDescriptions: Codable {
}

// MARK: - Foreign
struct Foreign: Codable {
    let en, de: String?
}

// MARK: - Discount
struct Discount: Codable {
    let foreignNames, foreignDescriptions: Foreign
    let name: String?
    let description: String?
    let key, id: String?
    let isRegional: Bool
    let discountValue: DiscountValue?
    let question: String?
    let isInternational, isInternal: Bool
}

// MARK: - DiscountValue
struct DiscountValue: Codable {
    let value: Int?
    let name: String?
}

struct CustomersQueryDto: Codable {
 let offerKind: String
}
