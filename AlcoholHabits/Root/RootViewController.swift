//
//  RootViewController.swift
//  AlcoholHabits
//
//  Created by Karen Khachatryan on 15.11.24.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        if UserDefaults.standard.bool(forKey: "passedOnBoard") {
            let tabBarVC = TabBarViewController(nibName: "TabBarViewController", bundle: nil)
            self.navigationController?.viewControllers = [tabBarVC]
        } else {
            let onboardingVC = OnBoardingViewController(nibName: "OnBoardingViewController", bundle: nil)
            self.navigationController?.pushViewController(onboardingVC, animated: false)
        }
    }
}
