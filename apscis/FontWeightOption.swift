//
//  FontWeightOption.swift
//  apscis
//
//  Created by Ivan Bartol on 28.09.2026..
//

import SwiftUI

enum FontWeightOption: String, CaseIterable, Identifiable {
    case regular = "Regular"
    case medium = "Medium"
    case semibold = "Semibold"
    case bold = "Bold"

    var id: String {
        rawValue
    }

    var weight: Font.Weight {
        switch self {
        case .regular:
            return .regular

        case .medium:
            return .medium

        case .semibold:
            return .semibold

        case .bold:
            return .bold
        }
    }
}
