//
//  PostCanvas.swift
//  apscis
//
//  Created by Ivan Bartol on 28.09.2026..
//

import SwiftUI

struct PostCanvas: View {
    let quote: String
    let format: PostFormat

    let backgroundColor: Color
    let textColor: Color

    let fontSize: Double
    let fontWeight: FontWeightOption

    let textWidthRatio: Double
    let lineSpacing: Double

    let horizontalPosition: Double
    let verticalPosition: Double

    let alignment: TextAlignmentOption

    var renderScale: CGFloat = 1.0

    var body: some View {
        let originalSize = format.pixelSize

        let canvasWidth =
            originalSize.width * renderScale

        let canvasHeight =
            originalSize.height * renderScale

        ZStack {
            backgroundColor

            Text(quote)
                .font(
                    .system(
                        size: fontSize * renderScale,
                        weight: fontWeight.weight,
                        design: .default
                    )
                )
                .foregroundStyle(textColor)
                .multilineTextAlignment(
                    alignment.textAlignment
                )
                .lineSpacing(
                    lineSpacing * renderScale
                )
                .frame(
                    width:
                        originalSize.width
                        * textWidthRatio
                        * renderScale,
                    alignment:
                        alignment.frameAlignment
                )
                .position(
                    x:
                        originalSize.width
                        * horizontalPosition
                        * renderScale,

                    y:
                        originalSize.height
                        * verticalPosition
                        * renderScale
                )
        }
        .frame(
            width: canvasWidth,
            height: canvasHeight
        )
        .clipped()
    }
}
