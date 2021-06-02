//
//  ContentView.swift
//  Shared
//
//  Created by 林少龙 on 2021/6/2.
//

import SwiftUI

struct ContentView: View {
    @StateObject var  clock: ClockViewModel = ClockViewModel(fontSize: 40, cornerRadius: 4)
    
    var body: some View {
        VStack {
            Text("fontSize: \(clock.fontSize)")
            Slider(value: $clock.fontSize, in: CGFloat(40)...CGFloat(100))
            Text("cornerRadius: \(clock.cornerRadius)")
            Slider(value: $clock.cornerRadius, in: CGFloat(0)...CGFloat(50))
        }
        ClockView(clock)
        Spacer()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
