//
//  WritingNotesView.swift
//  NanoChallenge3
//
//  Created by Hans Arthur Cupiterson on 14/07/24.
//

import SwiftUI
import RichTextKit

struct WritingJournalView: View {
    let journalPrompt: String?
    
    @Binding var text: NSAttributedString
    @StateObject private var context = RichTextContext()
    
    @FocusState private var isFocused: Bool
    @State private var noteSavedStatus: Bool = false
    
    @State private var isConfirmationDialogPresented: Bool = false
    @State private var isShowingImagePicker: Bool = false
    @State private var imageSourceType: ImageSourceType = .photoLibrary
    @State private var inputImage: UIImage?
    
    var body: some View {
        VStack(alignment: .leading) {
            if let journalPrompt = journalPrompt {
                Text(journalPrompt)
                    .font(.title3)
                    .fontWeight(.semibold)
            }
            
            VStack {
                RichTextEditor(text: $text, context: context)
                    .focusedValue(\.richTextContext, context)
                    .focused($isFocused)
                    .onAppear(){
                        isFocused = true
                    }
                RichTextKeyboardToolbar(
                    context: context,
                    leadingButtons: {_ in },
                    trailingButtons: {_ in
                        Button(action: {
                            isConfirmationDialogPresented = true
                        }, label: {
                            Image(systemName: "photo")
                        })
                    },
                    formatSheet: {$0}
                )
            }
            .richTextEditorStyle(
                .init(font: .systemFont(ofSize: 16),
                      fontColor: .textColor)
            )
            .confirmationDialog("Select source", isPresented: $isConfirmationDialogPresented, actions: {
                Button("Camera") {
                    self.imageSourceType = .camera
                    self.isShowingImagePicker = true
                }
                Button("Photo Library") {
                    self.imageSourceType = .photoLibrary
                    self.isShowingImagePicker = true
                }
            })
            .sheet(isPresented: $isShowingImagePicker, onDismiss: {
                if let inputImage = inputImage {
                    loadImageIntoNSAttributeStringCursor(context: context, inputImage: inputImage)
                    self.inputImage = nil
                    
    //                print("Text successfully modified to \(text.string)")
                }
            }, content: {
                switch imageSourceType {
                case .camera:
                    CameraImagePicker(image: $inputImage, sourceType: .camera)
                case .photoLibrary:
                    PhotoLibraryPicker(selectedImage: $inputImage)
                }
            })
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
    }
}

#Preview {
    WritingJournalView(journalPrompt: String(localized: "Write a letter to yourself."), text: .constant(NSAttributedString(string: "")))
}
