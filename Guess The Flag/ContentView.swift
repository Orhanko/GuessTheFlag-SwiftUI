//
//  ContentView.swift
//  Guess The Flag
//
//  Created by Orhan Pojskic on 06.05.2023..
//

import SwiftUI

struct ContentView: View {
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    @State var showResult = false
    @State var alertTitle = ""
    @State var flagButtonName = ""
    @State var scoreResultText = ""
    @State var resultCounter = 0
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color(red: 0.1, green: 0.2, blue: 0.45), .gray, Color(red: 0.76, green: 0.15, blue: 0.26)]), startPoint: .topLeading, endPoint: .bottomTrailing)
            VStack{
                Spacer()
                Spacer()
                Text("Guess the flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                Spacer()
                VStack(spacing: 30){
                    VStack{
                        Text("Tap the flag for")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                            .foregroundColor(.primary)
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button{
                            flagButtonName = countries[number]
                            flagButton(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .cornerRadius(10)
                                .shadow(radius: 10)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("Result: \(resultCounter)")
                    .font(.title.bold())
                    .foregroundColor(.white)
                Spacer()
            }.alert(alertTitle, isPresented: $showResult) {
            Button("Continue", action: reset)
        } message: {
            Text(scoreResultText)
        }.padding()
            
        }.ignoresSafeArea()
    }
    func flagButton(_ number: Int){
        if number == correctAnswer{
            alertTitle = "Correct!"
            resultCounter += 1
            scoreResultText = "Your score is: \(resultCounter)"
        }else{
            alertTitle = "Wrong!"
            scoreResultText =
            """
            You tapped tha flag of \(flagButtonName)
            Your score is: \(resultCounter)
            """
        }
        showResult = true
        
    }
    func reset(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
