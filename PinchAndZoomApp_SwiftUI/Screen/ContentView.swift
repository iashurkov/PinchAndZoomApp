//
//  ContentView.swift
//  PinchAndZoomApp_SwiftUI
//
//  Created by Igor Ashurkov on 04.11.2022.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: Property
    
    @State private var isAnimating = false
    @State private var imageScale: CGFloat = 1
    
    // MARK: Body
    
    var body: some View {
        NavigationView {
            ZStack {
                
                // MARK: Page Image
                
                Image("magazine-front-cover")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                    .opacity(self.isAnimating ? 1 : 0)
                    .animation(.linear(duration: 1), value: self.isAnimating)
                    .scaleEffect(self.imageScale)
                // MARK: #1. Gesture Tap
                    .onTapGesture(count: 2, perform: {
                        if self.imageScale == 1 {
                            withAnimation(.spring()) {
                                self.imageScale = 5
                            }
                        } else {
                            withAnimation(.spring()) {
                                self.imageScale = 1
                            }
                        }
                    })
                
            } //: ZStack
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                self.isAnimating = true
            })
        } //: NavigationView
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
