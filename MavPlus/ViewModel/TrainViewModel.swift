import Foundation
import MapKit

struct TrainData {
    var trainPictogram: TrainPictogram?
    var name: String
    var startStationName: String
    var endStationName: String
    var stations: [Stop]
    var location: CLLocationCoordinate2D?
}

struct Stop{
    var name: String
    var date: Date?
}

class TrainViewModel: ObservableObject, Updateable, RequestStatus{
    var trainId: Int
    @Published var isError: Bool
    @Published var isLoading: Bool
    @Published var trainData: TrainData?
    
    init(trainId: Int) {
        self.isError = false
        self.isLoading = true
        self.trainId = trainId
    }
    
    func update() {
        ApiRepository.shared.getTrainInfo(trainId: trainId){ trainData, error in
            self.isLoading = false
            if error != nil{
                self.isError = true
                return
            }
            if let train = trainData?.trainSchedulerDetails?[0]{
                var pictogram: TrainPictogram? = nil
                if let signName = train.train?.viszonylatiJel?.jel, let fgColor = train.train?.viszonylatiJel?.fontSzinKod, let bgColor = train.train?.viszonylatiJel?.hatterSzinKod {
                    pictogram = TrainPictogram(
                        foregroundColor: fgColor,
                        backgroundColor: bgColor,
                        name: signName
                    )
                }else if let signName = train.train?.kind?.sortName,
                        let fgColor = train.train?.kind?.foregroundColorCode,
                        let bgColor = train.train?.kind?.backgroundColorCode {
                    pictogram = TrainPictogram(
                        foregroundColor: fgColor,
                        backgroundColor: bgColor,
                        name: signName
                    )
                }
                let name = train.train?.fullNameAndType ?? train.train?.fullName
                let startStationName = train.train?.startStation?.name
                let endStationName = train.train?.endStation?.name
                let stations: [Stop] = train.scheduler?.map{st in
                    return Stop(name: st.station?.name ?? "Unknown", date: DateFromIso(st.start ?? "") ?? DateFromIso(st.arrive ?? ""))
                } ?? []
                self.trainData = TrainData(trainPictogram: pictogram, name: name ?? "Unknown", startStationName: startStationName ?? "Unknown", endStationName: endStationName ?? "Unknown", stations: stations)
            }
            
        }
    }
    
    
}
