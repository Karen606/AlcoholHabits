//
//  DrinkFormViewController.swift
//  AlcoholHabits
//
//  Created by Karen Khachatryan on 16.11.24.
//

import UIKit
import Combine

class DrinkFormViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var typeButtons: [SectionButton]!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet var dataViews: [UIView]!
    @IBOutlet var sectionLabels: [UILabel]!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var saveButton: BaseButton!
    @IBOutlet weak var volumeTextField: BasePriceTextField!
    @IBOutlet weak var strengthTextField: BasePriceTextField!
    @IBOutlet weak var priceTextField: BasePriceTextField!
    private let viewModel = DrinkFormViewModel.shared
    private var cancellables: Set<AnyCancellable> = []

    private var selectedType: SectionButton? {
        didSet {
            contentView.isHidden = selectedType == nil
            guard let selectedType = selectedType else { return }
            selectedType.isSelected = true
            if let oldValue = oldValue {
                oldValue.isSelected = false
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        subscribe()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.topItem?.title = "Calendar"
    }
    
    func setupUI() {
        contentView.addShadow()
        sectionLabels.forEach({ $0.font = .regularZen(size: 20) })
        titleLabel.font = .mediumZen(size: 22)
        typeButtons.forEach({ $0.titleLabel?.font = .regularZen(size: 20) })
        dataViews.forEach({ $0.addBottomBorder(color: #colorLiteral(red: 0.895850122, green: 0.895850122, blue: 0.895850122, alpha: 1), thickness: 1) })
        saveButton.isEnabled = false
        volumeTextField.baseDelegate = self
        strengthTextField.baseDelegate = self
        priceTextField.baseDelegate = self
    }
    
    func subscribe() {
        viewModel.$drinkModel
            .receive(on: DispatchQueue.main)
            .sink { [weak self] drink in
                guard let self = self else { return }
                self.saveButton.isEnabled = (drink.price != nil && drink.strength != nil && drink.type != nil && drink.volume != nil && drink.date != nil)
            }
            .store(in: &cancellables)
    }

    @IBAction func handleTapGesture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func clickedPlusQuantity(_ sender: UIButton) {
        viewModel.drinkModel.quantity += 1
        quantityLabel.text = "X\(viewModel.drinkModel.quantity)"
    }
    
    @IBAction func clickedMinusQuantity(_ sender: UIButton) {
        if viewModel.drinkModel.quantity > 1 {
            viewModel.drinkModel.quantity -= 1
            quantityLabel.text = "X\(viewModel.drinkModel.quantity)"
        }
    }
    
    @IBAction func chooseType(_ sender: SectionButton) {
        if selectedType == sender { return }
        selectedType = sender
        viewModel.drinkModel.type = sender.tag
    }
    
    @IBAction func clickedSave(_ sender: BaseButton) {
        viewModel.save { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                self.showErrorAlert(message: error.localizedDescription)
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    deinit {
        viewModel.clear()
    }
}

extension DrinkFormViewController: PriceTextFielddDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        switch textField {
        case volumeTextField:
            if let value = textField.text {
                viewModel.drinkModel.volume = Double(value)
            } else {
                viewModel.drinkModel.volume = nil
            }
        case strengthTextField:
            if let value = textField.text {
                viewModel.drinkModel.strength = Double(value)
            } else {
                viewModel.drinkModel.strength = nil
            }
        case priceTextField:
            if let value = textField.text {
                viewModel.drinkModel.price = Double(value)
            } else {
                viewModel.drinkModel.price = nil
            }
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let value = textField.text, !value.isEmpty else { return }
        switch textField {
        case volumeTextField:
            if !value.hasSuffix("ml") {
                volumeTextField.text = value + "ml"
            }
        case strengthTextField:
            if !value.hasSuffix("%") {
                strengthTextField.text = value + "%"
            }
        case priceTextField:
            if !value.hasSuffix("$") {
                priceTextField.text = value + "$"
            }
        default:
            break
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case volumeTextField:
            if let value = textField.text, value.hasSuffix("ml") {
                volumeTextField.text = String(value.dropLast(2))
            }
        case strengthTextField:
            if let value = textField.text, value.hasSuffix("%") {
                strengthTextField.text = String(value.dropLast(1))
            }
        case priceTextField:
            if let value = textField.text, value.hasSuffix("$") {
                priceTextField.text = String(value.dropLast(1))
            }
        default:
            break
        }
    }
}
