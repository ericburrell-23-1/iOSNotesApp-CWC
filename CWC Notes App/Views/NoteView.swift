//
//  NoteView.swift
//  CWC Notes App
//
//  Created by Eric Burrell on 11/14/22.
//

import SwiftUI

struct NoteView: View {
    // MARK: - PROPERTIES
    @Environment(\.dismiss) private var dismissNoteView
    var note: Note  // Used to initialize var "sessionNote"
    @State var sessionNote: Note = Note(_id: "", title: "", note: "", date: "")
    
    // MARK: - BODY
    var body: some View {
        VStack(alignment:.leading) {
            TextField("Note Title", text: $sessionNote.title)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 10)
            if #available(iOS 16.0, *) {
                TextField("New note...", text: $sessionNote.note, axis: .vertical)
                    .lineLimit(5...10)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal, 10)
                    .padding(.top, 15)
            } else {
                Text("Note text:")
                    .font(.footnote)
                    .foregroundColor(.accentColor)
                    .padding(.leading, 5)
                TextEditor(text: $sessionNote.note)
                    .textFieldStyle(.roundedBorder)
            }
            Spacer()
        }
        .onAppear() {
            sessionNote = note
        }
        .navigationTitle(sessionNote.title)
        .toolbar {
            HStack {
                Button {
                    //print("Note deleted!")
                    APIFunctions.functions.deleteNote(id: sessionNote._id)
                    APIFunctions.functions.fetchNotes() {
                        dismissNoteView()
                    }
                } label: {
                    HStack(spacing: 5) {
                        Image(systemName: "trash")
                        .foregroundColor(.red)
                        Text("Delete")
                            .foregroundColor(.red)
                    }
                }
                Button {
                    //print(sessionNote.note)
                    sessionNote.date = currentDate()
                    APIFunctions.functions.updateNote(date: sessionNote.date, title: sessionNote.title, note: sessionNote.note, id: sessionNote._id)
                    APIFunctions.functions.fetchNotes() {
                        dismissNoteView()
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
struct NoteView_Previews: PreviewProvider {
    static var note = Note(_id: "1", title: "Preview Note", note: "This is a sample note for the previewer", date: "11/27/1996")
    
    static var previews: some View {
        
        NavigationView {
            NoteView(note: note)
                //.previewLayout(.sizeThatFits)
                .padding()
        }
    }
}
