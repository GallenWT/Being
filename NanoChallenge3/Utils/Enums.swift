//
//  Enums.swift
//  NanoChallenge3
//
//  Created by Hans Arthur Cupiterson on 15/07/24.
//

import Foundation

enum ImageSourceType {
    case camera
    case photoLibrary
}

enum JournalType: Codable, Hashable {
    case morning
    case evening
    case anxiousJournal
}

enum Emotion: String, Codable, Hashable {
    case happy = "Happy"
    case anxiety = "Anxiety"
    case none = "Nil"
}

enum BeingButtonRole {
    case proceed
    case cancel
    case delete
}
