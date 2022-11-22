import Foundation

var MockStationList = [
    FormStationListItem(
        code: "",
        name: "Szeged",
        searchCount: 0,
        isFavorite: false
    ),
    FormStationListItem(
        code: "",
        name: "Budapest",
        searchCount: 0,
        isFavorite: false
    )
]

var MockTrainPictogram = TrainPictogram(
    foregroundColor: "#0000FF",
    backgroundColor: "#FFFFFF",
    name: "IC")

var MockOfferRoutePart = OfferRoutePart(
    startStationName: "Szeged",
    endStationName: "Budapest",
    trainName: "NAPFÉNY INTERCITY",
    trainCode: "123",
    startDate: Date.now,
    endDate: Date.now,
    trainPictogram: MockTrainPictogram,
    travelTime: "12:34"
)

var MockOfferData = OfferData(
    startStationName: "Szeged",
    endStationName: "Budapest",
    depDate: Date.now,
    arrDate: Date.now,
    price: "10000 HUF",
    travelTime: "12:31",
    transferCount: 10,
    route: [MockOfferRoutePart])


var MockTrainData = TrainListItemData(
    pictogram: MockTrainPictogram,
    trainName: "ARANYHOMOK",
    destination: "Kelenföld")

var MockError = "Lórum ipse számos máshol nehezen hajas rértést és szánikus szárnyót is hajcsálódik"

var MockQueryStartName = "Szeged"
var MockQueryEndName = "Budapest"
var MockQueryPassengerCount = 10
var MockQueryStartDate = Date.now
