//
//  FlipView.swift
//  FlipClock
//
//  Created by 林少龙 on 2020/4/15.
//  Copyright © 2020 teeloong. All rights reserved.
//

import SwiftUI

struct FlipView: View {
    @ObservedObject var viewModel: FlipViewModel
    
    var body: some View {
        VStack(spacing: 0.0) {
            ZStack {
                SingleFlipView(configuration: viewModel.newValueTopConfiguration)
                SingleFlipView(configuration: viewModel.oldValueTopConfiguration)
                    .rotation3DEffect(Angle(degrees: viewModel.animateTop ? -89.99 : .zero), axis: (x: 1, y: 0.0, z: 0.0), anchor: .bottom, perspective: 0.5)
            }
            ZStack {
                SingleFlipView(configuration: viewModel.oldValueBottomConfiguration)
                SingleFlipView(configuration: viewModel.newValueBottomConfiguration)
                    .rotation3DEffect(Angle(degrees: viewModel.animateBottom ? .zero : 89.99), axis: (x: 1, y: 0.0, z: 0.0), anchor: .top,  perspective: 0.5)
            }
        }
    }
}
struct FlipView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = FlipViewModel(oldValue: "3", font: .systemFont(ofSize: 120, weight: .bold), cornerRadius: 20)
        FlipView(viewModel: vm)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    vm.updateValue("4")
                }
            }
    }
}
