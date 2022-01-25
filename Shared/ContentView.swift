//
//  ContentView.swift
//  Shared
//
//  Created by 林少龙 on 2021/6/2.
//

import SwiftUI

struct ContentView: View {
    #if canImport(AppKit)
    @StateObject var  clock: FCFlipClockViewModel = FCFlipClockViewModel(font: .systemFont(ofSize: 240, weight: .heavy), cornerRadius: 20)
    #else
    @StateObject var  clock: FCFlipClockViewModel = FCFlipClockViewModel(font: .systemFont(ofSize: 60, weight: .heavy), cornerRadius: 20)
    #endif
    
    var body: some View {
        FCFlipClockView(viewModel: clock)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
