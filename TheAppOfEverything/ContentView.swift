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

    private func clearHistory() {
        history = []
        historyString = ""
    }

    private func reset() {
        choice1 = ""
        choice2 = ""
        result = ""
        history = []
        historyString = ""
    }

    private func randomize() {
        let choices = [choice1, choice2].filter { !$0.isEmpty }
        if let randomChoice = choices.randomElement() {
            result = randomChoice
            history.append(randomChoice)
            historyString = history
                .enumerated() // Enumerate the history first to preserve the order
                .reversed()
                .map { "\($0.offset + 1). \($0.element)" }
                .joined(separator: "\n")
        } else {
            result = "Please enter at least one choice."
        }
    }

    private var inputFields: some View {
        VStack {
            HStack {
                TextField("Choice #1", text: $choice1)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                TextField("Choice #2", text: $choice2)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }
            Text(historicalOddsText)
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.top, 4)
        }
    }

    private var historicalOddsText: String {
        let total = history.count

        guard total > 0 else { return "Historical Odds: N/A" }

        let choice1Count = history.filter { $0 == choice1 }.count
        let choice2Count = history.filter { $0 == choice2 }.count

        let choice1Odds = (Double(choice1Count) / Double(total) * 100).rounded()
        let choice2Odds = (Double(choice2Count) / Double(total) * 100).rounded()

        return "Historical Odds: \(choice1): \(choice1Odds)% | \(choice2): \(choice2Odds)%"
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

            HStack {
                Button(action: reset) {
                    Text("Reset")
                        .font(.subheadline)
                        .padding(8)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }

                Button(action: clearHistory) {
                    Text("Clear History")
                        .font(.subheadline)
                        .padding(8)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
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
