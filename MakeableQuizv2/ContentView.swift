//
//  ContentView.swift
//  MakeableQuizv2
//
//  Created by Mathias Vinther Søndergaard on 14/11/2022.
//

import SwiftUI

struct ContentView: View {
    
    
    @EnvironmentObject var network: Network
    @State var selectedCategoryId: Int = 0
    @State var questionIndex: Int = 0
    @State var buttonTextDone: String = "Done"
    @State var selectedDifficulty: String = ""
    @State var showQuestion: Bool = false
    @State var hidePickers: Bool = true
    @State var currentQuestion: TriviaQuestion = TriviaQuestion(category: "", type: "", question: "Loading...", correctAnswer: "", incorrectAnswers: ["", ""])
    var difficulties: [Difficulty] = [Difficulty(id: 1, value: "Easy"), Difficulty(id: 2, value: "Medium"), Difficulty(id: 3, value: "Hard")]
    
    var body: some View {

        VStack {
            Text("Current category = \(self.selectedCategoryId)")
            Text("Current difficulty = \(self.selectedDifficulty)")
            
            Button("Choose difficulty and category") {
                self.currentQuestion = network.triviaQuestions[self.questionIndex]
                hidePickers.toggle()
            }.buttonStyle(GrowingButton())
            Spacer()
            if(showQuestion) {
                Text("\(self.currentQuestion.question)")
                Spacer()
                AnswerButtons(question: $currentQuestion)
                Spacer()
                Button("Next question") {
                    if(self.questionIndex < 9) {
                        self.questionIndex += 1
                    } else {
                        self.questionIndex = 0
                    }
                    self.currentQuestion = network.triviaQuestions[self.questionIndex]
                }.buttonStyle(GrowingButton())
            }
            Spacer()
            if(!hidePickers) {
                VStack(spacing: 0) {
                    Spacer()
                    Button(self.buttonTextDone) {
                        self.network.getTriviaQuestions(category: selectedCategoryId, difficulty: selectedDifficulty)
                        self.showQuestions()
                    }
                    .buttonStyle(GrowingButton())
                    Picker("Difficulty Picker", selection: $selectedDifficulty) {
                        ForEach(difficulties) { difficulty in
                            Text("\(difficulty.value)")
                                .tag("\(difficulty.value)")
                        }
                    }
                    .pickerStyle(.wheel)
                    Picker("Category Picker", selection: $selectedCategoryId) {
                        ForEach(network.triviaCategories) { category in
                            Text("\(category.name)")
                                .tag("\(category.id)")
                        }
                    }
                    .pickerStyle(.wheel)
                }
            }
        }
        .onAppear {
            network.getTriviaCategories()
        }
    }
    func showQuestions() {
        self.hidePickers.toggle()
        self.showQuestion.toggle()
        self.currentQuestion = network.triviaQuestions[0]
    }
}
