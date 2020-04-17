//
//  ClockViewModel.swift
//  FlipClock
//
//  Created by 林少龙 on 2020/4/15.
//  Copyright © 2020 teeloong. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class ClockViewModel: ObservableObject {
    @Published var filpViewModels: [FlipViewModel]
    @Published var fontSize: CGFloat {
        didSet {
            filpViewModels = (0...5).map({_ in FlipViewModel(fontSize: fontSize, cornerRadius: cornerRadius)})
        }
    }
    @Published var cornerRadius: CGFloat {
        didSet {
            filpViewModels = (0...5).map({_ in FlipViewModel(fontSize: fontSize, cornerRadius: cornerRadius)})
        }
    }

    private let dateFormater: DateFormatter
    private var cancellable = AnyCancellable({})
    init(fontSize: CGFloat, cornerRadius: CGFloat = 4) {
        self.fontSize = fontSize
        self.cornerRadius = cornerRadius
        self.filpViewModels = (0...5).map({_ in FlipViewModel(fontSize: fontSize, cornerRadius: cornerRadius)})

        dateFormater = DateFormatter()
        dateFormater.dateFormat = "HHmmss"
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
