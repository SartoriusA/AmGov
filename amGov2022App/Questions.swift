//
//  Questions.swift
//  amGov2022App
//
//  Created by Andrew J. Sartorius on 7/7/22.
//

import Foundation


class QuestionClass {
    
    lazy let questions: [Question]
    
    init (){
        questions = getQuestion()
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
    
}

struct Question: Codable{
    var question: String
    var answers: [String]
    var correct: Int
}
