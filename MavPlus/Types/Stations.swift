struct Station: Codable {
    let id: Int?
    let isAlias: Bool
    let name, code: String?
    let baseCode: String?
    let isInternational, canUseForOfferRequest, canUseForPessengerInformation: Bool
    let country: String?
    let coutryIso: String?
    let isIn108_1: Bool
}

typealias StationList = [Station]
