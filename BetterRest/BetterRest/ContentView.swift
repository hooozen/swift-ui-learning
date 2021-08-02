//
//  ContentView.swift
//  BetterRest
//
//  Created by Hozen on 2021/7/11.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepHours = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    @State private var showingAlert = false
    
    var idelBedtime: String {
        let component = Calendar.current.dateComponents([.hour, .minute], from: weakUpDate)
        let hour = (component.hour ?? 0) * 60 * 60
        let minute = (component.minute ?? 0) * 60
        let model = SleepCalculator()
        
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepHours, coffee: Double(coffeeAmount))
            
            let sleepTime = weakUpDate - prediction.actualSleep
            let formtter = DateFormatter()
            formtter.timeStyle = .short
            return formtter.string(from: sleepTime)
        } catch {
            return "Sorry, there was a problem calculating your bedtime."
        }
    }
    
    static var defaultWakeUpTime: Date {
        var components = DateComponents()
        components.hour  = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    
    
    @State private var weakUpDate = defaultWakeUpTime
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Your ideal bedtime")) {
                    Text(idelBedtime)
                }
                
                Section(header:Text("When do you want to wake up?")) {
                    DatePicker("Please enter a time", selection: $weakUpDate, displayedComponents: .hourAndMinute).labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }
                
                Section(header: Text("Desired amount of sleeep") ) {
                    Stepper(value: $sleepHours, in: 4...12, step: 0.25) {
                        Text("\(sleepHours, specifier: "%g") hours")
                    }
                }
                
                Section(header: Text("Daily coffee intake")) {
                    Picker("coffee", selection: $coffeeAmount) {
                        ForEach(1 ..< 21) {
                            Text("\($0)").tag($0)
                        }
                    }
                    /*
                    Stepper(value: $coffeeAmount, in: 1...20) {
                        if coffeeAmount == 1 {
                            Text("1 cup")
                        } else {
                            Text("\(coffeeAmount) cups")
                        }
                    }
 */
                }
            }.navigationBarTitle("BetterRest")
            .navigationBarItems(trailing:
                                    Button(action: calculateBedtime) {
                                        Text("Calculate")
                                    }
            ).alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    func calculateBedtime() {
        let component = Calendar.current.dateComponents([.hour, .minute], from: weakUpDate)
        let hour = (component.hour ?? 0) * 60 * 60
        let minute = (component.minute ?? 0) * 60
        let model = SleepCalculator()
        
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepHours, coffee: Double(coffeeAmount))
            
            let sleepTime = weakUpDate - prediction.actualSleep
            let formtter = DateFormatter()
            formtter.timeStyle = .short
            
            alertMessage = formtter.string(from: sleepTime)
            alertTitle = "Your ideal bedtime is..."
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        showingAlert = true
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
