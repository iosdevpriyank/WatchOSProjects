//
//  ContentView.swift
//  NoteDictate Watch App
//
//  Created by Akshat Gandhi on 30/10/25.
//

import SwiftUI

struct ContentView: View {
    @State private var notes: [Note] = []
    @State private var newNote: String = ""
    var body: some View {
        NavigationStack {
            HStack {
                TextField("Add a note", text: $newNote)
                    .foregroundStyle(.orange)
                Button {
                    guard !newNote.isEmpty else { return }
                    
                    let note = Note(id: UUID(), text: newNote)
                    notes.append(note)
                    newNote = ""
                } label: {
                    Image(systemName: "plus")
                        .padding()
                }
                .fixedSize()
                .tint(.orange)
                
                NavigationLink {
                    Credits()
                } label: {
                    Image(systemName: "info")
                        .padding()
                }
                .fixedSize()
                .tint(.blue)
            }
            
            List {
                ForEach(0..<notes.count, id: \.self) { index in
                    
                    NavigationLink {
                        DetailView(index: index, note: notes[index], totalNoteCount: notes.count)
                    } label: {
                        Text(notes[index].text)
                            .lineLimit(3)
                    }
                }
                .onDelete(perform: deleteNote)
            }
        }
    }
    
    private func deleteNote(offsets: IndexSet) {
        _ = withAnimation {
            notes.remove(at: offsets.first!)
        }
    }
}

#Preview {
    ContentView()
}
