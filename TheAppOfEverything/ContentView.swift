//
//  ContentView.swift
//  TheAppOfEverything
//
//  Created by Nicholas Clooney on 12/4/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var choice1: String = "SAIC"
    @State private var choice2: String = "Goldsmith"
    @State private var result: String? = nil
    @State private var history: [String] = []


    var body: some View {
        VStack {
            Spacer()

            HStack {
                TextField("Choice #1", text: $choice1)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                TextField("Choice #2", text: $choice2)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }

            Spacer()

            Button(action: randomize) {
                Text("Choose My Fate")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()

            if let result = result {
                Text("Result: \(result)")
                    .font(.title)
                    .padding()
            }

            Spacer()

            Text("History")
                .font(.headline)
                .padding(.top)

            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(history, id: \.self) { item in
                        Text("\(index + 1)" + item)
                            .padding(.vertical, 2)
                    }
                }
            }
            .frame(maxHeight: 200) // Limit the height of the history list
            .padding()

        }
        .padding()
    }

    private func randomize() {
        let choices = [choice1, choice2].filter { !$0.isEmpty }
        if let randomChoice = choices.randomElement() {
            result = randomChoice

            history.append(randomChoice) // Add the result to the history
        } else {
            result = "Please enter at least one choice."
        }
    }
}

#Preview {
    ContentView()
}
