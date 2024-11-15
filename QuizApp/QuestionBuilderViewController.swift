//
//  QuestionBuilderViewController.swift
//  QuizApp
//
//  Created by Gurpreet Singh on 2024-11-08.
//

import Foundation
import UIKit

//protocol QuestionDelegate: AnyObject {
//    func didAddQuestion(_ question: Question)
//}

class QuestionBuilderViewController: UIViewController {
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var correctAnswerTextField: UITextField!
    @IBOutlet weak var firstIncorrectAnswerTextField: UITextField!
    @IBOutlet weak var secondIncorrectAnswerTextField: UITextField!
    @IBOutlet weak var thirdIncorrectAnswerTextField: UITextField!

    weak var delegate: QuestionDelegate?

    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        guard let questionText = questionTextField.text,
              let correctAnswer = correctAnswerTextField.text,
              let firstIncorrect = firstIncorrectAnswerTextField.text,
              let secondIncorrect = secondIncorrectAnswerTextField.text,
              let thirdIncorrect = thirdIncorrectAnswerTextField.text else { return }
        
        let question = Question(
            questionText: questionText,
            correctAnswer: correctAnswer,
            incorrectAnswers: [firstIncorrect, secondIncorrect, thirdIncorrect]
        )
        
        delegate?.didAddQuestion(question)
        navigationController?.popViewController(animated: true)
    }

    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
}
