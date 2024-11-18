//
//  CalendarViewController.swift
//  AlcoholHabits
//
//  Created by Karen Khachatryan on 15.11.24.
//

import UIKit
import Combine
import YACalendar

class CalendarViewController: UIViewController {
    @IBOutlet weak var monthButton: SectionButton!
    @IBOutlet weak var yearButton: SectionButton!
    @IBOutlet weak var calendarView: CalendarView!
    @IBOutlet weak var calendarBgView: UIView!
    @IBOutlet weak var buttonBottomConst: NSLayoutConstraint!
    var heightConstraint: NSLayoutConstraint?
    private let viewModel = CalendarViewModel.shared
    private var cancellables: Set<AnyCancellable> = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setHeightConstraint(to: 360)
        monthButton.titleLabel?.font = .regularZen(size: 20)
        yearButton.titleLabel?.font = .regularZen(size: 20)
        monthButton.isSelected = true
        calendarView.grid.scrollDirection = .horizonal
        calendarView.scrollView.isScrollEnabled = false
        calendarView.grid.calendarType = .oneOnOne
        calendarView.data = CalendarData()
        calendarBgView.layer.cornerRadius = 16
        calendarBgView.addShadow()
        calendarView.calendarDelegate = self
        subscribe()
//        viewModel.fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        viewModel.fetchData()
    }
    
    func subscribe() {
        viewModel.$drinks
            .receive(on: DispatchQueue.main)
            .sink { [weak self] drinks in
                guard let self = self else { return }
                if self.calendarView.grid.calendarType == .oneOnOne {
//                    self.calendarView.data = CalendarData()
//                    let events = drinks.map({ CalendarEvent(title: "", startDate: $0.date ?? Date(), endDate: $0.date ?? Date() )})
//                    self.calendarView.setEvents(events)
                    self.selectMonth()
                } else {
                    self.selectYear()
//                    let currentDate = Date()
//                    let calendar = Calendar.current
//                    let firstDayOfYear = calendar.date(from: calendar.dateComponents([.year], from: currentDate))
//                    let lastDayOfYear = calendar.date(bySetting: .month, value: 12, of: currentDate)
//                    let lastDate = calendar.date(bySetting: .day, value: calendar.range(of: .day, in: .month, for: lastDayOfYear!)?.count ?? 31, of: lastDayOfYear!)
//                    self.calendarView.data = CalendarData(calendar: calendar, startDate: firstDayOfYear, endDate: lastDate)
//                    let dates = drinks.map({ $0.date ?? Date() })
//                    self.calendarView.selectDays(with: dates)
                }
            }
            .store(in: &cancellables)
    }
    
    func setHeightConstraint(to height: CGFloat) {
        if let heightConstraint = heightConstraint {
            heightConstraint.isActive = false
        }
        heightConstraint = calendarView.heightAnchor.constraint(equalToConstant: height)
        heightConstraint?.isActive = true
    }

    func removeHeightConstraint() {
        if let heightConstraint = heightConstraint {
            heightConstraint.isActive = false
            self.heightConstraint = nil
        }
    }
    
    func selectMonth() {
        calendarView.grid.calendarType = .oneOnOne
        calendarView.grid.scrollDirection = .horizonal
        calendarView.data = CalendarData()
        monthButton.isSelected = true
        yearButton.isSelected = false
        setHeightConstraint(to: 360)
        calendarBgView.layoutIfNeeded()
//        let currentDate = Date()
//        let calendar = Calendar.current
//        let firstDayOfYear = calendar.date(from: calendar.dateComponents([.year], from: currentDate))
//        let lastDayOfYear = calendar.date(bySetting: .month, value: 12, of: currentDate)
//        let lastDate = calendar.date(bySetting: .day, value: calendar.range(of: .day, in: .month, for: lastDayOfYear!)?.count ?? 31, of: lastDayOfYear!)
//        calendarView.data = CalendarData(calendar: calendar, startDate: firstDayOfYear, endDate: lastDate)
        
//        let events = viewModel.drinks.map({ CalendarEvent(title: "", startDate: $0.date ?? Date(), endDate: $0.date ?? Date() )})
        let events = viewModel.dates.map({ CalendarEvent(title: "", startDate: $0, endDate: $0)})
        calendarView.setEvents(events)
        calendarView.scrollView.isScrollEnabled = false
    }
    
    func selectYear() {
        yearButton.isSelected = true
        monthButton.isSelected = false
        removeHeightConstraint()
        calendarBgView.layoutIfNeeded()
        calendarView.grid.calendarType = .threeOnFour
        calendarView.grid.scrollDirection = .vertical
        let currentDate = Date()
        let calendar = Calendar.current
        let firstDayOfYear = calendar.date(from: calendar.dateComponents([.year], from: currentDate))
        let lastDayOfYear = calendar.date(bySetting: .month, value: 12, of: currentDate)
        let lastDate = calendar.date(bySetting: .day, value: calendar.range(of: .day, in: .month, for: lastDayOfYear!)?.count ?? 31, of: lastDayOfYear!)
        calendarView.data = CalendarData(calendar: calendar, startDate: firstDayOfYear, endDate: lastDate)
        calendarView.scrollView.contentOffset = .zero
        self.calendarView.selectDays(with: viewModel.dates)
        calendarView.scrollView.isScrollEnabled = true
    }
     
    @IBAction func chooseMonth(_ sender: SectionButton) {
        if sender.isSelected { return }
        selectMonth()
    }
    
    @IBAction func chooseYear(_ sender: SectionButton) {
        if sender.isSelected { return }
        selectYear()
    }
    
    @IBAction func clickedAdd(_ sender: UIButton) {
        self.hidesBottomBarWhenPushed = true
        self.pushViewController(DrinkFormViewController.self)
        self.hidesBottomBarWhenPushed = false
    }
}

extension CalendarViewController: CalendarViewDelegate {
    func didSelectDate(_ date: Date) {
        DrinkFormViewModel.shared.drinkModel.date = date
    }
    
    func didUpdateDisplayedDate(_ date: Date) {
    }
}

