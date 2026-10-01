# apscis

A native macOS app for creating minimal quote posts, built with SwiftUI.

## Features

- Edit quote text with a live preview.
- Choose a 4:5 post (1080 × 1350) or a 9:16 story (1080 × 1920).
- Adjust background and text colors, font size and weight, alignment, line spacing, text width, and position.
- Export one format or both formats as PNG files to a chosen location.
- Name exports with a shared base name, such as `apscis_quote_01_4x5.png` and `apscis_quote_01_9x16.png`.

## Run locally

1. Open `apscis.xcodeproj` in Xcode 27 or a compatible newer version.
2. Select the `apscis` scheme and the Mac destination.
3. If Xcode asks for signing, select your own development team under **Signing & Capabilities**.
4. Run the app with **⌘R**.

The project currently targets macOS 26.6.2. It uses SwiftUI, AppKit, and system frameworks without third-party package dependencies.

## Source files

- `apscis/ContentView.swift`: editing controls and preview.
- `apscis/PostCanvas.swift`: quote layout and rendering.
- `apscis/ExportService.swift`: PNG rendering and save dialogs.
- `apscis/PostFormat.swift`: output sizes and filename suffixes.
- `apscis/FontWeightOption.swift` and `apscis/TextAlignmentOption.swift`: typography options.
- `apscis/apscisApp.swift`: app entry point.
