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
    @State private var isDrawerOpen = false
    
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
                // MARK: #3. Magnification
                    .gesture(
                        MagnificationGesture()
                            .onChanged { value in
                                withAnimation(.linear(duration: 1)) {
                                    if self.imageScale >= 1 && self.imageScale <= 5 {
                                        self.imageScale = value
                                    } else if self.imageScale > 5 {
                                        self.imageScale = 5
                                    }
                                }
                            }
                            .onEnded { _ in
                                if self.imageScale > 5 {
                                    self.imageScale = 5
                                } else if self.imageScale <= 1 {
                                    self.resetImageState()
                                }
                            }
                    )
                
            }
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
            // MARK: Controls
            .overlay(
                Group {
                    HStack {
                        // Scale down
                        Button {
                            withAnimation(.spring()) {
                                if self.imageScale > 1 {
                                    self.imageScale -= 1
                                    
                                    if self.imageScale <= 1 {
                                        self.resetImageState()
                                    }
                                }
                            }
                        } label: {
                            ControlImageView(icon: "minus.magnifyingglass")
                        }
                        
                        // Reset
                        Button {
                            self.resetImageState()
                        } label: {
                            ControlImageView(icon: "arrow.up.left.and.down.right.magnifyingglass")
                        }
                        
                        // Scale up
                        Button {
                            withAnimation(.spring()) {
                                if self.imageScale < 5 {
                                    self.imageScale += 1
                                    
                                    if self.imageScale > 5 {
                                        self.imageScale = 5
                                    }
                                }
                            }
                        } label: {
                            ControlImageView(icon: "plus.magnifyingglass")
                        }
                        
                    } //: HStack Controls
                    .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .opacity(self.isAnimating ? 1 : 0)
                }
                    .padding(.bottom, 30),
                alignment: .bottom
            ) //: ZStack
            // MARK: Drawer
            .overlay(
                HStack(spacing: 12) {
                    // Handle
                    Image(systemName: self.isDrawerOpen
                          ? "chevron.compact.right"
                          : "chevron.compact.left")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)
                        .padding(8)
                        .foregroundStyle(.secondary)
                        .onTapGesture(perform: {
                            withAnimation(.easeOut) {
                                self.isDrawerOpen.toggle()
                            }
                        })
                    
                    // Thumbnails
                    Spacer()
                    
                } //: HStack Drawer
                    .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .opacity(self.isAnimating ? 1 : 0)
                    .frame(width: 260)
                    .padding(.top, UIScreen.main.bounds.height / 12)
                    .offset(x: self.isDrawerOpen ? 20 : 215),
                alignment: .topTrailing
            )
        } //: NavigationView
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
