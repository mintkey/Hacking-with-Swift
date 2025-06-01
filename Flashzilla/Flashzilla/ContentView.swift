//
//  ContentView.swift
//  Flashzilla
//
//  Created by Helen Dempsey on 5/25/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true
    @State private var cards = [Card]()
    @State private var timeRemaining = 100
    @State private var showingEditScreen = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                
                ZStack {
                    ForEach(cards, id: \.id) { card in
                        CardView(card: card) { isCorrect in
                           withAnimation {
                               handleDiscard(card, correct: isCorrect)
                           }
                        }
                        .stacked(card: card, in: cards)
                        .allowsHitTesting(card == cards.last)
                        .accessibilityHidden(card != cards.last)
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                
                if cards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(.white)
                        .foregroundStyle(.black)
                        .clipShape(.capsule)
                }
            }
            
            VStack {
                HStack {
                    Spacer()

                    Button {
                        showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(.circle)
                    }
                }

                Spacer()
            }
            .foregroundStyle(.white)
            .font(.largeTitle)
            .padding()
            
            if accessibilityDifferentiateWithoutColor || accessibilityVoiceOverEnabled {
                VStack {
                    Spacer()

                    HStack {
                        Button {
                            if let card = cards.last {
                                withAnimation {
                                    handleDiscard(card, correct: false)
                                }
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(.circle)
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as being incorrect.")

                        Spacer()

                        Button {
                            if let card = cards.last {
                                withAnimation {
                                    handleDiscard(card, correct: true)
                                }
                            }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(.circle)
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark your answer as being correct.")
                    }
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onReceive(timer) { time in
            guard isActive else { return }

            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                if cards.isEmpty == false {
                    isActive = true
                }
            } else {
                isActive = false
            }
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards, content: EditCards.init)
        .onAppear(perform: resetCards)
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decoded
            }
        }
    }
    
    func handleDiscard(_ card: Card, correct: Bool) {
        if let index = cards.firstIndex(of: card) {
            let removed = cards.remove(at: index)
            
            print("Removed card: \(removed.prompt)")

            if !correct {
                let newCard = Card(id: UUID(), prompt: removed.prompt, answer: removed.answer)
                cards.insert(newCard, at: 0)
            }
        }
        
        if cards.isEmpty {
            isActive = false
        }
        print("Current cards: \(cards.map(\.prompt))")
        
    }
    
    func resetCards() {
        timeRemaining = 100
        isActive = true
        loadData()
    }
}

extension View {
    func stacked(card: Card, in cards: [Card]) -> some View {
        let offset: Double

        if let index = cards.firstIndex(of: card) {
            offset = Double(cards.count - index)
        } else {
            offset = 0
        }

        return self.offset(y: offset * 10)
    }
}

#Preview {
    ContentView()
}
