//
//  OnBoardingSecondViewController.swift
//  AlcoholHabits
//
//  Created by Karen Khachatryan on 15.11.24.
//

import UIKit

class OnBoardingSecondViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.font = .regularZen(size: 22)
        nextButton.titleLabel?.font = .semiBold(size: 22)
    }

    @IBAction func clickedLetsGo(_ sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "passedOnBoard")
        let tabBarVC = TabBarViewController(nibName: "TabBarViewController", bundle: nil)
        self.navigationController?.viewControllers = [tabBarVC]
    }
}
