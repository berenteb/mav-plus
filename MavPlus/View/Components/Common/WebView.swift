import WebKit
import SwiftUI

/// SwiftUI embeddable UIKit based web view component
struct WebView: UIViewRepresentable {
    
    /// The url to load in the view
    var url: URL
    
    /// Creates the view
    /// - Parameter context: The context for the view to be created
    /// - Returns: The created view
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    /// Updates the view
    /// - Parameters:
    ///   - webView: The view to be updated
    ///   - context: The context of the view to be updated
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

/// SwiftUI Preview
struct WebView_Previews: PreviewProvider {
    
    /// SwiftUI Preview content generation.
    static var previews: some View {
        WebView(url: URL(string: "https://www.mavcsoport.hu")!)
    }
}
