//
//  ClockWidget.swift
//  ClockWidget
//
//  Created by qfdev on 2021/6/2.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> ClockEntry {
        ClockEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (ClockEntry) -> ()) {
        let entry = ClockEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [ClockEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let firstDate = Date() + TimeInterval(2)
        let firstHourDate = firstDate.nextHour()
        entries.append(ClockEntry(date: firstDate))
        entries.append(ClockEntry(date: firstHourDate))
        for hourOffset in 1 ..< 24 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: firstHourDate)!
            let entry = ClockEntry(date: entryDate)
            #if DEBUG
            print(entryDate)
            #endif
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct ClockEntry: TimelineEntry {
    let date: Date
}

struct SecondsRefreshTimeView: View {
    private let date: Date
    
    public init(_ date: Date) {
        self.date = date
    }
    
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

struct ClockWidgetEntryView : View {
    @Environment(\.widgetFamily) private var family
    
    var entry: Provider.Entry
    
    var body: some View {
        SecondsRefreshTimeView(entry.date)
            .font(Font.custom("LESLIE", size: family == .systemSmall ? 30 : 60))
    }
}

@main
struct ClockWidget: Widget {
    let kind: String = "ClockWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            ClockWidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemSmall, .systemMedium])
        .configurationDisplayName("Digital Clock")
        .description("This is an example widget.")
    }
}

struct ClockWidget_Previews: PreviewProvider {
    static var previews: some View {
        ClockWidgetEntryView(entry: ClockEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        ClockWidgetEntryView(entry: ClockEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
