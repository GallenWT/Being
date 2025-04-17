//
//  NSStringHelper.swift
//  NanoChallenge3
//
//  Created by Hans Arthur Cupiterson on 15/07/24.
//

import Foundation
import UIKit
import RichTextKit

/*
 Function to convert attributed string to archive data
 EXAMPLE USAGE: let data: Data = convertAttributedStringToArchivedData(NSAttributedString(string: "Hello World"))
 */

func convertAttributedStringToArchivedData(_ attributedString: NSAttributedString) -> Data? {
    do {
        let data = try NSKeyedArchiver.archivedData(withRootObject: attributedString, requiringSecureCoding: false)
        return data
    } catch {
        print("Failed to archive NSAttributedString: \(error)")
        return nil
    }
}

/*
 Function to convert attributed string to archive data
 EXAMPLE USAGE: let string = convertDataToAttributedString(Note(data: Data()))
 */
func convertDataToAttributedString(_ note: Note) -> NSAttributedString? {
    if let encodedText = note.encodedText {
        return try? NSAttributedString(data: encodedText, format: .archivedData)
    }
    return nil
}

/*
 Function to load image into the cursor location in NSAttributeString
 EXAMPLE USAGE:
    @StateObject private var context = RichTextContext()
    @State private var inputImage: UIImage?
    loadImageIntoNSAttributeStringCursor(context: context, inputImage: inputImage)
 */
func loadImageIntoNSAttributeStringCursor(context: RichTextContext, inputImage: UIImage){
    let cursorLocation = context.selectedRange
    let insertion = RichTextInsertion<UIImage>.image(inputImage, at: cursorLocation.location, moveCursor: true)
    let action = RichTextAction.pasteImage(insertion)
    context.handle(action)
}

func convertDateToTwoDigits(_ date:Int)->String{
    if date<10{
        return "0\(date)"
    }
    else{
        return "\(date)"
    }
}
