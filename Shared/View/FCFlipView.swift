//
//  FCFlipView.swift
//  FlipClock
//
//  Created by teenloong on 2020/4/15.
//  Copyright © 2020 teeloong. All rights reserved.
//

import SwiftUI

struct FCFlipView: View {
    @ObservedObject var viewModel: FCFlipViewModel
    
    var body: some View {
        VStack(spacing: 0.0) {
            ZStack {
                FCSingleFlipView(configuration: viewModel.newValueTopConfiguration)
                FCSingleFlipView(configuration: viewModel.oldValueTopConfiguration)
                    .rotation3DEffect(Angle(degrees: viewModel.animateTop ? -89.99 : .zero), axis: (x: 1, y: 0.0, z: 0.0), anchor: .bottom, perspective: 0.5)
            }
            ZStack {
                FCSingleFlipView(configuration: viewModel.oldValueBottomConfiguration)
                FCSingleFlipView(configuration: viewModel.newValueBottomConfiguration)
                    .rotation3DEffect(Angle(degrees: viewModel.animateBottom ? .zero : 89.99), axis: (x: 1, y: 0.0, z: 0.0), anchor: .top,  perspective: 0.5)
            }
        }
    }
}
struct FCFlipView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = FCFlipViewModel(oldValue: "3", font: .systemFont(ofSize: 120, weight: .bold), cornerRadius: 20)
        ZStack {
            Color.background
            FCFlipView(viewModel: vm)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        vm.updateValue("4")
                    }
            }
        }
    }
}
