

import UIKit
import UserNotifications

class NotificationsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UNUserNotificationCenterDelegate{
    
    //@IBOutlet weak var footerTextLabel: UILabel!
    @IBOutlet weak var headerTextLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var date = Date()
    static let shared = NotificationsVC()
    
    let defaults = UserDefaults.standard
    let notiSettings = ["1 godzina przed", "6 godzin przed", "12 godzin przed" ,"1 dzień przed"]
    
    let sendedDate = selectedDate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notiSettings.count
    }
    
    func footerAndHeaderFunc() {
        let headerView = UIView()
        
        let headerText = "Wybierz kiedy Ci przypomnieć o następnym niehandlowym dniu"
        

        
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 60)
        headerView.backgroundColor = UIColor.clear
        headerTextLabel.text = headerText
        headerTextLabel.sizeToFit()
    }
    
    
    @objc func switchChanged(_ sender : UISwitch!){
        defaults.set(sender.isOn, forKey: ("\(sender.tag)"))
        print("table row switch Changed \(sender.tag)")
        print("The switch is \(sender.isOn ? "ON" : "OFF")")
        
        if sender.isOn && sender.tag == 0 {
            print("first switcher")
            addNotificationWithCalendarTrigger(title: "First", subtitle: "First", body: "First", identifire: "first", components: componentsFunc(), index: 0)
            
        } else if sender.isOn && sender.tag == 1 {
            print("second switcher")
            addNotificationWithCalendarTrigger(title: "Second", subtitle: "Second", body: "Second", identifire: "second", components: componentsFunc(), index: 1)
        } else if sender.isOn && sender.tag == 2 {
            print("third switcher")
            addNotificationWithCalendarTrigger(title: "Third", subtitle: "Third", body: "Third", identifire: "third", components: componentsFunc(), index: 2)
        } else if sender.isOn && sender.tag == 3 {
            print("fourth switcher")
            addNotificationWithCalendarTrigger(title: "Fourth", subtitle: "Fourth", body: "Fourth", identifire: "fourth", components: componentsFunc(), index: 3)
        }

    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notiCell", for: indexPath)
        cell.textLabel?.text = notiSettings[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.textAlignment = .left

        let switchView = UISwitch(frame: .zero)
        switchView.tag = indexPath.row // for detect which row switch Changed
        switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
        
        func switchFunc() {
            if let switcher = defaults.value(forKey: ("\(switchView.tag)")) {
                switchView.isOn = switcher as! Bool
                defaults.synchronize()
                
            }
        }
        
        switchFunc()
        cell.accessoryView = switchView
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        footerAndHeaderFunc()
        
    }
    
    func componentsFunc() -> [DateComponents] {
        
        var components1 = DateComponents()
        var components2 = DateComponents()
        var components3 = DateComponents()
        var components4 = DateComponents()
        
        let formatedDate = Calendar.current.dateComponents([.second, .minute, .hour, .day, .month, .year], from: sendedDate)
        
        components1.second = formatedDate.second
        components1.minute = formatedDate.minute
        components1.hour = 22
        components1.day = formatedDate.day! - 1
        components1.month = formatedDate.month
        components1.year = formatedDate.year

        components2.second = formatedDate.second
        components2.minute = formatedDate.minute
        components2.hour = 18
        components2.day = formatedDate.day! - 1
        components2.month = formatedDate.month
        components2.year = 2019
        
        components3.second = formatedDate.second
        components3.minute = formatedDate.minute
        components3.hour = 12
        components3.day = formatedDate.day! - 1
        components3.month = formatedDate.month
        components3.year = 2019
        
        components4.second = formatedDate.second
        components4.minute = formatedDate.minute
        components4.hour = 0
        components4.day = formatedDate.day! - 1
        components4.month = formatedDate.month
        components4.year = 2019

        let components = [components1, components2, components3, components4]
        return components
    }
    
    
    
    func addNotificationWithCalendarTrigger(title: String, subtitle: String, body: String, identifire: String, components: [DateComponents], index: Int ) {
        
        let content = UNMutableNotificationContent()
        let identifire = identifire
        content.title = title
        content.subtitle = subtitle
        content.body = body
        content.sound = UNNotificationSound.default
        
        let components = componentsFunc()
        let componentIndex: Int = index
        print("\(components[0])")
        print("\(components[1])")
        print("\(components[2])")
        print("\(components[3])")
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components[componentIndex], repeats: false)
        let request = UNNotificationRequest(identifier: identifire, content: content, trigger: trigger)
    
        UNUserNotificationCenter.current().add(request) {(error) in
            
            }
        }
    }
