//
//  QuestionDelegate.swift
//  QuizApp
//
//  Created by Gurpreet Singh on 2024-11-14.
//

import Foundation
protocol QuestionDelegate: AnyObject {
    func didAddQuestion(_ question: Question)
    func didUpdateQuestion(_ question: Question, at index: Int)
}
