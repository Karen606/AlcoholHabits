//
//  TabBarViewController.swift
//  AlcoholHabits
//
//  Created by Karen Khachatryan on 15.11.24.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let calendarVC = CalendarViewController(nibName: "CalendarViewController", bundle: nil)
        let calendarItem = createCustomTabBarItem(icon: .calendar, title: "Calendar")
        calendarVC.tabBarItem = calendarItem
        calendarVC.tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
        let statisticsVC = StatisticsViewController(nibName: "StatisticsViewController", bundle: nil)
        statisticsVC.tabBarItem = createCustomTabBarItem(icon: .statistics, title: "Statistics")
        statisticsVC.tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
        let settingsVC = SettingsViewController(nibName: "SettingsViewController", bundle: nil)
        settingsVC.tabBarItem = createCustomTabBarItem(icon: .settings, title: "Settings")
        settingsVC.tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)

        self.viewControllers = [calendarVC, statisticsVC, settingsVC]
        let topShadow = EdgeShadowLayer(forView: view, edge: .Top)
        self.tabBar.layer.addSublayer(topShadow)
        
    }
    
    
    private func createCustomTabBarItem(icon: UIImage, title: String) -> UITabBarItem {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 5
        
        let imageView = UIImageView(image: icon)
        imageView.contentMode = .scaleAspectFit
        stackView.addArrangedSubview(imageView)
        
        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        stackView.addArrangedSubview(label)
        
        let size = CGSize(width: 100, height: 40)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        stackView.frame = CGRect(origin: .zero, size: size)
        stackView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let renderedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let item = UITabBarItem(title: nil, image: renderedImage, selectedImage: renderedImage)
        return item
    }
}

