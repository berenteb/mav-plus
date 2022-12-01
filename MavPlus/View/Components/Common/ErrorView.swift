import SwiftUI

/// Error screen.
struct ErrorView: View {
    
    /// The description of the error
    var error: String?
    
    /// Callback to execute on tap of Retry button
    var onRetry: (()->Void)?
    
    /// SwiftUI view generation.
    var body: some View {
        VStack(spacing:30){
            Image(systemName: "exclamationmark.circle")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundColor(.red)
            Text("An error occurred!")
                .font(.title)
                .foregroundColor(.red)
                .fontWeight(.bold)
            if let error = error {
                Text(error)
                    .font(.title2)
                    .foregroundColor(.gray)
            }
            if let onRetry = onRetry {
                Button("Retry", action: onRetry)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 20)
                    .foregroundColor(.black)
                    .background(Color("Primary"))
                    .font(.title3)
                    .fontWeight(.bold)
                    .cornerRadius(10)
            }
        }.padding(.horizontal)
    }
}

/// SwiftUI Preview
struct ErrorView_Previews: PreviewProvider {
    
    /// SwiftUI Preview content generation.
    static var previews: some View {
        ErrorView(error: MockError){
            print("Retry")
        }
    }
}
