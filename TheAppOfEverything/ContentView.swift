//
//  ContentView.swift
//  TheAppOfEverything
//
//  Created by Nicholas Clooney on 12/4/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var choice1 = "SAIC"
    @State private var choice2 = "Goldsmith"
    @State private var result = ""
    @State private var history: [String] = []
    @State private var historyString = ""

    var body: some View {
        VStack {
            Spacer()
            inputFields
            Spacer()
            actionButtons
            resultText
            Spacer()
            historyHeader
            historyScrollView
        }
        .padding()
    }

    private func randomize() {
        let choices = [choice1, choice2].filter { !$0.isEmpty }
        if let randomChoice = choices.randomElement() {
            result = randomChoice
            history.append(randomChoice)
            historyString = history.reversed().enumerated().map { "\($0 + 1). \($1)" }.joined(separator: "\n")
        } else {
            result = "Please enter at least one choice."
        }
    }

    private func reset() {
        choice1 = ""
        choice2 = ""
        result = ""
        history = []
        historyString = ""
    }

    private var inputFields: some View {
        HStack {
            TextField("Choice #1", text: $choice1)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Choice #2", text: $choice2)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
        }
    }

    private var actionButtons: some View {
        VStack {
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

            Button(action: reset) {
                Text("Reset")
                    .font(.subheadline)
                    .padding(8)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.bottom)
        }
    }

    private var resultText: some View {
        Text("Result: \(result)")
            .font(.title)
            .padding()
    }

    private var historyHeader: some View {
        Text("History")
            .font(.headline)
            .padding(.top)
    }

    private var historyScrollView: some View {
        ScrollView {
            Text(historyString)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
        }
        .frame(maxHeight: 200)
        .padding()
    }
}

#Preview {
    ContentView()
}
