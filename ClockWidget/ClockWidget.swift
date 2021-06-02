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
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
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
        let components = DateComponents(minute: 15)
        let futureDate = Calendar.current.date(byAdding: components, to: Date())!
        Text(futureDate, style: .timer)
            .font(Font.custom("Let's go Digital Regular", size: 20))
        Text(entry.date, style: .timer)
            .font(Font.custom("Let's go Digital Regular", size: 20))
        Text(entry.date, style: .time)
            .font(Font.custom("Let's go Digital Regular", size: 20))
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
