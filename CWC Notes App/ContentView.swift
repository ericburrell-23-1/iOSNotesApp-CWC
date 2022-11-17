//
//  ContentView.swift
//  CWC Notes App
//
//  Created by Eric Burrell on 11/14/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var notesArray = [Note]()
    
    var body: some View {
        NavigationView {
            List {
                ForEach($notesArray, id: \.self) { $note in
                    NavigationLink(destination: NoteView(note: $note)) {
                        Text(note.title)
                    }
                }
            }
            .navigationTitle("Notes")
            .refreshable {
                APIFunctions.functions.fetchNotes()
            }
            .toolbar {
                NavigationLink(destination: {
                    NewNoteView()
                }) {
                    HStack(spacing: 5) {
                        Image(systemName: "plus")
                        Text("Add Note")
                            .fontWeight(.bold)
                    }
                    .foregroundColor(.accentColor)
                }
            }
        }
        .onAppear() {
            APIFunctions.functions.delegate = self
            APIFunctions.functions.fetchNotes()
            print(notesArray)
        }
    }
}

extension ContentView: DataDelegate {
    mutating func updateArray(with newArray: String) {
        do {
            notesArray = try JSONDecoder().decode([Note].self, from: newArray.data(using: .utf8)!)
            print("notesArray is \(notesArray)")
        } catch {
            print("Failed to decode!")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
