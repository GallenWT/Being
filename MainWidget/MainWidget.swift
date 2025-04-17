//
//  MainWidget.swift
//  MainWidget
//
//  Created by Arrick Russell Adinoto on 16/07/24.
//

import WidgetKit
import SwiftUI

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
    
    let title:String
    let desc:String
    let img:String
    
}

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent(),title:"Let's start journaling!",desc:"Your thoughts deserve\na safe space",img:"WidgetAfterPrep")
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent(),title:"Let's start journaling!",desc:"Your thoughts deserve\na safe space",img:"WidgetAfterPrep")
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry =         SimpleEntry(date: Date(), configuration: ConfigurationAppIntent(),title:"Let's start journaling!",desc:"Your thoughts deserve\na safe space",img:"WidgetAfterPrep")

            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct MainWidgetEntryView : View {
    @Environment(\.widgetFamily) var widgetFamily
    var entry: Provider.Entry
    
    var boldText:String="Are you feeling\noverwhelmed by\nanxiety?"
    var thinText:String="Let’s start journaling!\nYour thoughts deserve a\nsafe space"
    
    var systemMediumText:String="Let’s start journaling!\nYour thoughts deserve\na safe space"
    
    var body: some View {
        switch widgetFamily{
            case .systemSmall :
            SystemSmallView(entry:entry)
            //boldText:boldText, thinText:thinText
            case .accessoryCircular :
            AccesoryCircularView()
            
            default :
            SystemMediumView(text:systemMediumText)
        }
    }
 
}

struct MainWidget: Widget {
    let kind: String = "Widgets2"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            MainWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .contentMarginsDisabled()
        .configurationDisplayName("My Widget")
        .description("This is a widget example.")
        .supportedFamilies([.systemMedium,.systemSmall,.accessoryCircular])

    }
}


#Preview(as: .systemMedium) {
    MainWidget()
} timeline: {
    SimpleEntry(date: Date(), configuration: ConfigurationAppIntent(),title:"Let's start journaling!",desc:"Your thoughts deserve\na safe space",img:"WidgetAfterPrep")
}
