//
//  SurveyViewController.swift
//  ResearchKitDemo
//
//  Created by Suman on 04/05/19.
//  Copyright © 2019 Suman. All rights reserved.
//

import UIKit
import ResearchKit
class SurveyViewController: UIViewController {
    lazy var presenter = SurveyPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func surveyClicked(_ sender: UIButton) {
        let taskViewController = ORKTaskViewController(task: presenter.getSurveyTask(), taskRun: nil)
        taskViewController.delegate = self
        present(taskViewController, animated: true, completion: nil)
    }
}

extension SurveyViewController: ORKTaskViewControllerDelegate {
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        switch reason {
        case .completed, .saved:
            presenter.postSurveyResult(taskViewController.result)
        default: break
        }
        taskViewController.dismiss(animated: true, completion: nil)
    }
}
