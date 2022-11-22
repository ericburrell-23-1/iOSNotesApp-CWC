//
//  NewNoteView.swift
//  CWC Notes App
//
//  Created by Eric Burrell on 11/14/22.
//

import SwiftUI

struct NewNoteView: View {
    // MARK: - PROPERTIES
    @Environment(\.dismiss) private var dismissNewNoteView
    @State var note: Note = Note(_id: "", title: "", note: "", date: "")

    // MARK: - BODY
    var body: some View {
        VStack(alignment:.leading) {
            TextField("Note Title", text: $note.title)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 10)
            if #available(iOS 16.0, *) {
                TextField("New note...", text: $note.note, axis: .vertical)
                    //.lineLimit(5...10)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal, 10)
                    .padding(.top, 15)
            } else {
                Text("New note:")
                    .font(.footnote)
                    .foregroundColor(.accentColor)
                    .padding(.leading, 5)
                TextEditor(text: $note.note)
                    .textFieldStyle(.roundedBorder)
            }
            Spacer()
        }
        .navigationTitle("Add Note")
        .toolbar {
            HStack {
                Button {
                    //print("Note deleted!")
                    dismissNewNoteView()
                } label: {
                    HStack(spacing: 5) {
                        Image(systemName: "trash")
                        .foregroundColor(.red)
                        Text("Cancel")
                            .foregroundColor(.red)
                    }
                }
                Button {
                    //print("Note saved!")
                    note.date = currentDate()
                    APIFunctions.functions.addNote(date: note.date, title: note.title, note: (note.note))
                    APIFunctions.functions.fetchNotes() {
                        dismissNewNoteView()
                    }
                    
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
                //.previewLayout(.sizeThatFits)
                .padding()
        }
    }
}
