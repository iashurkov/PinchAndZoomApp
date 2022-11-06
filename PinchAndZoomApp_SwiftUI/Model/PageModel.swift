//
//  PageModel.swift
//  PinchAndZoomApp_SwiftUI
//
//  Created by Igor Ashurkov on 06.11.2022.
//

import Foundation

struct Page: Identifiable {
    let id: Int
    let imageName: String
}

extension Page {
    var trumbnailName: String {
        "thumb-" + imageName
    }
}
