//
//  QuestionBankViewController.swift
//  QuizApp
//
//  Created by Gurpreet Singh on 2024-11-08.
//

import Foundation
import UIKit

class QuestionBankViewController: UITableViewController, QuestionDelegate {
    var questions: [Question] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register a basic UITableViewCell if you’re not using prototype cells in storyboard
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "QuestionCell")
    }
    
    @IBAction func addQuestionTapped(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let questionBuilderVC = storyboard.instantiateViewController(withIdentifier: "QuestionBuilderViewController") as? QuestionBuilderViewController {
            questionBuilderVC.delegate = self
            navigationController?.pushViewController(questionBuilderVC, animated: true)
        }
    }

    // MARK: - TableView Data Source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath)
        cell.textLabel?.text = questions[indexPath.row].questionText
        return cell
    }

    // MARK: - TableView Delegate for Selecting a Question

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let questionEditVC = storyboard.instantiateViewController(withIdentifier: "QuestionEditViewController") as? QuestionEditViewController {
            questionEditVC.delegate = self
            questionEditVC.question = questions[indexPath.row]
            questionEditVC.questionIndex = indexPath.row
            navigationController?.pushViewController(questionEditVC, animated: true)
        }
    }
    
    // MARK: - QuestionDelegate Methods
    
    func didAddQuestion(_ question: Question) {
        questions.append(question)
        tableView.reloadData()
    }

    func didUpdateQuestion(_ question: Question, at index: Int) {
        questions[index] = question
        tableView.reloadData()
    }
}
