//
//  QuizVuewViewController.swift
//  Vacation Finder Quiz
//
//  Created by Dimi on 26.02.22.
//

import UIKit

class QuizVuewViewController: UIViewController {

    @IBOutlet weak var QuestionsTable: UITableView!
    
    var ResultIsAvailable = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        QuestionsTable.delegate = self
        QuestionsTable.dataSource = self
        self.QuestionsTable.reloadData()
        welcomenotes()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.QuestionsTable.reloadData()
        checkQuizStatus()
    }

    @IBAction func showResults(_ sender: UIBarButtonItem) {
        if ResultIsAvailable == true {
            performSegue(withIdentifier: "show result", sender: self)
        } else {
            let allert = UIAlertController(title: "You are not done Yet", message: "Result will be available once you answer all questions", preferredStyle: .alert)
            allert.addAction(UIAlertAction(title: "Okay", style: .default))
            self.present(allert, animated: true, completion: nil)
        }
    }
    
    func welcomenotes() {
        if userWelcomeInstroctionsDone == false {
            let allert = UIAlertController(title: "How To?", message: "Answer all questions in this list in order you like, you can change your answers while you are filling in. After You are done press \"Show Result\" on the upper right corner to find out the resut", preferredStyle: .alert)
            allert.addAction(UIAlertAction(title: "Okay", style: .default))
            self.present(allert, animated: true, completion: nil)
            userWelcomeInstroctionsDone = true
        }
    }

    func checkQuizStatus() {
        if questionsAnswered == Questions.count {
            ResultIsAvailable = true
        }
    }
    
}

extension QuizVuewViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        currentQuestion = indexPath.row
        performSegue(withIdentifier: "GoQuestion", sender: self)
    }
}
extension QuizVuewViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Questions.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "question", for: indexPath)
        cell.textLabel?.text = Questions[indexPath.row].text
        if Questions[indexPath.row].status == true {
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
        } else {
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        }
        return cell
    }
}

