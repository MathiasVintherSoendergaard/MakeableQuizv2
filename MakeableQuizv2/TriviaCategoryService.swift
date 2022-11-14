//
//  TriviaCategoryService.swift
//  MakeableQuizv2
//
//  Created by Mathias Vinther Søndergaard on 14/11/2022.
//

import Foundation

struct TriviaCategoryService: Codable {
    let triviaCategories: [TriviaCategory]
    
    enum CodingKeys: String, CodingKey {
        case triviaCategories = "trivia_categories"
    }
}

struct TriviaCategory: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
}

struct Difficulty: Identifiable {
    let id: Int
    let value: String
}
