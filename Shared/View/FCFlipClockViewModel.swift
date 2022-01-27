//
//  FCFlipClockViewModel.swift
//  FlipClock
//
//  Created by teenloong on 2020/4/15.
//  Copyright © 2020 teeloong. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
#if canImport(AppKit)
typealias CrossFont = NSFont
#endif
#if canImport(UIKit)
typealias CrossFont = UIFont
#endif

class FCFlipClockViewModel: ObservableObject {
    @Published var filpViewModels: [FCFlipViewModel]
    @Published var font: Font
    @Published var crossFont: CrossFont {
        didSet {
            filpViewModels = (0...5).map({_ in FCFlipViewModel(font: crossFont, cornerRadius: cornerRadius)})
        }
    }
    @Published var cornerRadius: CGFloat {
        didSet {
            filpViewModels = (0...5).map({_ in FCFlipViewModel(font: crossFont, cornerRadius: cornerRadius)})
        }
    }

    private let dateFormater: DateFormatter
    private var cancellable = AnyCancellable({})
    
    init(font: CrossFont, cornerRadius: CGFloat) {
        self.font = .custom(font.fontName, size: font.pointSize)
        self.crossFont = font
        self.cornerRadius = cornerRadius
        self.filpViewModels = (0...5).map({_ in FCFlipViewModel(font: font, cornerRadius: cornerRadius)})
        dateFormater = DateFormatter()
        dateFormater.dateFormat = "HHmmss"
        setFlipViewModel(time: dateFormater.string(from: Date()))
        setTimer()
    }
    
    func setTimer() {
        cancellable = Timer.publish(every: 1, on: .main, in: .default)
            .autoconnect()
            .map({[dateFormater] in dateFormater.string(from: $0)})
            .sink() {[weak self] in
                self?.setFlipViewModel(time: $0)
            }
    }
    
    func setFlipViewModel(time: String) {
        zip(time, filpViewModels).forEach { (char, viewModel) in
            viewModel.updateValue(String(char))
        }
    }
}
