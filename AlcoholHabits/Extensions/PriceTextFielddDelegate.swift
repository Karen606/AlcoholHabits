//
//  PriceTextFielddDelegate.swift
//  AlcoholHabits
//
//  Created by Karen Khachatryan on 17.11.24.
//

import UIKit

protocol PriceTextFielddDelegate: AnyObject {
    func textFieldDidChangeSelection(_ textField: UITextField)
    func textFieldDidBeginEditing(_ textField: UITextField)
    func textFieldDidEndEditing(_ textField: UITextField)
}

class PricesTextField: BaseTextField, UITextFieldDelegate {
    weak var baseDelegate: PriceTextFielddDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        priceCommonnit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        priceCommonnit()
    }
    
    private func priceCommonnit() {
        self.delegate = self
        self.keyboardType = .decimalPad
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        
        let allowedCharacters = CharacterSet(charactersIn: "0123456789.,")
        let characterSet = CharacterSet(charactersIn: string)
        
        if !allowedCharacters.isSuperset(of: characterSet) {
            return false
        }

        if (text.contains(".") || text.contains(",")) && (string == "." || string == ",") {
            return false
        }
        
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        
        textField.text = formatPrice(input: newString)
        return false
    }

    private func formatPrice(input: String) -> String {
        let cleanedInput = input.replacingOccurrences(of: "[^0-9.,]", with: "", options: .regularExpression)
        let normalizedInput = cleanedInput.replacingOccurrences(of: ",", with: ".")
        
        if normalizedInput.last == "." {
            return normalizedInput
        }
        
        let parts = normalizedInput.components(separatedBy: ".")
        var integerPart = parts.first ?? ""
        let decimalPart = parts.count > 1 ? parts.last! : ""
        
        if integerPart.count > 9 {
            integerPart = String(integerPart.prefix(9))
        }
        
        if let number = Double(integerPart) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 0
            integerPart = formatter.string(from: NSNumber(value: number)) ?? integerPart
        }
        
        let formattedPrice = decimalPart.isEmpty ? integerPart : "\(integerPart).\(decimalPart.prefix(2))"
        
        return formattedPrice
    }

    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        baseDelegate?.textFieldDidChangeSelection(textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        baseDelegate?.textFieldDidEndEditing(textField)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        baseDelegate?.textFieldDidBeginEditing(textField)
    }
    
    func isValidPrice() -> Bool {
        guard let text = self.text else { return false }
        
        var cleanedText = text.replacingOccurrences(of: "$", with: "")
        cleanedText = cleanedText.replacingOccurrences(of: ".", with: ",")
        cleanedText = cleanedText.replacingOccurrences(of: " ", with: "")

        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 0
        
        if let _ = numberFormatter.number(from: cleanedText) {
            let components = cleanedText.components(separatedBy: ".")
            if components.count == 2 && components[1].count > 2 {
                return false
            }
            return true
        }
        return false
    }
    
    func formatNumber() -> Double? {
        guard let text = self.text else { return nil }
        
        var cleanedText = text.replacingOccurrences(of: "$", with: "")
        cleanedText = cleanedText.replacingOccurrences(of: ".", with: ",")
        cleanedText = cleanedText.replacingOccurrences(of: " ", with: "")

        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 0
        
        if let price = numberFormatter.number(from: cleanedText) {
            let components = cleanedText.components(separatedBy: ".")
            if components.count == 2 && components[1].count > 2 {
                return nil
            }
            return Double(truncating: price)
        }
        return nil
    }
}

class BasePriceTextField: UITextField, UITextFieldDelegate {
    weak var baseDelegate: PriceTextFielddDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        priceCommonnit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        priceCommonnit()
    }
    
    private func priceCommonnit() {
        self.delegate = self
        self.keyboardType = .decimalPad
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        
        let allowedCharacters = CharacterSet(charactersIn: "0123456789.,")
        let characterSet = CharacterSet(charactersIn: string)
        
        if !allowedCharacters.isSuperset(of: characterSet) {
            return false
        }

        if (text.contains(".") || text.contains(",")) && (string == "." || string == ",") {
            return false
        }
        
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        
        textField.text = formatPrice(input: newString)
        return false
    }

    private func formatPrice(input: String) -> String {
        let cleanedInput = input.replacingOccurrences(of: "[^0-9.,]", with: "", options: .regularExpression)
        let normalizedInput = cleanedInput.replacingOccurrences(of: ",", with: ".")
        
        if normalizedInput.last == "." {
            return normalizedInput
        }
        
        let parts = normalizedInput.components(separatedBy: ".")
        var integerPart = parts.first ?? ""
        let decimalPart = parts.count > 1 ? parts.last! : ""
        
        if integerPart.count > 9 {
            integerPart = String(integerPart.prefix(9))
        }
        
        if let number = Double(integerPart) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 0
            integerPart = formatter.string(from: NSNumber(value: number)) ?? integerPart
        }
        
        let formattedPrice = decimalPart.isEmpty ? integerPart : "\(integerPart).\(decimalPart.prefix(2))"
        
        return formattedPrice
    }

    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        baseDelegate?.textFieldDidChangeSelection(textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        baseDelegate?.textFieldDidEndEditing(textField)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        baseDelegate?.textFieldDidBeginEditing(textField)
    }
    
    func isValidPrice() -> Bool {
        guard let text = self.text else { return false }
        
        var cleanedText = text.replacingOccurrences(of: "$", with: "")
        cleanedText = cleanedText.replacingOccurrences(of: ".", with: ",")
        cleanedText = cleanedText.replacingOccurrences(of: " ", with: "")

        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 0
        
        if let _ = numberFormatter.number(from: cleanedText) {
            let components = cleanedText.components(separatedBy: ".")
            if components.count == 2 && components[1].count > 2 {
                return false
            }
            return true
        }
        return false
    }
    
    func formatNumber() -> Double? {
        guard let text = self.text else { return nil }
        
        var cleanedText = text.replacingOccurrences(of: "$", with: "")
        cleanedText = cleanedText.replacingOccurrences(of: ".", with: ",")
        cleanedText = cleanedText.replacingOccurrences(of: " ", with: "")

        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 0
        
        if let price = numberFormatter.number(from: cleanedText) {
            let components = cleanedText.components(separatedBy: ".")
            if components.count == 2 && components[1].count > 2 {
                return nil
            }
            return Double(truncating: price)
        }
        return nil
    }
}
