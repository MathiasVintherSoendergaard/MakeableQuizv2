//
//  TriviaQuestionService.swift
//  MakeableQuizv2
//
//  Created by Mathias Vinther Søndergaard on 14/11/2022.
//

import Foundation

struct TriviaQuestionService: Codable {
    
    let responseCode: Int
    let results: [TriviaQuestion]
    
    enum CodingKeys: String, CodingKey {
        case responseCode = "response_code"
        case results = "results"
    }
}

struct TriviaQuestion: Codable {
    let category: String
    let type: String
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]
    
    enum CodingKeys: String, CodingKey {
        case category = "category"
        case type = "type"
        case question = "question"
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
}
