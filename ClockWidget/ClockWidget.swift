//
//  ClockWidget.swift
//  ClockWidget
//
//  Created by qfdev on 2021/6/2.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = SimpleEntry(date: entryDate)
//            entries.append(entry)
//        }
        let firstDate = Date() + TimeInterval(2)
        let firstHourDate = firstDate.nextHour()
        entries.append(SimpleEntry(date: firstDate))
        entries.append(SimpleEntry(date: firstHourDate))
        #if DEBUG
        print(firstDate,firstHourDate)
        #endif
        for hourOffset in 1 ..< 24 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: firstHourDate)!
            let entry = SimpleEntry(date: entryDate)
            #if DEBUG
            print(entryDate)
            #endif
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct ClockWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack {
            let now = entry.date
            let dateComponets = Calendar.current.dateComponents(in: .current, from: now)
            let hours = dateComponets.hour ?? 0
            let minutes = dateComponets.minute ?? 0
            let seconds = dateComponets.second ?? 0
            let components = DateComponents(hour: -hours, minute: -minutes, second: -seconds)
            let timerDate = Calendar.current.date(byAdding: components, to: now)!
            HStack(spacing: 0) {
                if hours == 0 {
                    Text("00:")
                }
                if hours > 0 && hours < 10 {
                    Text("0")
                }
                Text(timerDate, style: .timer)
                    .background(Color.red)
            }
            .font(Font.custom("LESLIE", size: 38))
        }
    }
}

@main
struct ClockWidget: Widget {
    let kind: String = "ClockWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            ClockWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct ClockWidget_Previews: PreviewProvider {
    static var previews: some View {
        ClockWidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
