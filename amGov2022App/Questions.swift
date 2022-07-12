//
//  Questions.swift
//  amGov2022App
//
//  Created by Andrew J. Sartorius on 7/7/22.
//

import Foundation


class QuestionClass: ObservableObject {
    
    var questions : [Question] {
        getQuestion()
    }
    @Published var score : Int = 0
    @Published var numberOfQuestions: Int = 0
    @Published var time: Int = 0
    @Published var correct: Int = 0
    @Published var gameOver: Bool = false
    var accuracy: Int {
        guard numberOfQuestions != 0 else {return 0}
        return Int((Double(score) / Double(numberOfQuestions)) * 100)
    }
    
    init (){
        
    }
    
    func getQuestion() -> [Question] {
        let decoder = JSONDecoder()
        let out: [Question]
        let url = Bundle.main.url(forResource: "questions", withExtension: "json")!
        do{
            out = try decoder.decode([Question].self, from: Data(contentsOf: url))
        }
        catch let DecodingError {
            print(DecodingError)
            fatalError()
        }
        return out
    }
    
    func questionAnsered(question: Question, answer: Int) -> Bool {
        if question.correct == answer{
            score += 1
            numberOfQuestions += 1
            return true
        }
        else {
            numberOfQuestions += 1
            return false
        }
    }
    
}

struct Question: Codable{
    var question: String
    var answers: [String]
    var correct: Int
}
