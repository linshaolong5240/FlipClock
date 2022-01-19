//
//  FlipViewModel.swift
//  FlipClock
//
//  Created by 林少龙 on 2020/4/15.
//  Copyright © 2020 teeloong. All rights reserved.
//

import SwiftUI

class FlipViewModel: ObservableObject, Identifiable {
    @Published var font: UIFont
    
    @Published var oldValueTopConfiguration: FCWSingleFlipConfiguration
    @Published var oldValueBottomConfiguration: FCWSingleFlipConfiguration
    @Published var newValueTopConfiguration: FCWSingleFlipConfiguration
    @Published var newValueBottomConfiguration: FCWSingleFlipConfiguration

    @Published var animateTop: Bool = false
    @Published var animateBottom: Bool = false

    init(oldValue: String = "", newValue: String = "", font: UIFont, cornerRadius: CGFloat) {
        self.oldValueTopConfiguration = .init(value: oldValue, type: .top, font: font, cornerRadius: cornerRadius)
        self.oldValueBottomConfiguration = .init(value: oldValue, type: .bottom, font: font, cornerRadius: cornerRadius)
        self.newValueTopConfiguration = .init(value: newValue, type: .top, font: font, cornerRadius: cornerRadius)
        self.newValueBottomConfiguration = .init(value: newValue, type: .bottom, font: font, cornerRadius: cornerRadius)

        self.font = font
    }
    
    func updateValue(_ newValue: String) {
        guard newValueTopConfiguration.value != newValue else {
            return
        }
        
        newValueTopConfiguration.value = newValue
        newValueBottomConfiguration.value = newValue

        animateTop = false
        animateBottom = false

        withAnimation(.easeIn(duration: 0.3)) { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.animateTop = true
        }
        
        withAnimation(.easeOut(duration: 0.3).delay(0.3)) { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.animateBottom = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.oldValueTopConfiguration.value = newValue
            weakSelf.oldValueBottomConfiguration.value = newValue
        }
    }
}
