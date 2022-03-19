//
//  ViewController.swift
//  Vacation Finder Quiz
//
//  Created by Dimi on 15.02.22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func startButton(_ sender: UIButton) {
        userWelcomeInstroctionsDone = false
        FullReset()
        performSegue(withIdentifier: "start", sender: self)
    }
    
    
    @IBAction func unwindToMain(unwindSegue: UIStoryboardSegue) {
    }
    
}

