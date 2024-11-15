//
//  BaseTextField.swift
//  AlcoholHabits
//
//  Created by Karen Khachatryan on 15.11.24.
//


import UIKit

class BaseTextField: UITextField {
    private var padding = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 14)
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func checkValidation() -> Bool {
        if let text = text?.trimmingCharacters(in: .whitespaces), text.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    func commonInit() {
//        self.backgroundColor = .baseWhite
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 1
//        self.layer.borderColor = UIColor.baseText.cgColor
//        self.textColor = .baseText
    }
}

extension BaseTextField {
    func setupRightViewIcon(_ image: UIImage, size: CGSize) {
        let icon = UIImageView(frame:CGRect(x: 0, y: 0, width: size.width, height: size.height))
        icon.image = image
        icon.contentMode = .center
        let iconContainerView: UIView = UIView(frame:CGRect(x: 0, y: 0, width: size.width, height: size.height))
        iconContainerView.isUserInteractionEnabled = false
        iconContainerView.addSubview(icon)
        rightView = iconContainerView
        rightViewMode = .always
        self.padding.right = size.width
    }
}

extension UITextField {
    func setupLeftViewIcon(_ image: UIImage, size: CGSize) {
        let icon = UIImageView(frame:CGRect(x: 0, y: 0, width: size.width, height: size.height))
        icon.image = image
        icon.contentMode = .center
        let iconContainerView: UIView = UIView(frame:CGRect(x: 0, y: 0, width: size.width, height: size.height))
        iconContainerView.isUserInteractionEnabled = false
        iconContainerView.addSubview(icon)
        leftView = iconContainerView
        leftViewMode = .always
    }
}
