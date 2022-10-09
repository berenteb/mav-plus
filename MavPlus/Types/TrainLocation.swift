import Foundation

struct TrainLocationList: Codable {
    let Vonatok: [TrainLocation]?
}

struct TrainLocation: Codable {
    let VonatID: String?
    let Vonatszam: String?
    let Vonatnev: String?
    let Tipus: String?
    let Viszonylat: Viszonylat?
    let Sebesseg: Int?
    let Keses: Int?
    let Menetvonal: String?
    let GpsLat: Double?
    let GpsLon: Double?
    let EGpsLat: Double?
    let EGpsLon: Double?
}

struct Viszonylat: Codable {
    let InduloAllomasKod: String?
    let CelAllomasKod: String?
    let IndulasIdeje: Int?
    let ErkezesIdeje: Int?
}

struct LocationQueryDto: Encodable{
    let UAID = "1-0xLbEm1FRGGO1ENXq912wtCy821e"
    let Nyelv = "HU"
}
