//
//  ViewController.swift
//  Example
//
//  Created by Luis Padron on 9/16/16.
//  Copyright © 2016 Luis Padron. All rights reserved.
//
import Foundation
import UIKit
import UICircularProgressRing
import UserNotifications

var selectedDate = Date()

class ViewController: UIViewController, UICircularProgressRingDelegate  {
    
    
    
    //ring view and label
    @IBOutlet weak var ring1: UICircularProgressRingView!
    @IBOutlet weak var ring1Label: UILabel!
    @IBOutlet weak var currentDateLabel: UILabel!
    
    let holidaysArray: [Dates] = [Dates(date: "2019-03-13", dateDescription: "Niedziela niehandlowa"),
                                  Dates(date: "2019-03-17", dateDescription: "Niedziela niehandlowa"),
                                  Dates(date: "2019-02-06", dateDescription: "Niedziela niehandlowa"),
                                  Dates(date: "2019-03-24", dateDescription: "Niedziela niehandlowa"),
                                  Dates(date: "2019-04-07", dateDescription: "Niedziela niehandlowa"),
                                  Dates(date: "2019-04-21", dateDescription: "Wielkanoc"),
                                  Dates(date: "2019-04-22", dateDescription: "Poniedziałek Wielkanocny"),
                                  Dates(date: "2019-05-01", dateDescription: "Święto Pracy"),
                                  Dates(date: "2019-05-03", dateDescription: "Święto Konstytucji 3 Maja"),
                                  Dates(date: "2019-05-05", dateDescription: "Niedziela niehandlowa"),
                                  Dates(date: "2019-05-12", dateDescription: "Niedziela niehandlowa"),
                                  Dates(date: "2019-05-19", dateDescription: "Niedziela niehandlowa"),
                                  Dates(date: "2019-06-02", dateDescription: "Wniebowstąpienie"),
                                  Dates(date: "2019-06-09", dateDescription: "Zielone Świątki"),
                                  Dates(date: "2019-06-16", dateDescription: "Niedziela niehandlowa"),
                                  Dates(date: "2019-06-20", dateDescription: "Boże Ciało"),
                                  Dates(date: "2019-06-23", dateDescription: "Dzień Ojca"),
                                  Dates(date: "2019-07-07", dateDescription: "Niedziela niehandlowa"),
                                  Dates(date: "2019-07-14", dateDescription: "Niedziela niehandlowa"),
                                  Dates(date: "2019-07-21", dateDescription: "Niedziela niehandlowa"),
                                  Dates(date: "2019-08-04", dateDescription: "Niedziela niehandlowa"),
                                  Dates(date: "2019-08-11", dateDescription: "Niedziela niehandlowa"),
                                  Dates(date: "2019-08-15", dateDescription: "Wniebowzięcie Najświętszej Maryi Panny i też Święto Wojska Polskiego"),
                                  Dates(date: "2019-08-18", dateDescription: "Niedziela niehandlowa"),
                                  Dates(date: "2019-09-01", dateDescription: "Niedziela niehandlowa"),
                                  Dates(date: "2019-09-08", dateDescription: "Niedziela niehandlowa"),
                                  Dates(date: "2019-09-15", dateDescription: "Niedziela niehandlowa"),
                                  Dates(date: "2019-09-22", dateDescription: "Niedziela niehandlowa"),
                                  Dates(date: "2019-10-06", dateDescription: "Niedziela niehandlowa"),
                                  Dates(date: "2019-10-13", dateDescription: "Niedziela niehandlowa"),
                                  Dates(date: "2019-10-20", dateDescription: "Niedziela niehandlowa"),
                                  Dates(date: "2019-11-01", dateDescription: "Wszystkich Świętych"),
                                  Dates(date: "2019-11-03", dateDescription: "Niedziela niehandlowa"),
                                  Dates(date: "2019-11-10", dateDescription: "Niedziela niehandlowa"),
                                  Dates(date: "2019-11-11", dateDescription: "Święto Niepodległości"),
                                  Dates(date: "2019-11-17", dateDescription: "Niedziela niehandlowa"),
                                  Dates(date: "2019-12-01", dateDescription: "Niedziela niehandlowa"),
                                  Dates(date: "2019-12-08", dateDescription: "Niedziela niehandlowa"),
                                  Dates(date: "2019-12-25", dateDescription: "Boże Narodzenie"),
                                  Dates(date: "2019-12-26", dateDescription: "Boże Narodzenie")
                                ]
    
    var progressRingValue: CGFloat = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { (didAlow, error) in
        })
    
        setUpNavigationBar()
        // Customize ring UI
        ring1.animationStyle = CAMediaTimingFunctionName.linear.rawValue
        ring1.font = UIFont.systemFont(ofSize: 20)
        ring1.fontColor = .white
        ring1.outerRingWidth = CGFloat(7)
        ring1.innerRingWidth = CGFloat(5)
        ring1.innerRingColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        ring1.outerRingColor = #colorLiteral(red: 0.4751850367, green: 0.8376534581, blue: 0.9758662581, alpha: 1)
        ring1.delegate = self
        
    }
    
    func setUpNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.view.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
       
        }
        
    }

    override func viewDidAppear(_ animated: Bool) {
        //run animation
        UpdateTime()
        print("\(ring1.currentValue!)")
        //animation progress
        ring1.setProgress(value: progressRingValue , animationDuration: 4, completion: nil)
    }
    //func which convert dateRangeFunc into simple integer number
    func dateRangeFunc(second: Int, minutes: Int, hour: Int, day: Int) -> Int {
        let second = second
        let minutes = minutes * 60
        let hour = hour * 60 * 60
        let day = day * 24 * 60 * 60
        let rangeValue = second + minutes + hour + day
        return rangeValue
    }
    //main func which find all needed dates
    func UpdateTime() {
        let userCalendar = Calendar.current
        let date = NSDate()
        let components = userCalendar.dateComponents([ .hour, .minute, .month, .year, .day, .second, ], from: date as Date)
        //getting current date
        let currentDate = userCalendar.date(from: components)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let convertedDate = dateFormatter.string(from: currentDate!)
        currentDateLabel.text = convertedDate
        let testDate = dateFormatter.date(from: convertedDate)

        let dateObjects = holidaysArray.compactMap({ dateFormatter.date(from: $0.date) })
        print("Array of dates \(dateObjects)")

        var previousIndex = Int()
        func previousDateIndexFunc() -> Int {
            for (index, date) in dateObjects.enumerated(){
                if date == selectedDate {
                    print("\(date) || \(index) eto moja data")
                    previousIndex = index - 1
                    print("\(previousIndex) index proshloy daty")
                }
            }
            return previousIndex
        }
        //previous date (using index of array element)
        let previousDate = dateObjects[previousIndex]
        
        if let closestDate = dateObjects.sorted().first(where: { $0.timeIntervalSinceNow > 0 }) {
            print("\(closestDate.description(with: .current)) ближайшая дата ")
            selectedDate = closestDate
            
            let dateRange = Calendar.current.dateComponents([ .second, .minute, .hour, .day ], from: currentDate!, to: closestDate)
            let closestDateInterval = Calendar.current.dateComponents([ .second, .minute, .hour, .day], from: previousDate, to: closestDate)
            let currentDateInterval = Calendar.current.dateComponents([.second, .minute, .hour, .day], from: currentDate!, to: closestDate)
            
            let closestDateInt = dateRangeFunc(second: closestDateInterval.second!, minutes: closestDateInterval.minute!, hour: closestDateInterval.hour!, day: closestDateInterval.day!)
            
            let currentDateInt = dateRangeFunc(second: dateRange.second!, minutes: currentDateInterval.minute!, hour: currentDateInterval.hour!, day: currentDateInterval.day!)
            let intervalRingValue = 100 - (CGFloat(currentDateInt) / CGFloat(closestDateInt) * 100)
            progressRingValue = intervalRingValue
            ring1Label.text = String("Pozostałe dni: \n\(currentDateInterval.day!)")
            
            print("\(closestDateInt) разница между прошлой и будущей датами в секундах")
            print("\(currentDateInt) разница между текущей и будущей датами в секундах")
            print("\(intervalRingValue)")

        }
    }
    
    // The delegate method!
    func finishedUpdatingProgress(forRing ring: UICircularProgressRingView) {
            print("From delegate: Ring 1 finished")
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc: DateTableView
        if segue.identifier == "segueIdentifire" {
            dvc = segue.destination as! DateTableView
            dvc.holidaysArraySended = holidaysArray
            
            
        }
    }
    
}


