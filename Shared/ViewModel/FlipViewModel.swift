//
//  FlipViewModel.swift
//  FlipClock
//
//  Created by 林少龙 on 2020/4/15.
//  Copyright © 2020 teeloong. All rights reserved.
//

import SwiftUI

class FlipViewModel: ObservableObject, Identifiable {
    @Published var flipFontSize: CGFloat
    @Published var flipCornerRadius: CGFloat
    
    @Published var oldValue: String?
    @Published var newValue: String?
    
    @Published var animateTop: Bool = false
    @Published var animateBottom: Bool = false

    init(old: String? = nil, new: String? = nil, fontSize: CGFloat = 40, cornerRadius: CGFloat = 4) {
        oldValue = old
        newValue = new
        self.flipFontSize = fontSize
        self.flipCornerRadius = cornerRadius
    }
    
    func updateValue(_ new: String) {
        guard newValue != new else {
            return
        }
        oldValue = newValue
        animateTop = false
        animateBottom = false

        withAnimation(.easeIn(duration: 0.3)) { [weak self] in
            self?.newValue = new
            self?.animateTop = true
        }
        withAnimation(Animation.easeOut(duration: 0.3).delay(0.3)) { [weak self] in
            self?.animateBottom = true
        }
    }
}
