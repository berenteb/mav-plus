import SwiftUI

/// Spinning loading icon UI component
struct SpinnerView: View{
    
    /// Size of the icon
    let size: Double
    
    /// Default initializer
    /// - Parameter size: The size of the icon
    init(size: Double = 50){
        self.size = size
    }
    
    /// SwiftUI view generation.
    var body: some View{
        ProgressView().progressViewStyle(Spinner(size: self.size))
    }
}

/// Model for custom loading UI component
struct Spinner: ProgressViewStyle {
    
    /// The original starting angle for the spinning loading icon
    static let initialDegree: Angle = .degrees(180)
    
    // TODO
    @State var spinnerStart: CGFloat = 0
    
    // TODO
    @State var spinnerEnd: CGFloat = 0.3
    
    // TODO
    @State var rotationDegree1 = initialDegree
    
    // TODO
    @State var rotationDegree2 = initialDegree
    
    // TODO
    let rotationTime: Double = 1
    
    // TODO
    let fullRotation: Angle = .degrees(360)
    
    // TODO
    let animationTime: Double = 1
    
    // TODO
    let size: Double
    
    // TODO
    func makeBody(configuration: Configuration) -> some View {
        return ZStack {
            SpinnerCircle(start: spinnerStart, end: spinnerEnd, rotation: rotationDegree1, color: Color("Primary"), size: size)
            SpinnerCircle(start: spinnerStart, end: spinnerEnd, rotation: rotationDegree2, color: Color("Secondary"), size: size)
            
        }.frame(width: size, height: size)
            .onAppear {
                animateBoth()
                Timer.scheduledTimer(withTimeInterval: animationTime, repeats: true) { (mainTimer) in
                    animateBoth()
                }
            }
    }
    
    // TODO
    func animateBoth(){
        animationStep(duration: rotationTime) { self.rotationDegree1+=fullRotation
        }
        animationStep(duration: rotationTime*1.5) {
            self.rotationDegree2 += fullRotation
        }
    }
    
    // TODO
    func animationStep(
        duration: Double,
        completion: @escaping (() -> Void)){
            withAnimation(
                Animation.easeInOut(duration: duration)){
                    completion()
                }
        }
}

// TODO
struct SpinnerCircle: View {
    
    // TODO
    var start: CGFloat
    
    // TODO
    var end: CGFloat
    
    // TODO
    var rotation: Angle
    
    // TODO
    var color: Color
    
    // TODO
    var size: Double
    
    /// SwiftUI view generation.
    var body: some View {
        Circle()
            .trim(from: start, to: end)
            .stroke(style: StrokeStyle(lineWidth: size/10, lineCap: .round))
            .fill(color)
            .rotationEffect(rotation)
    }
}

/// SwiftUI Preview
struct Spinner_Previews: PreviewProvider {
    
    /// SwiftUI Preview content generation.
    static var previews: some View {
        SpinnerView()
            .previewLayout(.sizeThatFits)
    }
}
