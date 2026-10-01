//
//  ContentView.swift
//  apscis
//
//  Created by Ivan Bartol on 28.09.2026..
//

import SwiftUI

struct ContentView: View {

    // MARK: - Quote

    @State private var quote =
        """
        you don’t miss them. you miss who you were when they were there.
        """

    // MARK: - Format

    @State private var selectedFormat:
        PostFormat = .fourFive

    // MARK: - Colors

    @State private var backgroundColor:
        Color = .white

    @State private var textColor:
        Color = .black

    // MARK: - Typography

    @State private var fontSize:
        Double = 64

    @State private var fontWeight:
        FontWeightOption = .semibold

    @State private var alignment:
        TextAlignmentOption = .center

    @State private var lineSpacing:
        Double = 8

    // MARK: - Layout

    @State private var textWidthRatio:
        Double = 0.78

    @State private var horizontalPosition:
        Double = 0.50

    @State private var verticalPosition:
        Double = 0.52

    // MARK: - Export

    @State private var fileBaseName =
        "apscis_quote_01"

    @State private var errorMessage:
        String?

    var body: some View {

        HSplitView {

            controlsPanel
                .frame(
                    minWidth: 320,
                    idealWidth: 350,
                    maxWidth: 400
                )

            previewPanel
                .frame(
                    minWidth: 600
                )
        }
        .frame(
            minWidth: 1000,
            minHeight: 700
        )
        .alert(
            "Export failed",
            isPresented:
                Binding(
                    get: {
                        errorMessage != nil
                    },
                    set: { newValue in
                        if !newValue {
                            errorMessage = nil
                        }
                    }
                )
        ) {
            Button(
                "OK",
                role: .cancel
            ) {
                errorMessage = nil
            }
        } message: {
            Text(
                errorMessage ?? ""
            )
        }
    }

    // MARK: - Controls

    private var controlsPanel:
        some View {

        ScrollView {

            VStack(
                alignment: .leading,
                spacing: 20
            ) {

                VStack(
                    alignment: .leading,
                    spacing: 4
                ) {

                    Text("apscis")
                        .font(
                            .system(
                                size: 28,
                                weight: .bold
                            )
                        )

                    Text(
                        "minimal post creator"
                    )
                    .foregroundStyle(
                        .secondary
                    )
                }

                Divider()

                GroupBox("Quote") {

                    VStack(
                        alignment: .leading,
                        spacing: 8
                    ) {

                        TextEditor(
                            text: $quote
                        )
                        .font(
                            .system(
                                size: 15
                            )
                        )
                        .frame(
                            minHeight: 120
                        )

                        Text(
                            "\(quote.count) characters"
                        )
                        .font(.caption)
                        .foregroundStyle(
                            .secondary
                        )
                    }
                    .padding(4)
                }

                GroupBox("Format") {

                    VStack(
                        alignment: .leading,
                        spacing: 10
                    ) {

                        Picker(
                            "Format",
                            selection:
                                $selectedFormat
                        ) {

                            ForEach(
                                PostFormat
                                    .allCases
                            ) { format in

                                Text(
                                    format.rawValue
                                )
                                .tag(format)
                            }
                        }
                        .pickerStyle(
                            .segmented
                        )

                        Text(
                            selectedFormat
                                .description
                        )
                        .font(.caption)
                        .foregroundStyle(
                            .secondary
                        )
                    }
                    .padding(4)
                }

                GroupBox("Colors") {

                    VStack(
                        spacing: 12
                    ) {

                        ColorPicker(
                            "Background",
                            selection:
                                $backgroundColor,
                            supportsOpacity:
                                false
                        )

                        ColorPicker(
                            "Text",
                            selection:
                                $textColor,
                            supportsOpacity:
                                false
                        )
                    }
                    .padding(4)
                }

                GroupBox("Typography") {

                    VStack(
                        alignment: .leading,
                        spacing: 16
                    ) {

                        Picker(
                            "Weight",
                            selection:
                                $fontWeight
                        ) {

                            ForEach(
                                FontWeightOption
                                    .allCases
                            ) { weight in

                                Text(
                                    weight.rawValue
                                )
                                .tag(weight)
                            }
                        }

                        LabeledSlider(
                            title: "Font size",
                            value: $fontSize,
                            range: 30...120,
                            valueText:
                                "\(Int(fontSize))"
                        )

                        LabeledSlider(
                            title: "Line spacing",
                            value:
                                $lineSpacing,
                            range: 0...40,
                            valueText:
                                "\(Int(lineSpacing))"
                        )

                        Picker(
                            "Alignment",
                            selection:
                                $alignment
                        ) {

                            ForEach(
                                TextAlignmentOption
                                    .allCases
                            ) { option in

                                Text(
                                    option.rawValue
                                )
                                .tag(option)
                            }
                        }
                        .pickerStyle(
                            .segmented
                        )
                    }
                    .padding(4)
                }

                GroupBox("Layout") {

                    VStack(
                        alignment: .leading,
                        spacing: 16
                    ) {

                        LabeledSlider(
                            title: "Text width",
                            value:
                                $textWidthRatio,
                            range: 0.35...0.95,
                            valueText:
                                "\(Int(textWidthRatio * 100))%"
                        )

                        LabeledSlider(
                            title:
                                "Horizontal position",
                            value:
                                $horizontalPosition,
                            range: 0.25...0.75,
                            valueText:
                                "\(Int(horizontalPosition * 100))%"
                        )

                        LabeledSlider(
                            title:
                                "Vertical position",
                            value:
                                $verticalPosition,
                            range: 0.20...0.80,
                            valueText:
                                "\(Int(verticalPosition * 100))%"
                        )
                    }
                    .padding(4)
                }

                GroupBox("Export") {

                    VStack(
                        alignment: .leading,
                        spacing: 12
                    ) {

                        TextField(
                            "Filename",
                            text:
                                $fileBaseName
                        )

                        Button {
                            exportCurrent()
                        } label: {

                            HStack {

                                Spacer()

                                Text(
                                    "Export \(selectedFormat.rawValue)"
                                )

                                Spacer()
                            }
                        }
                        .buttonStyle(
                            .borderedProminent
                        )
                        .controlSize(.large)

                        Button {
                            exportBoth()
                        } label: {

                            HStack {

                                Spacer()

                                Text(
                                    "Export Both"
                                )

                                Spacer()
                            }
                        }
                        .controlSize(.large)
                    }
                    .padding(4)
                }

                Button(
                    "Reset Style"
                ) {
                    resetStyle()
                }
                .foregroundStyle(
                    .secondary
                )

                Spacer(
                    minLength: 20
                )
            }
            .padding(20)
        }
    }

    // MARK: - Preview

    private var previewPanel:
        some View {

        GeometryReader { geometry in

            let originalSize =
                selectedFormat
                    .pixelSize

            let availableWidth =
                max(
                    geometry
                        .size
                        .width - 80,
                    1
                )

            let availableHeight =
                max(
                    geometry
                        .size
                        .height - 80,
                    1
                )

            let widthScale =
                availableWidth
                / originalSize.width

            let heightScale =
                availableHeight
                / originalSize.height

            let previewScale =
                min(
                    widthScale,
                    heightScale
                )

            VStack {

                Spacer()

                PostCanvas(
                    quote: quote,
                    format:
                        selectedFormat,
                    backgroundColor:
                        backgroundColor,
                    textColor:
                        textColor,
                    fontSize:
                        fontSize,
                    fontWeight:
                        fontWeight,
                    textWidthRatio:
                        textWidthRatio,
                    lineSpacing:
                        lineSpacing,
                    horizontalPosition:
                        horizontalPosition,
                    verticalPosition:
                        verticalPosition,
                    alignment:
                        alignment,
                    renderScale:
                        previewScale
                )
                .overlay {

                    Rectangle()
                        .stroke(
                            Color.black
                                .opacity(0.08),
                            lineWidth: 1
                        )
                }
                .shadow(
                    color:
                        .black
                        .opacity(0.08),
                    radius: 18,
                    x: 0,
                    y: 8
                )

                Spacer()
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity
            )
        }
        .background(
            Color(
                nsColor:
                    .windowBackgroundColor
            )
        )
    }

    // MARK: - Export Functions

    private func exportCurrent() {

        do {

            try ExportService
                .exportSingle(
                    quote: quote,
                    format:
                        selectedFormat,
                    backgroundColor:
                        backgroundColor,
                    textColor:
                        textColor,
                    fontSize:
                        fontSize,
                    fontWeight:
                        fontWeight,
                    textWidthRatio:
                        textWidthRatio,
                    lineSpacing:
                        lineSpacing,
                    horizontalPosition:
                        horizontalPosition,
                    verticalPosition:
                        verticalPosition,
                    alignment:
                        alignment,
                    baseName:
                        fileBaseName
                )

        } catch {

            errorMessage =
                error.localizedDescription
        }
    }

    private func exportBoth() {

        do {

            try ExportService
                .exportBoth(
                    quote: quote,
                    backgroundColor:
                        backgroundColor,
                    textColor:
                        textColor,
                    fontSize:
                        fontSize,
                    fontWeight:
                        fontWeight,
                    textWidthRatio:
                        textWidthRatio,
                    lineSpacing:
                        lineSpacing,
                    horizontalPosition:
                        horizontalPosition,
                    verticalPosition:
                        verticalPosition,
                    alignment:
                        alignment,
                    baseName:
                        fileBaseName
                )

        } catch {

            errorMessage =
                error.localizedDescription
        }
    }

    // MARK: - Reset

    private func resetStyle() {

        backgroundColor = .white
        textColor = .black

        fontSize = 64
        fontWeight = .semibold

        textWidthRatio = 0.78
        lineSpacing = 8

        horizontalPosition = 0.50
        verticalPosition = 0.52

        alignment = .center
    }
}


// MARK: - Reusable Slider

private struct LabeledSlider:
    View {

    let title: String

    @Binding var value:
        Double

    let range:
        ClosedRange<Double>

    let valueText:
        String

    var body: some View {

        VStack(
            alignment: .leading,
            spacing: 6
        ) {

            HStack {

                Text(title)

                Spacer()

                Text(valueText)
                    .foregroundStyle(
                        .secondary
                    )
                    .monospacedDigit()
            }

            Slider(
                value: $value,
                in: range
            )
        }
    }
}
