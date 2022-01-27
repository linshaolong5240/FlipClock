//
//  ClockWidget.swift
//  ClockWidget(macOS)
//
//  Created by teenloong on 2022/1/27.
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
        let currentDate = Date()
        var dates: [Date] = [currentDate]
        var interval = Calendar.current.dateInterval(of: .hour, for: currentDate)!
        interval.start = currentDate
        dates = Calendar.current.generateDates(inside: interval, matching: DateComponents(second: 0))
        entries = dates.map { ClockEntry(date: $0) }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct ClockEntry: TimelineEntry {
    let date: Date
}

struct ClockWidgetEntryView : View {
    @Environment(\.widgetFamily) private var family
    
    var entry: Provider.Entry
    
    var body: some View {
        FCSecondsRefreshTimeView(date: entry.date)
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

struct ClockWidget_macOS__Previews: PreviewProvider {
    static var previews: some View {
        ClockWidgetEntryView(entry: ClockEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        ClockWidgetEntryView(entry: ClockEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
