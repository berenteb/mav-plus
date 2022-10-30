//
//  Spinner.swift
//  MavPlus
//
//  Created by Berente Bálint on 2022. 10. 30..
//

import SwiftUI

struct Spinner: View {
    static let initialDegree: Angle = .degrees(180)
    @State var spinnerStart: CGFloat = 0
    @State var spinnerEnd: CGFloat = 0.3
    @State var rotationDegree1 = initialDegree
    @State var rotationDegree2 = initialDegree
    let rotationTime: Double = 1
    let fullRotation: Angle = .degrees(360)
    let animationTime: Double = 1
    
    var body: some View {
        ZStack {
            SpinnerCircle(start: spinnerStart, end: spinnerEnd, rotation: rotationDegree1, color: Color("Primary"))
            SpinnerCircle(start: spinnerStart, end: spinnerEnd, rotation: rotationDegree2, color: Color("Secondary"))
            
        }.frame(width: 200, height: 200)
            .onAppear {
                animateBoth()
                Timer.scheduledTimer(withTimeInterval: animationTime, repeats: true) { (mainTimer) in
                    animateBoth()
                }
            }
    }
    
    func animateBoth(){
        animationStep(duration: rotationTime) { self.rotationDegree1+=fullRotation }
        animationStep(duration: rotationTime*1.5) {
            self.rotationDegree2 += fullRotation
        }
    }
    
    func animationStep(duration: Double, completion: @escaping (() -> Void)){
        withAnimation(Animation.easeInOut(duration: duration)) {
            completion()
        }
    }
    
}

struct SpinnerCircle: View {
    var start: CGFloat
    var end: CGFloat
    var rotation: Angle
    var color: Color
    var body: some View {
        Circle()
            .trim(from: start, to: end)
            .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round))
            .fill(color)
            .rotationEffect(rotation)
    }
}

struct Spinner_Previews: PreviewProvider {
    static var previews: some View {
        Spinner()
    }
}
