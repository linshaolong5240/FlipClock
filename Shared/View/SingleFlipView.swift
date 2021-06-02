//
//  SingleFlipView.swift
//  FlipClock
//
//  Created by 林少龙 on 2020/4/15.
//  Copyright © 2020 teeloong. All rights reserved.
//

import SwiftUI

struct SingleFlipView: View {
    
    init(value: String, flipType: FlipType, fontSize: CGFloat, cornerRadius: CGFloat) {
        self.value = value
        self.type = flipType
        self.flipFontSize = fontSize
        self.flipHeight = self.flipFontSize * 1.194
        self.flipWidth = self.flipHeight * 0.75
        self.singleFlipWidth = self.flipWidth
        self.singleFlipHeight = self.flipHeight / 2
        self.flipCornerRadius = cornerRadius
    }
    
    var body: some View {
        Text(value)
            .font(.system(size: flipFontSize, weight: .heavy, design: .default))
            .frame(width: flipWidth, height: flipHeight,alignment: type.alignment)
            .foregroundColor(.flipForegroundColor)
            .background(Color.flipBackgroundColor)
            .cornerRadius(flipCornerRadius)
            .frame(width: singleFlipWidth, height: singleFlipHeight,alignment: type.alignment)
            .clipped()
    }
    
    enum FlipType {
        case top
        case bottom
        
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
    }
    let value: String
    let type: FlipType
    
    var flipFontSize: CGFloat
    var flipHeight: CGFloat
    var flipWidth: CGFloat
    var singleFlipWidth: CGFloat
    var singleFlipHeight: CGFloat
    var flipCornerRadius: CGFloat
}

struct SingleFlipView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 10) {
            SingleFlipView(value: "6", flipType: .top, fontSize: 40, cornerRadius: 4)
            SingleFlipView(value: "6", flipType: .bottom, fontSize: 40, cornerRadius: 4)
        }
    }
}
