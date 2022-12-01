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
    @State var spinnerStart: CGFloat = 0
    @State var spinnerEnd: CGFloat = 0.3
    @State var rotationDegree1 = initialDegree
    @State var rotationDegree2 = initialDegree
    let rotationTime: Double = 1
    let fullRotation: Angle = .degrees(360)
    let animationTime: Double = 1
    let size: Double
    
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
    
    func animateBoth(){
        animationStep(duration: rotationTime) { self.rotationDegree1+=fullRotation
        }
        animationStep(duration: rotationTime*1.5) {
            self.rotationDegree2 += fullRotation
        }
    }
    
    func animationStep(
        duration: Double,
        completion: @escaping (() -> Void)){
            withAnimation(
                Animation.easeInOut(duration: duration)){
                    completion()
                }
        }
}

struct SpinnerCircle: View {
    var start: CGFloat
    var end: CGFloat
    var rotation: Angle
    var color: Color
    var size: Double
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
