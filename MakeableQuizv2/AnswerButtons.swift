//
//  AnswerButtons.swift
//  MakeableQuizv2
//
//  Created by Mathias Vinther Søndergaard on 14/11/2022.
//

import SwiftUI

struct AnswerButtons: View {
    
    @Binding var question: TriviaQuestion
    
    var body: some View {
        HStack {
            VStack {
                ForEach(question.incorrectAnswers, id: \.self) { answer in
                    Button("\(answer)") {
                        
                    }.buttonStyle(GrowingButton())
                }
                Button(question.correctAnswer) {
                    
                }.buttonStyle(GrowingButton())
            }
        }
    }
}

struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
