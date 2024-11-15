//
//  QuestionEditViewController.swift
//  QuizApp
//
//  Created by Gurpreet Singh on 2024-11-14.
//

import Foundation
import UIKit

class QuestionEditViewController: UIViewController {
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var correctAnswerTextField: UITextField!
    @IBOutlet weak var firstIncorrectAnswerTextField: UITextField!
    @IBOutlet weak var secondIncorrectAnswerTextField: UITextField!
    @IBOutlet weak var thirdIncorrectAnswerTextField: UITextField!
    
    weak var delegate: QuestionDelegate?
    var question: Question?
    var questionIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let question = question {
            questionTextField.text = question.questionText
            correctAnswerTextField.text = question.correctAnswer
            firstIncorrectAnswerTextField.text = question.incorrectAnswers[0]
            secondIncorrectAnswerTextField.text = question.incorrectAnswers[1]
            thirdIncorrectAnswerTextField.text = question.incorrectAnswers[2]
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let questionText = questionTextField.text,
              let correctAnswer = correctAnswerTextField.text,
              let firstIncorrect = firstIncorrectAnswerTextField.text,
              let secondIncorrect = secondIncorrectAnswerTextField.text,
              let thirdIncorrect = thirdIncorrectAnswerTextField.text,
              let index = questionIndex else { return }
        
        let updatedQuestion = Question(
            questionText: questionText,
            correctAnswer: correctAnswer,
            incorrectAnswers: [firstIncorrect, secondIncorrect, thirdIncorrect]
        )
        
        delegate?.didUpdateQuestion(updatedQuestion, at: index)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
}
