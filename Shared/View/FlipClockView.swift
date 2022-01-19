//
//  Clock.swift
//  FlipClock
//
//  Created by 林少龙 on 2020/4/15.
//  Copyright © 2020 teeloong. All rights reserved.
//

import SwiftUI

struct FlipClockView: View {
    @ObservedObject var viewModel: FlipClockViewModel
    
    var body: some View {
        VStack {
            HStack {
                ForEach(viewModel.filpViewModels) { item in
                    FlipView(viewModel: item)
                }
            }
        }
    }
}

struct Clock_Previews: PreviewProvider {
    static var previews: some View {
        FlipClockView(viewModel: FlipClockViewModel(font: .systemFont(ofSize: 60, weight: .heavy), cornerRadius: 20))
            .preferredColorScheme(.light)
        FlipClockView(viewModel: FlipClockViewModel(font: .systemFont(ofSize: 60, weight: .heavy), cornerRadius: 20))
            .preferredColorScheme(.dark)
    }
}
