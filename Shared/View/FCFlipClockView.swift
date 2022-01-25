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
                HStack(spacing: viewModel.crossFont.pointSize / 10.0) {
                    FCFlipView(viewModel: viewModel.filpViewModels[0])
                    FCFlipView(viewModel: viewModel.filpViewModels[1])
                    Text(":")
                        .font(viewModel.font)
                    FCFlipView(viewModel: viewModel.filpViewModels[2])
                    FCFlipView(viewModel: viewModel.filpViewModels[3])
                    Text(":")
                        .font(viewModel.font)
                    FCFlipView(viewModel: viewModel.filpViewModels[4])
                    FCFlipView(viewModel: viewModel.filpViewModels[5])
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
