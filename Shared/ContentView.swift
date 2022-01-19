//
//  ContentView.swift
//  Shared
//
//  Created by 林少龙 on 2021/6/2.
//

import SwiftUI

struct ContentView: View {
    @StateObject var  clock: FCFlipClockViewModel = FCFlipClockViewModel(font: .systemFont(ofSize: 60, weight: .heavy), cornerRadius: 20)
    
    var body: some View {
        FCFlipClockView(viewModel: clock)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
