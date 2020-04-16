//
//  ContentView.swift
//  FlipClock
//
//  Created by 林少龙 on 2020/4/16.
//  Copyright © 2020 teeloong. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var  clock: ClockViewModel = ClockViewModel(fontSize: 40, cornerRadius: 4)
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    
    var body: some View {
        ZStack {
            VStack {
                Text("fontSize: \(clock.fontSize)")
                Slider(value: $clock.fontSize, in: verticalSizeClass == .regular ? CGFloat(40)...CGFloat(100) : CGFloat(40)...CGFloat(120))
                Text("cornerRadius: \(clock.cornerRadius)")
                Slider(value: $clock.cornerRadius, in: CGFloat(0)...CGFloat(50))
                Spacer()
            }
            ClockView(clock)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
