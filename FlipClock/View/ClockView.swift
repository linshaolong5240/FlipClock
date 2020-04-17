//
//  Clock.swift
//  FlipClock
//
//  Created by 林少龙 on 2020/4/15.
//  Copyright © 2020 teeloong. All rights reserved.
//

import SwiftUI

struct ClockView: View {
    @ObservedObject var viewModel: ClockViewModel
    
    init(_ viewModel: ClockViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            HStack {
                ForEach(viewModel.filpViewModels) { item in
                    FlipView(item)
                }
            }
        }
    }
}

struct Clock_Previews: PreviewProvider {
    static var previews: some View {
        ClockView(ClockViewModel(fontSize: 40, cornerRadius: 4))
    }
}
