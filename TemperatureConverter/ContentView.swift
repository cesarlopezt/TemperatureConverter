//
//  ContentView.swift
//  TemperatureConverter
//
//  Created by Cesar Lopez on 3/4/23.
//

import SwiftUI

struct ContentView: View {
    @State private var temperature = 20.0
    @State private var fromMetric = "Celsius"
    @State private var toMetric = "Fahrenheit"
    @FocusState private var tempIsFocused
    
    private var metrics = ["Celsius", "Fahrenheit", "Kelvin"]
    private var resultTemp: Double {
        if (fromMetric == toMetric) { return temperature }
        if (fromMetric == "Celsius" && toMetric == "Fahrenheit") {
            return (temperature * 9/5) + 32
        }
        if (fromMetric == "Fahrenheit" && toMetric == "Celsius") {
            return (temperature - 32) * 5/9
        }
        if (fromMetric == "Celsius" && toMetric == "Kelvin") {
            return temperature + 273.15
        }
        if (fromMetric == "Kelvin" && toMetric == "Celsius") {
            return temperature - 273.15
        }
        if (fromMetric == "Fahrenheit" && toMetric == "Kelvin") {
            return (temperature - 32) * 5/9 + 273.15
        }
        if (fromMetric == "Kelvin" && toMetric == "Fahrenheit") {
            return (temperature - 273.15) * 9/5 + 32
        }
        return 0
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Temperature from", selection: $fromMetric) {
                        ForEach(metrics, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                    
                    
                    TextField("Temperature", value: $temperature, format: .number).keyboardType(.decimalPad).focused($tempIsFocused)
                } header: {
                    Text("Temperature from:")
                }
                
                Section {
                    Picker("Temperature to", selection: $toMetric) {
                        ForEach(metrics, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                    Text(resultTemp, format: .number)
                    
                } header: {
                    Text("Temperature to:")
                }
            }
            .navigationBarTitle("Temp. Converter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("OK") {
                        tempIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
