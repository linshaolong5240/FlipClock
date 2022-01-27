//
//  FCSecondsRefreshTimeView.swift
//  FlipClock
//
//  Created by teenloong on 2022/1/27.
//

import SwiftUI

struct FCSecondsRefreshTimeView: View {
    let date: Date
    
    public var body: some View {
        HStack(spacing: 0) {
            if let hour = Calendar.current.dateComponents(in: .current, from: date).hour {
                if hour == 0 {
                    Text("00:")
                }
                if hour > 0 && hour < 10 {
                    Text("0")
                }
            }
            Text(Calendar.current.generateTimerDate(date: date), style: .timer)
                .multilineTextAlignment(.center)
        }
    }
    
}

struct FCSecondsRefreshTimeView_Previews: PreviewProvider {
    static var previews: some View {
        FCSecondsRefreshTimeView(date: Date())
    }
}
