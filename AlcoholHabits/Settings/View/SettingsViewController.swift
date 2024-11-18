//
//  SettingsViewController.swift
//  AlcoholHabits
//
//  Created by Karen Khachatryan on 15.11.24.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet var settingsButtons: [UIButton]!
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsButtons.forEach({ $0.titleLabel?.font = .semiBold(size: 18) })
    }


    @IBAction func clickedContactUs(_ sender: UIButton) {
    }
    @IBAction func clickedPrivacyPolicy(_ sender: UIButton) {
    }
    @IBAction func clickedRateUs(_ sender: UIButton) {
    }

}
