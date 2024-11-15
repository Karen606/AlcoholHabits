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
        let onboardingVC = OnBoardingViewController(nibName: "OnBoardingViewController", bundle: nil)
        self.navigationController?.pushViewController(onboardingVC, animated: false)        
    }
}
