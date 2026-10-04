//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Mohammed Alhashim on 29/09/2026.
//

import SwiftUI

struct ContentView: View {
    
    static let allCountries = [
        "Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "US", "Ukraine"
    ]
    @State private var countries = allCountries.shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingAlert = false
    @State private var titleAlert: String = ""
    @State private var userScore: Int = 0
    @State private var messageAlert: String = ""
    @State private var selectedWrong: Int = 0
    @State private var totalTryOutOf8: Int = 0
    @State private var buttonText: String = ""
    
    var body: some View {
        ZStack{
            RadialGradient(stops:[
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)],
                    center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the flag")
                    .foregroundColor(.white)
                    .font(.largeTitle.bold())
                
                VStack(spacing: 15){
                    
                    VStack{
                        Text("Tap the flag of")
                            .foregroundColor(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                             .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0...2, id: \.self) { index in
                        
                        Button() {
                            flagTapped(index)
                        } label: {
                            Image(countries[index])
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                        
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                
                
                Spacer()
                Spacer()
                
                Text("Score: \(userScore) / 8")
                    .font(.title.weight(.semibold))
                    .foregroundColor(.white)
                Text("Progress: \(totalTryOutOf8) / 8")
                    .font(.title3)
                    .foregroundColor(.secondary)
                Spacer()
                
                    
            }
            .padding()
            .alert(titleAlert, isPresented: $showingAlert){
                Button(buttonText, action: askQuestion)
            } message: {
                Text(messageAlert)
            }
            
            
        }
        
    }
    func flagTapped(_ index: Int) {
        if index == correctAnswer {
            buttonText = "Next"
            titleAlert = "Correct"
            userScore += 1
            messageAlert = "keep Going, your score is \(userScore)"
            countries.remove(at: correctAnswer)
            
        } else {
            buttonText = "Never Give Up"
            titleAlert = "Wrong"
            userScore += (userScore > 0) ? -1 : 0
            selectedWrong = index
            messageAlert = "That's the flag of \(countries[selectedWrong]) \n Your score is \(userScore)"
        }
        showingAlert = true
        totalTryOutOf8 += 1
        
        if totalTryOutOf8 == 8 {
            buttonText = "Done"
            titleAlert = "Congratulations!!!"
            messageAlert = "You've completed the game, your score is \(userScore) out of 8"
            
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        
        if totalTryOutOf8 == 8 {
            restart()
        }
    }
    
    func restart() {
        countries = Self.allCountries
        countries.shuffle()
        userScore = 0
        totalTryOutOf8 = 0
    }
}

#Preview {
    ContentView()
}
