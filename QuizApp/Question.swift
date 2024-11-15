//
//  Question.swift
//  QuizApp
//
//  Created by Gurpreet Singh on 2024-11-08.
//

import Foundation

struct Question {
    let questionText: String
    let correctAnswer: String
    let incorrectAnswers: [String]
    
    
    
    var allAnswers: [String] {
        return [correctAnswer] + incorrectAnswers.shuffled()
    }
}
