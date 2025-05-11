//
//  ContentView.swift
//  BetterRest
//
//  Created by Helen Dempsey on 3/26/25.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 0
    
    @State private var alertTitle = ""
    @State private var sleepTimeText = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    var body: some View {
        NavigationStack {
            Form {
                VStack(alignment: .leading, spacing: 0) {
                    Text("When do you want to wake up?")
                        .font(.headline)
                    
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                .onChange(of: wakeUp) {
                    calculateBedtime()
                }

                VStack(alignment: .leading, spacing: 0) {
                    Text("Desired amount of sleep")
                        .font(.headline)
                    
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                .onChange(of: sleepAmount) {
                    calculateBedtime()
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Daily coffee intake")
                        .font(.headline)
                    
                    Picker("^[\(coffeeAmount + 1) cup](inflect: true)", selection: $coffeeAmount) {
                        ForEach(1..<21) {
                            Text("\($0)")
                        }
                    }
                }
                .onChange(of: coffeeAmount) {
                    calculateBedtime()
                }
                
                Section("Ideal bedtime") {
                    Text(sleepTimeText)
                        .font(.largeTitle)
                }
            }
            .navigationTitle("BetterRest")
        }
    }
    
    func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep

            sleepTimeText = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            sleepTimeText = "Error"
        }
    }
}

#Preview {
    ContentView()
}
