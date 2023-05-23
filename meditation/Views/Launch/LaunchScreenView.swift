//
//  LaunchScreenView.swift
//  meditation
//
//  Created by Sergio Veliz on 18.05.2023.
//

import SwiftUI

struct LaunchScreenView: View {
    @EnvironmentObject private var launchScreenState: LaunchScreenStateManager // Mark 1

    @State private var animate = false
//    @State private var firstAnimation = false  // Mark 2
//    @State private var secondAnimation = false // Mark 2
//    @State private var startFadeoutAnimation = false // Mark 2
//    @State private var opacity = 0.0
    
    @ViewBuilder
    private var image: some View {  // Mark 3
        Image("logoLotos")
            .resizable()
            .scaledToFit()
            .opacity(animate ? 1.0 : 0.0)
//            .opacity(opacity)
//            .frame(width: 100, height: 100)
//            .rotationEffect(firstAnimation ? Angle(degrees: 900) : Angle(degrees: 1800)) // Mark 4
//            .scaleEffect(secondAnimation ? 0 : 1) // Mark 4
//            .offset(y: secondAnimation ? 400 : 0) // Mark 4
    }
    
    @ViewBuilder
    private var backgroundColor: some View {  // Mark 3
        Image("backgroundSplash")
            .resizable()
            .scaledToFill().ignoresSafeArea()
    }
    
//    private let animationTimer = Timer // Mark 5
//        .publish(every: 0.3, on: .current, in: .common)
//        .autoconnect()
    
    var body: some View {
        ZStack {
            backgroundColor  // Mark 3
            image  // Mark 3
        }.onAppear {
//            updateAnimation()  // Mark 5
            withAnimation(Animation.spring().speed(0.1)) {
                            animate.toggle()
                        }
        }//.opacity(startFadeoutAnimation ? 0 : 1)
    }
    
//    private func updateAnimation() { // Mark 5
//        switch launchScreenState.state {
//        case .firstStep:
//            withAnimation(.easeInOut(duration: 0.9)) {
//                firstAnimation.toggle()
////                opacity = 0.1
//            }
//        case .secondStep:
//            if secondAnimation == false {
//                withAnimation(.linear) {
////                    opacity = 0.6
//                    self.secondAnimation = true
//                    startFadeoutAnimation = true
//                }
//            }
//        case .finished:
//            // use this case to finish any work needed
////            opacity = 1
//            break
//        }
//    }
    
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
            .environmentObject(LaunchScreenStateManager())
    }
}
