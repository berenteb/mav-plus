import SwiftUI

struct DirectionsQuerySummary: View {
    
    var startStationName: String
    var endStationName: String
    var passengerCount: Int
    var startDate: Date
    
    var body: some View {
        
        Section(content: {
            HStack{
                Image("Directions").foregroundColor(Color("Secondary")).rotationEffect(Angle(degrees: 90))
                VStack(alignment: .leading){
                    Text(startStationName)
                    Text(endStationName)
                }
            }
            HStack{
                Image("Person").foregroundColor(Color("Secondary"))
                Text(String(passengerCount))
            }
            HStack{
                Image("Calendar").foregroundColor(Color("Secondary"))
                Text(startDate.formatted(date: .long, time: .shortened))
            }
        }, header: {
            Text("Parameters")
        })
    }
}

struct DirectionsQuerySummary_Previews: PreviewProvider {
    static var previews: some View {
        List{
            DirectionsQuerySummary(
                startStationName: MockQueryStartName,
                endStationName: MockQueryEndName,
                passengerCount: MockQueryPassengerCount,
                startDate: MockQueryStartDate)
        }
    }
}
