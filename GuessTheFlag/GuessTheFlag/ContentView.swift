//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Helen Dempsey on 3/22/25.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var countryTapped = ""
    @State private var showingGameFinish = false
    @State private var animationAmount = 0.0
    @State private var opacityAmount = 1.0
    @State private var scaleAmount = 1.0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(image: countries[number])
                        }
                        .rotation3DEffect(.degrees(number == correctAnswer ? self.animationAmount : 0), axis: (x: 0, y: 1, z: 0))
                        .opacity(number == correctAnswer ? 1.0 : self.opacityAmount)
                        .scaleEffect(number == correctAnswer ? 1.0 : self.scaleAmount, anchor: .center)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                .alert(scoreTitle, isPresented: $showingScore) {
                    Button("Continue", action: askQuestion)
                } message: {
                    if (scoreTitle == "Correct!") {
                        Text("Your score is \(score)")
                    } else {
                        Text("That's the flag of \(countryTapped)")
                    }
                }
                .alert("You won!", isPresented: $showingGameFinish) {
                    Button("Play again", action: reset)
                }
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            score += 1
            
            withAnimation {
                animationAmount += 360
                opacityAmount -= 0.75
                scaleAmount -= 1.0
            }
            
            if (score == 8) {
                showingGameFinish = true
            }
        } else {
            scoreTitle = "Wrong!"
            countryTapped = countries[number]
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        opacityAmount = 1.0
        scaleAmount = 1.0
        
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func reset() {
        score = 0
        askQuestion()
    }
}

struct FlagImage: View {
    var image: String
    
    var body: some View {
        Image(image)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}

#Preview {
    ContentView()
}
