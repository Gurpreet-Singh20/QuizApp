//
//  QuizViewController.swift
//  QuizApp
//
//  Created by Gurpreet Singh on 2024-11-14.
//

import Foundation
import UIKit

class QuizViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var optionsTableView: UITableView!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    
    var questions: [Question] = []
    var currentQuestionIndex = 0
    var selectedAnswerIndex: Int? = nil
    var score = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        optionsTableView.delegate = self
        optionsTableView.dataSource = self
        loadQuestion()
        updateButtons()
    }

    func loadQuestion() {
        guard !questions.isEmpty else {
                print("No questions available")
                showResult()
                return
            }
            
            let question = questions[currentQuestionIndex]
            questionLabel.text = question.questionText
            resultLabel.isHidden = true

            selectedAnswerIndex = nil
            optionsTableView.reloadData()
            
            let progress = Float(currentQuestionIndex + 1) / Float(questions.count)
            progressBar.setProgress(progress, animated: true)
    }

    // MARK: - TableView Data Source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4  // Four options: one correct and three incorrect
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell", for: indexPath)
        let question = questions[currentQuestionIndex]
        
        // Combine correct answer and incorrect answers into a fixed array of four elements
        let allAnswers = ([question.correctAnswer] + question.incorrectAnswers).shuffled()
        
        // Make sure indexPath.row is within bounds
        if indexPath.row < allAnswers.count {
            cell.textLabel?.text = allAnswers[indexPath.row]
        }
        
        // Display checkmark for the selected answer
        cell.accessoryType = (indexPath.row == selectedAnswerIndex) ? .checkmark : .none
        
        return cell
    }

    // MARK: - TableView Delegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedAnswerIndex = indexPath.row
        tableView.reloadData()  // Refresh checkmark display
    }

    // MARK: - Navigation Methods
    
    @IBAction func nextQuestion(_ sender: UIButton) {
        checkAnswer()
            if currentQuestionIndex < questions.count - 1 {
                currentQuestionIndex += 1
                loadQuestion()
                updateButtons()
            } else {
                showResult()
            }
    }

    @IBAction func previousQuestion(_ sender: UIButton) {
        if currentQuestionIndex > 0 {
                currentQuestionIndex -= 1
                loadQuestion()
                updateButtons()
            }
    }

    func updateButtons() {
        // Enable/disable navigation buttons
        previousButton.isEnabled = currentQuestionIndex > 0
        nextButton.setTitle(currentQuestionIndex == questions.count - 1 ? "Finish" : "Next", for: .normal)
    }

    func checkAnswer() {
        let question = questions[currentQuestionIndex]
        if let selectedAnswerIndex = selectedAnswerIndex {
            let allAnswers = [question.correctAnswer] + question.incorrectAnswers
            if allAnswers[selectedAnswerIndex] == question.correctAnswer {
                score += 1
            }
        }
    }

    func showResult() {
        resultLabel.isHidden = false
        resultLabel.text = "Your Score: \(score) / \(questions.count)"
        questionLabel.isHidden = true
        optionsTableView.isHidden = true
        nextButton.isHidden = true
        previousButton.isHidden = true
        progressBar.isHidden = true
    }
}
