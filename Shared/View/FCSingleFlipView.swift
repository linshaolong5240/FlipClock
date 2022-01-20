//
//  FCSingleFlipView.swift
//  FlipClock
//
//  Created by 林少龙 on 2020/4/15.
//  Copyright © 2020 teeloong. All rights reserved.
//

import SwiftUI

enum FCFlipType {
    case top
    case bottom
}

extension FCFlipType {
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
            return Color.singleFlipSparatorTop
        case .bottom:
            return Color.singleFlipSparatorBottom
        }
    }

}

struct FCSingleFlipConfiguration {

    var value: String
    var type: FCFlipType
    
    var font: Font
    var flipHeight: CGFloat
    var flipWidth: CGFloat
    var singleFlipWidth: CGFloat
    var singleFlipHeight: CGFloat
    var flipCornerRadius: CGFloat
    
    init(value: String, type: FCFlipType, font: CrossFont, cornerRadius: CGFloat) {
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

struct FCSingleFlipView: View {
    let configuration: FCSingleFlipConfiguration
    
    var body: some View {
        Text(configuration.value)
            .font(configuration.font)
            .frame(width: configuration.flipWidth, height: configuration.flipHeight, alignment: .center)
            .foregroundColor(.singleFlipForeground)
            .background(Color.singleFlipBackground)
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
}

struct FCSingleFlipView_Previews: PreviewProvider {
    static var previews: some View {
        let config = FCSingleFlipConfiguration(value: "6", type: .top, font: .systemFont(ofSize: 200, weight: .heavy), cornerRadius: 20)
        let config2 = FCSingleFlipConfiguration(value: "6", type: .bottom, font: .systemFont(ofSize: 200, weight: .heavy), cornerRadius: 20)
        ZStack {
            Color.background
            VStack(spacing: 0) {
                FCSingleFlipView(configuration: config)
                FCSingleFlipView(configuration: config2)
            }
        }
        .preferredColorScheme(.light)
        ZStack {
            Color.background
            VStack(spacing: 0) {
                FCSingleFlipView(configuration: config)
                FCSingleFlipView(configuration: config2)
            }
        }
        .preferredColorScheme(.dark)
    }
}
