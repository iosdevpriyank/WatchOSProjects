//
//  Credits.swift
//  NoteDictate Watch App
//
//  Created by Akshat Gandhi on 31/10/25.
//

import SwiftUI

struct Credits: View {
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("Credits")
                .font(.headline)
                .padding()
                .underline()
            Text("This app was developed by Akshat Gandhi.")
                .foregroundStyle(.orange)
            Text("Date: \(getDate(by: Date()))")
        }
    }
    
    private func getDate(by date: Date) -> String {
        let customDateFormatter = DateFormatter()
        customDateFormatter.dateFormat = "dd/MM/yyyy"
        return customDateFormatter.string(from: date)
    }
}

#Preview {
    Credits()
}
