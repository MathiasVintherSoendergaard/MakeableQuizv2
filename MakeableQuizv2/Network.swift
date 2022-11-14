//
//  Network.swift
//  MakeableQuizv2
//
//  Created by Mathias Vinther Søndergaard on 14/11/2022.
//

import Foundation

class Network: ObservableObject {
    @Published var triviaCategories: [TriviaCategory] = []
    @Published var triviaQuestions: [TriviaQuestion] = [TriviaQuestion(category: "", type: "", question: "", correctAnswer: "", incorrectAnswers: ["", ""])]
    
    func getTriviaCategories() {
        guard let url = URL(string: "https://opentdb.com/api_category.php") else { fatalError("Missing URL") }
        
        let urlRequest = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("request error: ", error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decodedData = try JSONDecoder().decode(TriviaCategoryService.self, from: data)
                        self.triviaCategories = decodedData.triviaCategories
                        print(self.triviaCategories)
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    func getTriviaQuestions() {
        
        guard let url = URL(string: "https://opentdb.com/api.php?amount=10") else { fatalError("Missing URL")}
        
        let urlRequest = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decodedData = try JSONDecoder().decode(TriviaQuestionService.self, from: data)
                        self.triviaQuestions = decodedData.results
                        print(self.triviaQuestions)
                    } catch let error {
                        print("Error decoding", error)
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    func getTriviaQuestions(category: Int, difficulty: String) {
        guard let url = URL(string: "https://opentdb.com/api.php?amount=10&category=\(category)&difficulty=\(difficulty.lowercased())") else { fatalError("Missing URL")}
        
        let urlRequest = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print("Request error: ", error)
                return
            }
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decodedData = try JSONDecoder().decode(TriviaQuestionService.self, from: data)
                        self.triviaQuestions = decodedData.results
                        print(self.triviaQuestions)
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        dataTask.resume()
    }
}
