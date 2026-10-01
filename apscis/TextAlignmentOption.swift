//
//  TextAlignmentOption.swift
//  apscis
//
//  Created by Ivan Bartol on 28.09.2026..
//

import SwiftUI

enum TextAlignmentOption: String, CaseIterable, Identifiable {
    case left = "Left"
    case center = "Center"

    var id: String {
        rawValue
    }

    var textAlignment: TextAlignment {
        switch self {
        case .left:
            return .leading

        case .center:
            return .center
        }
    }

    var frameAlignment: Alignment {
        switch self {
        case .left:
            return .leading

        case .center:
            return .center
        }
    }
}
