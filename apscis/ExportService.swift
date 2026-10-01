//
//  ExportService.swift
//  apscis
//
//  Created by Ivan Bartol on 28.09.2026..
//

import SwiftUI
import AppKit
import UniformTypeIdentifiers

enum ExportError: LocalizedError {
    case renderFailed
    case folderUnavailable

    var errorDescription: String? {
        switch self {
        case .renderFailed:
            return "The image could not be rendered."

        case .folderUnavailable:
            return "The selected folder could not be accessed."
        }
    }
}

@MainActor
enum ExportService {

    static func exportSingle(
        quote: String,
        format: PostFormat,
        backgroundColor: Color,
        textColor: Color,
        fontSize: Double,
        fontWeight: FontWeightOption,
        textWidthRatio: Double,
        lineSpacing: Double,
        horizontalPosition: Double,
        verticalPosition: Double,
        alignment: TextAlignmentOption,
        baseName: String
    ) throws {

        guard let pngData = renderPNG(
            quote: quote,
            format: format,
            backgroundColor: backgroundColor,
            textColor: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
            textWidthRatio: textWidthRatio,
            lineSpacing: lineSpacing,
            horizontalPosition: horizontalPosition,
            verticalPosition: verticalPosition,
            alignment: alignment
        ) else {
            throw ExportError.renderFailed
        }

        let panel = NSSavePanel()

        panel.title = "Export \(format.rawValue)"
        panel.prompt = "Export"

        panel.allowedContentTypes = [
            UTType.png
        ]

        panel.canCreateDirectories = true

        let safeName = sanitizedFilename(
            baseName
        )

        panel.nameFieldStringValue =
            "\(safeName)_\(format.fileSuffix).png"

        let response = panel.runModal()

        guard
            response == .OK,
            let url = panel.url
        else {
            return
        }

        try pngData.write(
            to: url,
            options: .atomic
        )
    }

    static func exportBoth(
        quote: String,
        backgroundColor: Color,
        textColor: Color,
        fontSize: Double,
        fontWeight: FontWeightOption,
        textWidthRatio: Double,
        lineSpacing: Double,
        horizontalPosition: Double,
        verticalPosition: Double,
        alignment: TextAlignmentOption,
        baseName: String
    ) throws {

        let panel = NSOpenPanel()

        panel.title =
            "Choose export folder"

        panel.message =
            "Choose where apscis should save both images."

        panel.prompt =
            "Choose Folder"

        panel.canChooseFiles = false
        panel.canChooseDirectories = true
        panel.allowsMultipleSelection = false

        let response = panel.runModal()

        guard response == .OK else {
            return
        }

        guard let folderURL = panel.url else {
            throw ExportError.folderUnavailable
        }

        let securityAccess =
            folderURL
                .startAccessingSecurityScopedResource()

        defer {
            if securityAccess {
                folderURL
                    .stopAccessingSecurityScopedResource()
            }
        }

        let safeName =
            sanitizedFilename(baseName)

        for format in PostFormat.allCases {

            guard let pngData = renderPNG(
                quote: quote,
                format: format,
                backgroundColor: backgroundColor,
                textColor: textColor,
                fontSize: fontSize,
                fontWeight: fontWeight,
                textWidthRatio: textWidthRatio,
                lineSpacing: lineSpacing,
                horizontalPosition: horizontalPosition,
                verticalPosition: verticalPosition,
                alignment: alignment
            ) else {
                throw ExportError.renderFailed
            }

            let filename =
                "\(safeName)_\(format.fileSuffix).png"

            let destination =
                folderURL
                    .appendingPathComponent(
                        filename
                    )

            try pngData.write(
                to: destination,
                options: .atomic
            )
        }
    }

    private static func renderPNG(
        quote: String,
        format: PostFormat,
        backgroundColor: Color,
        textColor: Color,
        fontSize: Double,
        fontWeight: FontWeightOption,
        textWidthRatio: Double,
        lineSpacing: Double,
        horizontalPosition: Double,
        verticalPosition: Double,
        alignment: TextAlignmentOption
    ) -> Data? {

        let canvas = PostCanvas(
            quote: quote,
            format: format,
            backgroundColor: backgroundColor,
            textColor: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
            textWidthRatio: textWidthRatio,
            lineSpacing: lineSpacing,
            horizontalPosition: horizontalPosition,
            verticalPosition: verticalPosition,
            alignment: alignment,
            renderScale: 1.0
        )
        .environment(
            \.colorScheme,
            .light
        )

        let renderer =
            ImageRenderer(
                content: canvas
            )

        // 1 point = 1 pixel
        renderer.scale = 1.0

        renderer.isOpaque = true

        guard let cgImage =
                renderer.cgImage
        else {
            return nil
        }

        let bitmap =
            NSBitmapImageRep(
                cgImage: cgImage
            )

        return bitmap.representation(
            using: .png,
            properties: [:]
        )
    }

    private static func sanitizedFilename(
        _ filename: String
    ) -> String {

        let trimmed =
            filename
                .trimmingCharacters(
                    in: .whitespacesAndNewlines
                )

        guard !trimmed.isEmpty else {
            return "apscis"
        }

        let invalidCharacters =
            CharacterSet(
                charactersIn:
                    "/:\\?%*|\"<>"
            )

        let pieces =
            trimmed.components(
                separatedBy:
                    invalidCharacters
            )

        let cleanName =
            pieces.joined(
                separator: "-"
            )

        return cleanName.isEmpty
            ? "apscis"
            : cleanName
    }
}
