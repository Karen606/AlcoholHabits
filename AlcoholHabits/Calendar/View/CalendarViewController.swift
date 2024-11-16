//
//  CalendarViewController.swift
//  AlcoholHabits
//
//  Created by Karen Khachatryan on 15.11.24.
//

import UIKit
import YACalendar

class CalendarViewController: UIViewController {
    @IBOutlet weak var monthButton: SectionButton!
    @IBOutlet weak var yearButton: SectionButton!
    @IBOutlet weak var calendarView: CalendarView!
    @IBOutlet weak var calendarBgView: UIView!
    @IBOutlet weak var buttonBottomConst: NSLayoutConstraint!
    var heightConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
         super.viewDidLoad()
         setHeightConstraint(to: 360)
         monthButton.isSelected = true
         calendarView.grid.scrollDirection = .horizonal
         calendarView.grid.calendarType = .oneOnOne
         calendarView.data = CalendarData()
         calendarBgView.layer.cornerRadius = 16
         calendarBgView.addShadow()
         calendarView.calendarDelegate = self
         let date = UserDefaults.standard.value(forKey: "date") as? Date
//         calendarView.selectDay(with: date ?? Date())
//         calendarView.setEvents([.init(title: "", startDate: date!, endDate: Date())])
        calendarView.selectDay(with: date!)
//         calendarView.config.day.borderWidth(for: .out, indicator: .selected)
//         calendarView.config.day.borderColor(for: .out, indicator: .selected)
        
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
        monthButton.isSelected = true
        yearButton.isSelected = false
        setHeightConstraint(to: 360)
        calendarBgView.layoutIfNeeded()
        calendarView.grid.calendarType = .oneOnOne
        calendarView.grid.scrollDirection = .horizonal
        calendarView.data = CalendarData()
        let date = UserDefaults.standard.value(forKey: "date") as? Date
        calendarView.setEvents([.init(title: "", startDate: date!, endDate: Date())])

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
        let date = UserDefaults.standard.value(forKey: "date") as? Date
//        calendarView.setEvents([.init(title: "", startDate: date!, endDate: Date())])
        calendarView.selectDay(with: date!)
        calendarView.scrollView.contentOffset = .zero
    }
     
    @IBAction func chooseMonth(_ sender: SectionButton) {
        if sender.isSelected { return }
        selectMonth()
    }
    
    @IBAction func chooseYear(_ sender: SectionButton) {
        if sender.isSelected { return }
        selectYear()
    }
}

extension CalendarViewController: CalendarViewDelegate {
    func didSelectDate(_ date: Date) {
        print(date)
        UserDefaults.standard.set(date, forKey: "date")
    }
    
    func didUpdateDisplayedDate(_ date: Date) {
        print(date)
    }
}

