//
//  DetailView.swift
//  NoteDictate Watch App
//
//  Created by Akshat Gandhi on 30/10/25.
//

import SwiftUI

struct DetailView: View {
    let index: Int
    let note: Note
    let totalNoteCount: Int
    
    var body: some View {
        Text(note.text)
            .navigationTitle("Note \(index + 1)/\(totalNoteCount)")
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        DetailView(index: 1, note: Note(id: UUID(), text: "Example Test"), totalNoteCount: 5)
    }
}
