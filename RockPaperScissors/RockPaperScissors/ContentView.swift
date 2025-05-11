//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Helen Dempsey on 3/23/25.
//

import SwiftUI

struct ContentView: View {
    @State private var moveChoice = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var scoreTitle = ""
    @State private var showingScore = false
    @State private var showingGameFinish = false
    @State private var playCount = 0
    
    let moves = ["🪨", "📄", "✂️"]
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.black, .gray], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                Text("Rock, Paper, Scissors")
                    .foregroundStyle(.white)
                    .font(.largeTitle.bold())
                
                Spacer()

                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title)
                
                VStack {
                    Text(moves[moveChoice])
                        .font(.system(size: 100, design: .default))
                        .padding(40)
                }
                .backgroundStyle()
                
                Spacer()
                
                VStack {
                    Text("Select move to")
                        .foregroundStyle(.white)
                        .font(.title3.bold())
                    
                    if (shouldWin == true) {
                        Text("Win")
                            .boldTitle()
                    } else {
                        Text("Lose")
                            .boldTitle()
                    }
                    
                    HStack {
                        ForEach(0..<3) { number in
                            Button {
                                movePicked(number)
                            } label: {
                                Text(moves[number])
                                    .font(.system(size: 50, design: .default))
                                    .padding(20)
                            }
                        }
                        .backgroundStyle()
                        .padding(10)
                    }
                }
                .padding()
                .alert(scoreTitle, isPresented: $showingScore) {
                    Button("Continue", action: playMove)
                }
                .alert("Final score", isPresented: $showingGameFinish) {
                    Button("Play again", action: reset)
                } message: {
                    Text("\(score)")
                        .font(.title2)
                }
            
                Spacer()
            }
            .padding(.vertical, 20)
        }
    }
    
    func movePicked(_ number: Int) {
        if (shouldWin) {
            if (moves[moveChoice] == "🪨") {
                if (moves[number] == "📄") {
                    scoreTitle = "Correct!"
                    score += 1
                } else if (moves[number] == "✂️") {
                    scoreTitle = "Oops, wrong."
                    score -= 1
                } else {
                    scoreTitle = "Draw"
                }
            }
            
            if (moves[moveChoice] == "📄") {
                if (moves[number] == "🪨") {
                    scoreTitle = "Oops, wrong."
                    score -= 1
                } else if (moves[number] == "✂️") {
                    scoreTitle = "Correct!"
                    score += 1
                } else {
                    scoreTitle = "Draw"
                }
            }
            
            if (moves[moveChoice] == "✂️") {
                if (moves[number] == "🪨") {
                    scoreTitle = "Correct!"
                    score += 1
                } else if (moves[number] == "📄") {
                    scoreTitle = "Oops, wrong."
                    score -= 1
                } else {
                    scoreTitle = "Draw"
                }
            }
        }
        
        if (!shouldWin) {
            if (moves[moveChoice] == "🪨") {
                if (moves[number] == "📄") {
                    scoreTitle = "Oops, wrong."
                    score -= 1
                } else if (moves[number] == "✂️") {
                    scoreTitle = "Correct!"
                    score += 1
                } else {
                    scoreTitle = "Draw"
                }
            }
            
            if (moves[moveChoice] == "📄") {
                if (moves[number] == "🪨") {
                    scoreTitle = "Correct!"
                    score += 1
                } else if (moves[number] == "✂️") {
                    scoreTitle = "Oops, wrong."
                    score -= 1
                } else {
                    scoreTitle = "Draw"
                }
            }
            
            if (moves[moveChoice] == "✂️") {
                if (moves[number] == "🪨") {
                    scoreTitle = "Oops, wrong."
                    score -= 1
                } else if (moves[number] == "📄") {
                    scoreTitle = "Correct!"
                    score += 1
                } else {
                    scoreTitle = "Draw"
                }
            }
        }
        
        playCount += 1
        
        if (playCount == 10) {
            showingGameFinish = true
        }
        
        showingScore = true
    }
    
    func playMove() {
        shouldWin.toggle()
        moveChoice = Int.random(in: 0...2)
    }
    
    func reset() {
        score = 0
        playMove()
    }
}

struct BoldTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.white)
            .font(.title.bold())
    }
}

struct BackgroundStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(.regularMaterial.opacity(0.6))
            .clipShape(.rect(cornerRadius: 20))
    }
}

extension View {
    func boldTitle() -> some View {
        modifier(BoldTitle())
    }
    
    func backgroundStyle() -> some View {
        modifier(BackgroundStyle())
    }
}

#Preview {
    ContentView()
}
