//
//  ContentView.swift
//  RPS
//
//  Created by Hozen on 2021/7/7.
//

import SwiftUI

struct ContentView: View {
    var images = ["Rock", "Scissors", "Paper"]
    var requirements = ["Win", "Lose"]
    
    @State private var userHand = 0
    
    @State private var showedHand = Int.random(in: 0..<3)
    @State private var requirement = Int.random(in: 0..<2)
    @State private var showingResult = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack {
            Spacer()
            Text(requirements[requirement])
                .font(.largeTitle)
            Image(images[showedHand])
            Spacer()
            HStack{
                ForEach(0 ..< 3) { index in
                    Button(action: {
                        handTapped(index)
                    }) {
                        Image(images[index])
                    }
                }
            }
        }.alert(isPresented: $showingResult) {
            Alert(title: Text("result"), message:
                    Text(alertMessage), dismissButton: .default(Text("Continue")) {
                        continueGame()
            })
        }
    }
    
    private func continueGame() {
        requirement = Int.random(in: 0..<2)
        showedHand = Int.random(in: 0..<3)
    }
    
    private func handTapped(_ userHand: Int) {
        if checkAnswer(userHand) {
            alertMessage = "Good!"
        } else {
            alertMessage = "Sorry"
        }
        showingResult = true
    }
    
    private func checkAnswer(_ userHand: Int) -> Bool {
        print(showedHand, userHand)
        if (requirement == 0) {
            if ((showedHand - userHand + 3) % 3 == 1) {
                return true
            }
            return false
        } else {
            if ((userHand - showedHand + 3) % 3 == 1) {
                return true
            }
            return false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
