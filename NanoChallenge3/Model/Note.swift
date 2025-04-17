//
//  Note.swift
//  NanoChallenge3
//
//  Created by Hans Arthur Cupiterson on 15/07/24.
//

import Foundation
import SwiftData

@Model
final class Note {
    var sequence: Int
    var prompt: String
    var encodedText: Data?
    var owner: JournalContainer?
    
    init(sequence: Int, prompt: String, encodedText: Data? = nil, owner: JournalContainer?) {
        self.sequence = sequence
        self.prompt = prompt
        self.encodedText = encodedText
        self.owner = owner
    }
}
