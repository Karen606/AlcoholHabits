//
//  ViewController.swift
//  AlcoholHabits
//
//  Created by Karen Khachatryan on 15.11.24.
//

import UIKit

extension UIViewController {
    
    func setNavigationBar(title: String) {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .black
        titleLabel.font = .mediumZen(size: 22)
        titleLabel.textAlignment = .center
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
    }
    
//    func setNaviagtionBackButton() {
//        let backButton = UIButton(type: .custom)
//        backButton.setTitleColor(.baseRed, for: .normal)
//        backButton.setTitle("Cancel", for: .normal)
//        backButton.addTarget(self, action: #selector(clickedBack), for: .touchUpInside)
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
//    }
    
//    func setNaviagtionMenuButton() {
//        let menuButton = UIButton(type: .custom)
//        menuButton.setImage(.menu, for: .normal)
//        menuButton.addTarget(self, action: #selector(clickedMenu), for: .touchUpInside)
//        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: menuButton)
//    }
    
    @objc func clickedBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleTap() {
        self.view.endEditing(true)
    }
    
//    @objc func clickedMenu() {
//        if let menuVC = navigationController?.viewControllers.first(where: { $0 is MenuViewController }) {
//            self.navigationController?.popToViewController(menuVC, animated: true)
//        }
//    }
    
    func pushViewController<T: UIViewController>(_ viewControllerType: T.Type, animated: Bool = true) {
        let nibName = String(describing: viewControllerType)
        let viewController = T(nibName: nibName, bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func showErrorAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        present(alertController, animated: true, completion: nil)
    }
    
    func setAsRoot() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }
        
        window.rootViewController = self
        window.makeKeyAndVisible()
    }
    
    func changeRootViewController(to viewController: UIViewController, animated: Bool = true) {
        guard let window = UIApplication.shared.connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .first?.windows.first else {
            return
        }
        
        if animated {
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
                window.rootViewController = viewController
            })
        } else {
            window.rootViewController = viewController
        }
        
        window.makeKeyAndVisible()
    }
}

