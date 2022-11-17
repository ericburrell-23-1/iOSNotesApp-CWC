//
//  NewNoteView.swift
//  CWC Notes App
//
//  Created by Eric Burrell on 11/14/22.
//

import SwiftUI

struct NewNoteView: View {
    // MARK: - PROPERTIES
    @State var noteTitle: String = ""
    @State var noteText: String = ""

    // MARK: - BODY
    var body: some View {
        VStack(alignment:.leading) {
            TextField("Note Title", text: $noteTitle)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 10)
                .padding(.top, 5)
            if #available(iOS 16.0, *) {
                TextField("New note...", text: $noteText, axis: .vertical)
                    .lineLimit(5...10)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal, 10)
                    .padding(.top, 15)
            } else {
                Text("New note:")
                    .font(.footnote)
                    .foregroundColor(.accentColor)
                    .padding(.leading, 5)
                TextEditor(text: $noteText)
                    .textFieldStyle(.roundedBorder)
            }
            Spacer()
        }
        .navigationTitle("Add Note")
        .toolbar {
            HStack {
                Button {
                    print("Note deleted!")
                } label: {
                    Text("Delete")
                        .foregroundColor(.red)
                }
                Button {
                    print("Note saved!")
                } label: {
                    Text("Save")
                        .foregroundColor(.accentColor)
                }

            }
        }
    }
}

    // MARK: - PREVIEW
struct NewNoteView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NewNoteView()
                .previewLayout(.sizeThatFits)
                .padding()
        }
    }
}
