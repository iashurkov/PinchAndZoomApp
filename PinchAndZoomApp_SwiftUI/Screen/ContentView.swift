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
    @State private var imageOffset: CGSize = .zero
    
    // MARK: Private method
    
    private func resetImageState() {
        withAnimation(.spring()) {
            self.imageScale = 1
            self.imageOffset = .zero
        }
    }
    
    // MARK: Body
    
    var body: some View {
        NavigationView {
            ZStack {
                
                Color.clear
                
                // MARK: Page Image
                
                Image("magazine-front-cover")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                    .opacity(self.isAnimating ? 1 : 0)
                    .animation(.linear(duration: 1), value: self.isAnimating)
                    .offset(x: self.imageOffset.width, y: self.imageOffset.height)
                    .scaleEffect(self.imageScale)
                // MARK: #1. Gesture Tap
                    .onTapGesture(count: 2, perform: {
                        if self.imageScale == 1 {
                            withAnimation(.spring()) {
                                self.imageScale = 5
                            }
                        } else {
                            self.resetImageState()
                        }
                    })
                // MARK: #2. Gesture Drag
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                withAnimation(.linear(duration: 1)) {
                                    self.imageOffset = value.translation
                                }
                            }
                            .onEnded { _ in
                                if self.imageScale <= 1 {
                                    self.resetImageState()
                                }
                            }
                    )
                
            } //: ZStack
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                self.isAnimating = true
            })
            // MARK: Info panel
            .overlay(
                InfoPanelView(scale: self.imageScale, offset: self.imageOffset)
                    .padding(.horizontal)
                    .padding(.top, 30),
                alignment: .top
            )
        } //: NavigationView
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
