//
//  GameView.swift
//  MultiplicationTables
//
//  Created by Helen Dempsey on 4/20/25.
//

import SwiftUI

struct GameView: View {
    @State private var multiplier = Int.random(in: 2...12)
    @State private var correctAnswer = 0
    @State private var submittedAnswer = ""
    @State private var alertTitle = ""
    @State private var showingAlert = false
    @State private var showingGameFinish = false
    @State private var score = 0
    @State private var questionsAsked = 0
    @Environment(\.dismiss) private var dismiss
    
    let animals: [String]
    let multiplicand: Int
    let questions: Int
    let backgroundTheme: Color
    let foregroundTheme: Color
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Spacer()
                
                HStack {
                    VStack {
                        AnimalMultiplicand(image: animals[multiplicand - 2])
                        
                        Text("\(multiplicand)")
                            .font(.system(size: 48).bold())
                            .foregroundStyle(foregroundTheme)
                    }
                    .padding(10)
                    
                    Text("×")
                        .font(.system(size: 48).bold())
                        .foregroundStyle(foregroundTheme)
                    
                    VStack{
                        AnimalMultiplicand(image: animals[multiplier - 2])
                        
                        Text("\(multiplier)")
                            .font(.system(size: 48).bold())
                            .foregroundStyle(foregroundTheme)
                    }
                    .padding(10)
                }
                .frame(height: 200)

                TextField("Type your answer", text: $submittedAnswer)
                    .font(.system(size: 30))
                    .foregroundStyle(foregroundTheme)
                    .multilineTextAlignment(.center)
                    .padding(20)
                    .keyboardType(.numberPad)

                Button("Submit") {
                    checkAnswer(submittedAnswer)
                }
                .font(.title)
                .foregroundStyle(foregroundTheme)
                .alert(alertTitle, isPresented: $showingAlert) {
                    Button("Continue", action: askQuestion)
                } message: {
                    if (alertTitle == "Correct!") {
                        Text("Your score is \(score)")
                    } else {
                        Text("Try again next time.")
                    }
                }
                .alert("You won!", isPresented: $showingGameFinish) {
                    Button("Play again", action: reset)
                    Button("Go home") {
                        dismiss()
                    }
                }
                Spacer()
                
                Text("Score: \(score)")
                    .font(.title.bold())
                    .foregroundStyle(foregroundTheme)
            }
            .padding(30)
            .background(backgroundTheme)
            .navigationBarBackButtonHidden(true)
        }
    }
    
    func checkAnswer(_ answer: String) {
        correctAnswer = multiplier * multiplicand
        
        if Int(answer) == correctAnswer {
            alertTitle = "Correct!"
            score += 1
        } else {
            alertTitle = "Incorrect."
        }
        
        showingAlert = true
        questionsAsked += 1
        submittedAnswer = ""
    }
    
    func askQuestion() {
        if questionsAsked != questions {
            multiplier = Int.random(in: 1...12)
        } else {
            showingGameFinish = true
        }
    }
    
    func reset() {
        score = 0
        askQuestion()
    }
}

#Preview {
    GameView(animals: ["bear", "chicken", "cow", "elephant", "frog", "giraffe", "narwhal", "penguin", "pig", "sloth", "zebra"], multiplicand: 2, questions: 5, backgroundTheme: Color(red: 0.6, green: 0.412, blue: 0.255), foregroundTheme: Color.black)
}
