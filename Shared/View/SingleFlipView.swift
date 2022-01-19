//
//  SingleFlipView.swift
//  FlipClock
//
//  Created by 林少龙 on 2020/4/15.
//  Copyright © 2020 teeloong. All rights reserved.
//

import SwiftUI

enum FCWFlipType {
    case top
    case bottom
}

extension FCWFlipType {
    var padding: Edge.Set {
        switch self {
        case .top:
            return .top
        case .bottom:
            return .bottom
        }
    }
    
    var alignment: Alignment {
        switch self {
        case .top:
            return .top
        case .bottom:
            return .bottom
        }
    }
    
    var sparatorAlignment: Alignment {
        switch self {
        case .top:
            return .bottom
        case .bottom:
            return .top
        }
    }
    
    var sparatorColor: Color {
        switch self {
        case .top:
            return Color.black.opacity(0.33)
        case .bottom:
            return Color.white.opacity(0.33)
        }
    }

}

struct FCWSingleFlipConfiguration {

    var value: String
    var type: FCWFlipType
    
    var font: Font
    var flipHeight: CGFloat
    var flipWidth: CGFloat
    var singleFlipWidth: CGFloat
    var singleFlipHeight: CGFloat
    var flipCornerRadius: CGFloat
    
    init(value: String, type: FCWFlipType, font: UIFont, cornerRadius: CGFloat) {
        self.value = value
        self.type = type
        self.font = .custom(font.fontName, size: font.pointSize).monospacedDigit()
        self.flipHeight = font.pointSize * 1.194
        self.flipWidth = self.flipHeight * 0.75
        self.singleFlipWidth = self.flipWidth
        self.singleFlipHeight = self.flipHeight / 2
        self.flipCornerRadius = cornerRadius
    }
}

struct SingleFlipView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    let configuration: FCWSingleFlipConfiguration
    
    var body: some View {
        Text(configuration.value)
            .font(configuration.font)
            .frame(width: configuration.flipWidth, height: configuration.flipHeight, alignment: .center)
            .foregroundColor(.singleFlipForeground)
            .background(getBackground(colorScheme: colorScheme))
            .cornerRadius(configuration.flipCornerRadius)
            .frame(width: configuration.singleFlipWidth, height: configuration.singleFlipHeight, alignment: configuration.type.alignment)
            .clipped()
            .overlay(
                GeometryReader { geometry in
                    let length = geometry.size.height / 24.0
                    VStack(spacing: 0) {
                        configuration.type.sparatorColor
                            .frame(height: length)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: configuration.type.sparatorAlignment)
                }
            )
    }
    
    func getBackground(colorScheme: ColorScheme) -> some View {
        colorScheme == .light ? Color.black : Color.white
    }
}

struct SingleFlipView_Previews: PreviewProvider {
    static var previews: some View {
        let config = FCWSingleFlipConfiguration(value: "6", type: .top, font: .systemFont(ofSize: 200, weight: .heavy), cornerRadius: 20)
        let config2 = FCWSingleFlipConfiguration(value: "6", type: .bottom, font: .systemFont(ofSize: 200, weight: .heavy), cornerRadius: 20)
        VStack(spacing: 0) {
            SingleFlipView(configuration: config)
            SingleFlipView(configuration: config2)
        }
        .preferredColorScheme(.light)
        VStack(spacing: 0) {
            SingleFlipView(configuration: config)
            SingleFlipView(configuration: config2)
        }
        .preferredColorScheme(.dark)
    }
}
