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
    
    init(_ viewModel: FlipViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 0.0) {
                ZStack {
                    SingleFlipView(value: viewModel.newValue ?? "",
                                   flipType: .top,
                                   fontSize: viewModel.flipFontSize,
                                   cornerRadius: viewModel.flipCornerRadius )
                    SingleFlipView(value: viewModel.oldValue ?? "",
                                   flipType: .top,
                                   fontSize: viewModel.flipFontSize,
                                   cornerRadius: viewModel.flipCornerRadius)
                        .rotation3DEffect(Angle(degrees: viewModel.animateTop ? -90 : .zero), axis: (x: 1, y: 0.0, z: 0.0), anchor: .bottom, perspective: 0.5)
                }
                ZStack {
                    SingleFlipView(value: viewModel.oldValue ?? "",
                                   flipType: .bottom,
                                   fontSize: viewModel.flipFontSize,
                                   cornerRadius: viewModel.flipCornerRadius)
                    SingleFlipView(value: viewModel.newValue ?? "",
                                   flipType: .bottom,
                                   fontSize: viewModel.flipFontSize,
                                   cornerRadius: viewModel.flipCornerRadius)
                        .rotation3DEffect(Angle(degrees: viewModel.animateBottom ? .zero : 90), axis: (x: 1, y: 0.0, z: 0.0), anchor: .top,  perspective: 0.5)
                }
            }
            Color.flipSparatorColor.frame(height: 1)
        }
        .fixedSize()
    }
}
struct FlipView_Previews: PreviewProvider {
    static var previews: some View {
        FlipView(FlipViewModel(old: "3", new: "3"))
    }
}
