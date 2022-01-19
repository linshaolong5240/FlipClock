//
//  Clock.swift
//  FlipClock
//
//  Created by 林少龙 on 2020/4/15.
//  Copyright © 2020 teeloong. All rights reserved.
//

import SwiftUI

struct FCFlipClockView: View {
    @ObservedObject var viewModel: FCFlipClockViewModel
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            VStack {
                HStack {
                    ForEach(viewModel.filpViewModels) { item in
                        FCFlipView(viewModel: item)
                    }
                }
            }
        }
    }
}

struct FCFlipClockView_Previews: PreviewProvider {
    static var previews: some View {
        FCFlipClockView(viewModel: FCFlipClockViewModel(font: .systemFont(ofSize: 60, weight: .heavy), cornerRadius: 20))
            .preferredColorScheme(.light)
        FCFlipClockView(viewModel: FCFlipClockViewModel(font: .systemFont(ofSize: 60, weight: .heavy), cornerRadius: 20))
            .preferredColorScheme(.dark)
    }
}
