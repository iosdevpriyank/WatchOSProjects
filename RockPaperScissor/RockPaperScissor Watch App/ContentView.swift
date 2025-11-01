//
//  ContentView.swift
//  RockPaperScissor Watch App
//
//  Created by Akshat Gandhi on 01/11/25.
//

import SwiftUI
internal import Combine

struct ContentView: View {
    @State private var question = "rock"
    @State private var title = "Win!"
    @State private var shouldWin = true
    @State private var level = 1
    @State private var currentTime = Date.now
    @State private var startTime = Date.now
    @State private var gameOver = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    
    let moves = ["rock", "paper", "scissors"]
    @State private var shuffledMoves = ["rock", "paper", "scissors"]
    var time: Int {
        let difference = currentTime.timeIntervalSince(startTime)
        return Int(difference)
    }
    var totalRound = 20
    
    var body: some View {
        NavigationStack {
            if gameOver {
                Text("You win!")
                    .font(.largeTitle)
                Text("Yor time is \(time) seconds")
                Button("Play Again") {
                    startTime = Date.now
                    gameOver = false
                    level = 1
                    newLevel()
                }
                .tint(.green)
            } else {
                Image(question)
                    .resizable()
                    .scaledToFit()
                    .navigationTitle(title)
                
                Divider()
                    .padding(.vertical)
                
                HStack {
                    ForEach(shuffledMoves, id: \.self) { move in
                        Button {
                            select(move: move)
                        } label: {
                            Image(move)
                                .resizable()
                                .scaledToFit()
                        }
                        .buttonStyle(.plain)
                    }
                }
                
                HStack {
                    Text("\(level) / \(totalRound)")
                    Spacer()
                    Text("Time: \(time)")
                }
                .padding([.top,.horizontal])
            }
        }
        .onAppear(perform: newLevel)
        .onReceive(timer) { newTime in
            guard gameOver == false else { return }
            currentTime = newTime
        }
    }
    
    func select(move: String) {
        let solutions = [
            "rock": (win: "paper", lose: "scissors"),
            "paper": (win: "scissors", lose: "rock"),
            "scissors": (win: "rock", lose: "paper")
        ]
        guard let answer = solutions[question] else {
            fatalError("Unknown question: \(question)")
        }
        
        let isCorrect: Bool
        
        if shouldWin {
            isCorrect = move == answer.win
        } else {
            isCorrect = move == answer.lose
        }
        
        if isCorrect {
            level += 1
        } else {
            level -= 1
            if level < 1 { level = 1 }
        }
        
        if level == 21 {
            gameOver = true
            return
        }
        
        newLevel()
    }
    
    func newLevel() {
        if Bool.random() {
            shouldWin = true
            title = "Win!"
        } else {
            shouldWin = false
            title = "Lose!"
        }
        
        var newQuestion: String
        repeat {
            newQuestion = moves.randomElement()!
        } while newQuestion == question
        question = newQuestion
        print("Question: \(question)")
        shuffledMoves.shuffle()
    }
}

#Preview {
    ContentView()
}
