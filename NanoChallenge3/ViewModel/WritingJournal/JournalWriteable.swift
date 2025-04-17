//
//  JournalWriteable.swift
//  NanoChallenge3
//
//  Created by Hans Arthur Cupiterson on 17/07/24.
//

import Foundation
import SwiftData

protocol JournalWriteable {
    var modelContext: ModelContext? { get set }
    
    var noteText: [NSAttributedString] { get set }
    var notePrompt: [String] { get set }
    
    func finishWritingSection()
}
