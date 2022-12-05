import SwiftUI

/// View for the summary of the query
struct DirectionsQuerySummary: View {
    
    /// Name of the start station
    var startStationName: String
    
    /// Name of the end station
    var endStationName: String
    
    /// Number of passengers
    var passengerCount: Int
    
    /// The date of the query
    var startDate: Date
    
    /// SwiftUI view generation.
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

/// SwiftUI Preview
struct DirectionsQuerySummary_Previews: PreviewProvider {
    /// SwiftUI Preview content generation.
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
