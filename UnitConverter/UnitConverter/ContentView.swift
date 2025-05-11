//
//  ContentView.swift
//  UnitConverter
//
//  Created by Helen Dempsey on 3/18/25.
//

import SwiftUI

struct ContentView: View {
    @State private var inputNumber = 0.0
    @State private var inputUnit = "meters"
    @State private var outputUnit = "feet"
    @FocusState private var inputIsFocused: Bool
    
    let units = ["meters", "kilometers", "feet", "yards", "miles"]
    
    var convertedOutput: Double {
        let metricConversionFactor: Double = 3.28084
        var inputConvertedToBase = inputNumber
        var output: Double = 0.0
        
        // convert to feet, the smallest base unit
        switch inputUnit {
        case "meters": inputConvertedToBase *= metricConversionFactor
        case "kilometers": inputConvertedToBase *= metricConversionFactor * 1000
        case "yards": inputConvertedToBase *= 3
        case "miles": inputConvertedToBase *= 5280
        default: return inputNumber
        }
        
        switch outputUnit {
        case "meters": output = inputConvertedToBase / metricConversionFactor
        case "kilometers": output = inputConvertedToBase / (metricConversionFactor * 1000)
        case "yards": output = inputConvertedToBase / 3
        case "miles": output = inputConvertedToBase / 5280
        default: return inputConvertedToBase
        }
        
        return output
    }
    
    var body: some View {
        Form {
            Section {
                Picker("Convert from:", selection: $inputUnit) {
                    ForEach(units, id: \.self) {
                        Text($0)
                    }
                }
                
                Picker("To:", selection: $outputUnit) {
                    ForEach(units, id: \.self) {
                        Text($0)
                    }
                }
            }
            
            Section("Input value") {
                TextField("Input value", value: $inputNumber, format: .number)
                    .keyboardType(.decimalPad)
                    .focused($inputIsFocused)
            }
            
            Section("Converted value") {
                Text(convertedOutput.formatted())
            }
        }
    }
}

#Preview {
    ContentView()
}
