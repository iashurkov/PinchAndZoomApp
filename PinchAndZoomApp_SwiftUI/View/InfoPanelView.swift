//
//  InfoPanelView.swift
//  PinchAndZoomApp_SwiftUI
//
//  Created by Igor Ashurkov on 06.11.2022.
//

import SwiftUI

struct InfoPanelView: View {
    
    var scale: CGFloat
    var offset: CGSize
    
    @State private var isInfoPanelVisible = false
    
    var body: some View {
        HStack {
            // MARK: Hotspot
            
            Image(systemName: "circle.circle")
                .symbolRenderingMode(.hierarchical)
                .resizable()
                .frame(width: 30, height: 30)
                .onLongPressGesture(minimumDuration: 1) {
                    withAnimation(.easeOut) {
                        self.isInfoPanelVisible.toggle()
                    }
                }
            
            Spacer()
            
            // MARK: Info Panel
            
            HStack(spacing: 2) {
                Image(systemName: "arrow.up.left.and.arrow.down.right")
                Text("\(self.scale)")
                
                Spacer()
                
                Image(systemName: "arrow.left.and.right")
                Text("\(self.offset.width)")
                
                Spacer()
                
                Image(systemName: "arrow.up.and.down")
                Text("\(self.offset.height)")
                
                Spacer()
            }
            .font(.footnote)
            .padding(8)
            .background(.ultraThinMaterial)
            .cornerRadius(8)
            .frame(maxWidth: 420)
            .opacity(self.isInfoPanelVisible ? 1 : 0)
            
            Spacer()
            
        } //: HStack
    }
}

struct InfoPanelView_Previews: PreviewProvider {
    static var previews: some View {
        InfoPanelView(scale: 1, offset: .zero)
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
