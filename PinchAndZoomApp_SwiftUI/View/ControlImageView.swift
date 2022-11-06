//
//  ControlsImageView.swift
//  PinchAndZoomApp_SwiftUI
//
//  Created by Igor Ashurkov on 06.11.2022.
//

import SwiftUI

struct ControlImageView: View {
    
    let icon: String
    
    var body: some View {
        Image(systemName: self.icon)
            .font(.system(size: 36))
    }
}

struct ControlImageView_Previews: PreviewProvider {
    static var previews: some View {
        ControlImageView(icon: "minus.magnifyingglass")
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
