//
//  ViewController.swift
//  Date
//
//  Created by Harbros47 on 29.12.20.
//

import UIKit

class ViewController: UIViewController {
    
    private let date = Date()
    private let calendar = Calendar.current
    private let formatter = DateFormatter()
    private var students: [Student] = []
    private let names = ["Рома", "Дима", "Паша", "Влад", "Денис"]
    private let lastNames = ["Латыня", "Кушнер", "Вандич", "Кабачук", "Иванов"]
    private var warkDay = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creationOfStudents()
        studentInformation(students: sortedSudents())
        ageDifference()
        year()
    }
    
    func congratulation(date: Date) {
        for birthday in sortedSudents() {
            formatter.dateFormat = "dd.MM.yyyy"
            if formatter.string(from: birthday.dateOfBirth) == formatter.string(from: date) {
                print("С днём рождения! \(birthday.name)")
            }
        }
    }
    
    private func  creationOfStudents() {
        for _ in 1...30 {
            let year = Int.random(in: 1970...2004)
            let month = Int.random(in: 1...12)
            let day = Int.random(in: 1...30)
            let indexName = Int.random(in: 0..<names.count)
            let indexLastName = Int.random(in: 0..<lastNames.count)
            
            let dateComponents = DateComponents(calendar: calendar, year: year, month: month, day: day)
            let composedDate = calendar.date(from: dateComponents)
            students.append(
                Student(
                    dateOfBirth: composedDate ?? date,
                    name: names[indexName],
                    lastName: lastNames[indexLastName]
                )
            )
        }
    }
    
    private func sortedSudents() -> [Student] {
        students.sorted { $0.dateOfBirth > $1.dateOfBirth }
    }
    
    private func  studentInformation(students: [Student]) {
        for happyBirthday in students {
            formatter.dateFormat = "dd.MM.yyyy"
            print("""
            \(happyBirthday.name)
            \(happyBirthday.lastName)
            \(formatter.string(from: happyBirthday.dateOfBirth))

            """)
        }
    }
    
    private func ageDifference() {
        var minDate = date
        sortedSudents().forEach { minDate = min($0.dateOfBirth, minDate) }
        
        var maxDate = type(of: date).init(timeIntervalSince1970: 0)
        sortedSudents().forEach { maxDate = max($0.dateOfBirth, maxDate) }
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.year, .month, .weekOfMonth, .day ]
        formatter.unitsStyle = .brief
        let ageDifference = formatter.string(from: minDate, to: maxDate)
        print(ageDifference ?? "")
    }
    
    private func datesRang(from: Date, to: Date) -> [Date] {
        var fromInterval = from.timeIntervalSince1970
        let toInterval = to.timeIntervalSince1970
        var dates = [Date]()
        
        while fromInterval < toInterval {
            dates.append(Date(timeIntervalSince1970: fromInterval))
            fromInterval += 60 * 60 * 24
        }
        return dates
    }
    
    private func year() {
        let startDate = DateComponents(calendar: calendar, year: 2019, month: 12, day: 1)
        let composedDate = calendar.date(from: startDate)
        for index in 1...12 {
            let firstDate = calendar.startOfDay(for: composedDate ?? date)
            let intervalMonth = calendar.date(byAdding: .month, value: index, to: firstDate) ?? date
            let monthYear = calendar.dateInterval(of: .month, for: intervalMonth) ?? DateInterval()
            let everyDaysYear = datesRang(from: monthYear.start, to: monthYear.end)
            
            for warkDaysAndSunDay in everyDaysYear {
                formatter.dateFormat = "EEEE"
                guard formatter.string(from: warkDaysAndSunDay) == "Sunday" else {
                    if formatter.string(from: warkDaysAndSunDay) != "Saturday" {
                        warkDay += 1
                    }
                    continue
                }
                formatter.dateFormat = "EEEE  dd.MM"
                print(formatter.string(from: warkDaysAndSunDay))
            }
            
            let intervalFirstDayMonth = calendar.dateInterval(of: .weekday, for: intervalMonth) ?? DateInterval()
            let firstDayMonth = datesRang(
                from: intervalFirstDayMonth.start,
                to: intervalFirstDayMonth.end
            )
            formatter.dateFormat = "EEEE dd.MM.yyyy"
            let stringFormatDay = firstDayMonth.compactMap { formatter.string(from: $0) }
            stringFormatDay.forEach { print("--------\($0)") }
            
            print("кол-во рабочих дней в этом месяце \(warkDay)")
            warkDay = 0
        }
    }
}
