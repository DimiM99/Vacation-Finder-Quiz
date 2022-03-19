//
//  QuestionViewViewController.swift
//  Vacation Finder Quiz
//
//  Created by Dimi on 26.02.22.
//

import UIKit

class QuestionViewViewController: UIViewController {
    
    @IBOutlet weak var RangedStack: UIStackView!
    @IBOutlet weak var QuestionAnswersTable: UITableView!
    @IBOutlet weak var RangedSlider: UISlider!
    @IBOutlet weak var RangeOption: UILabel!
    @IBOutlet weak var QuestionLabel: UILabel!
    var rangeOptions = 0
    var multipleOptionsSelected = 0
    var singleChoiceDone = false
    var rangeSelecetionDone = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        QuestionLabel.text = Questions[currentQuestion].text
        
        if Questions[currentQuestion].type == .single || Questions[currentQuestion].type == .multiple {
            QuestionAnswersTable.isHidden = false
            QuestionAnswersTable.delegate = self
            QuestionAnswersTable.dataSource = self
            self.QuestionAnswersTable.reloadData()
        } else if Questions[currentQuestion].type == .ranged {
            RangedStack.isHidden = false
            rangeOptions = Questions[currentQuestion].answers.count
            RangedSlider.minimumValue = 0
            RangedSlider.maximumValue = Float(rangeOptions - 1)
            RangeOption.text = Questions[currentQuestion].answers[0].text
            if Questions[currentQuestion].status == true {
                RangedSlider.setValue(Float(savedRangeForQuestion[currentQuestion]!), animated: true)
            }
        }
    }
    
    
    @IBAction func ranfedSliderDragged(_ sender: UISlider) {
        RangedSlider.value = roundf(RangedSlider.value)
        let answernumber = Int(RangedSlider.value)
        RangeOption.text = Questions[currentQuestion].answers[answernumber].text
        Questions[currentQuestion].status = true
        Questions[currentQuestion].answers[answernumber].selected = true
        savedRangeForQuestion[currentQuestion] = answernumber
        if rangeSelecetionDone == false {
            updateAnswers(at: Questions[currentQuestion].answers[answernumber].type, type: .increase)
            rangeSelecetionDone = true
        }
        if rangeSelecetionDone == true {
            updateAnswers(at: Questions[currentQuestion].answers[savedRangeForQuestion[currentQuestion]!].type, type: .decrease)
            updateAnswers(at: Questions[currentQuestion].answers[answernumber].type, type: .increase)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        updateQuizStatus()
    }
    
    func updateQuizStatus() {
        if Questions[currentQuestion].status == true &&  Questions[currentQuestion].viewed == false {
            questionsAnswered += 1
            Questions[currentQuestion].viewed = true
        } else if Questions[currentQuestion].viewed == true && Questions[currentQuestion].status == false {
            questionsAnswered -= 1
            Questions[currentQuestion].viewed = false
            
        }
    }
    
    enum updateType {case decrease, increase}
    func updateAnswers(at: Country, type: updateType) {
        switch type {
        case .decrease:
            CountriesScores[at]! -= 1
        case .increase:
            CountriesScores[at]! += 1
        }
    }
    

}

extension QuestionViewViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        tableView.deselectRow(at: indexPath, animated: true)
        
        if Questions[currentQuestion].type == .single {
            switch Questions[currentQuestion].answers[indexPath.row].selected {
            case true:
                cell.accessoryType = .none
                updateAnswers(at: Questions[currentQuestion].answers[indexPath.row].type, type: .decrease)
                Questions[currentQuestion].answers[indexPath.row].selected = false
                singleChoiceDone = false
                Questions[currentQuestion].status = false
            case false:
                if singleChoiceDone == false {
                    cell.accessoryType = .checkmark
                    updateAnswers(at: Questions[currentQuestion].answers[indexPath.row].type, type: .increase)
                    Questions[currentQuestion].answers[indexPath.row].selected = true
                    singleChoiceDone = true
                    Questions[currentQuestion].status = true
                }
            }
        }
    }
        
}

extension QuestionViewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Questions[currentQuestion].answers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "option", for: indexPath)
        cell.textLabel?.text = Questions[currentQuestion].answers[indexPath.row].text
        if Questions[currentQuestion].type == .multiple{
            let switchView = UISwitch(frame: .zero)
            switchView.setOn(Questions[currentQuestion].answers[indexPath.row].selected, animated: true)
            switchView.tag = indexPath.row
            switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
            cell.accessoryView = switchView
            if Questions[currentQuestion].answers[indexPath.row].selected == true {
                multipleOptionsSelected += 1
            }
        }
        
        if Questions[currentQuestion].type == .single {
            if Questions[currentQuestion].answers[indexPath.row].selected == true {
                cell.accessoryType = .checkmark
                singleChoiceDone = true
            }
        }
        
        return cell
    }
    
    @objc func switchChanged(_ sender: UISwitch!) {
        if sender.isOn == false {
            updateAnswers(at: Questions[currentQuestion].answers[sender.tag].type, type: .decrease)
            Questions[currentQuestion].answers[sender.tag].selected = false
            multipleOptionsSelected -= 1
            if multipleOptionsSelected == 0 {
                Questions[currentQuestion].status = false
            }
        } else if sender.isOn == true {
            updateAnswers(at: Questions[currentQuestion].answers[sender.tag].type, type: .increase)
            Questions[currentQuestion].answers[sender.tag].selected = true
            Questions[currentQuestion].status = true
            multipleOptionsSelected += 1
        }
    }
    
}
