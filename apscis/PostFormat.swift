//
//  PostFormat.swift
//  apscis
//
//  Created by Ivan Bartol on 27.09.2026..
//

import CoreGraphics

enum PostFormat: String, CaseIterable, Identifiable {
    case fourFive = "4:5"
    case nineSixteen = "9:16"

    var id: String {
        rawValue
    }

    var pixelSize: CGSize {
        switch self {
        case .fourFive:
            return CGSize(width: 1080, height: 1350)

        case .nineSixteen:
            return CGSize(width: 1080, height: 1920)
        }
    }

    var fileSuffix: String {
        switch self {
        case .fourFive:
            return "4x5"

        case .nineSixteen:
            return "9x16"
        }
    }

    var description: String {
        switch self {
        case .fourFive:
            return "1080 × 1350"

        case .nineSixteen:
            return "1080 × 1920"
        }
    }
}
