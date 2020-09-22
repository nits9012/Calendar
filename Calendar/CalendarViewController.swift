//
//  CalendarViewController.swift
//  Calendar
//
//  Created by Nitin Bhatt on 9/22/20.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {

    @IBOutlet weak var calendarView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.addCalendar()
    }
    
    //MARK:- Add calender to view
    private func addCalendar() {
        if let calendar = CalendarView.addCalendar(self.calendarView) {
            calendar.delegate = self
            calendar.monthAndYear.text = Date().monthAndYear
            calendar.getNumberDayFromSelectedMonth(value: Date())
        }
    }

}

extension CalendarViewController: CalendarDelegate {
    func getSelectedDate(_ date: String) {
        
    }
}


