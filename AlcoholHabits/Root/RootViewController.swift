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
//        self.navigationItem.setHidesBackButton(true, animated: true)
//        self.navigationItem.hidesBackButton = true
//        self.navigationController?.navigationItem.setHidesBackButton(true, animated: true)
//        self.navigationController?.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.isHidden = true
        
        let onboardingVC = OnBoardingViewController(nibName: "OnBoardingViewController", bundle: nil)
        self.navigationController?.pushViewController(onboardingVC, animated: false)        
    }
}
