//
//  StatisticsViewController.swift
//  AlcoholHabits
//
//  Created by Karen Khachatryan on 15.11.24.
//

import UIKit
import Combine

class StatisticsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var periodButtons: [SectionButton]!
    @IBOutlet var titleLabels: [UILabel]!
    @IBOutlet weak var drankDaysLabel: UILabel!
    @IBOutlet weak var maxDrankDaysLabel: UILabel!
    @IBOutlet weak var expensesLabel: UILabel!
    private let viewModel = StatisticsViewModel.shared
    private var cancellables: Set<AnyCancellable> = []
    private var selectedPeriod: SectionButton? {
        didSet {
            guard let selectedType = selectedPeriod else { return }
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
        viewModel.fetchData()
    }
    
    func setupUI() {
        titleLabel.font = .mediumZen(size: 22)
        drankDaysLabel.font = .mediumZen(size: 30)
        maxDrankDaysLabel.font = .mediumZen(size: 30)
        expensesLabel.font = .mediumZen(size: 30)
        titleLabels.forEach({ $0.font = .light(size: 14) })
        selectedPeriod = periodButtons.first
    }
    
    func subscribe() {
        viewModel.$drinks
            .receive(on: DispatchQueue.main)
            .sink { [weak self] drinks in
                guard let self = self else { return }
                self.drankDaysLabel.text = "\(self.viewModel.numberOfDrinkingDays())"
                self.maxDrankDaysLabel.text = "\(self.viewModel.maxConsecutiveDays())"
                self.expensesLabel.text = "\(self.viewModel.calculateTotalPrice().formattedToString())$"
            }
            .store(in: &cancellables)
    }

    @IBAction func choosePeriod(_ sender: SectionButton) {
        if selectedPeriod == sender { return }
        selectedPeriod = sender
        viewModel.filter(by: sender.tag)
    }
}
