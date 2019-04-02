//
//  DateCalculationVC.swift
//  Example
//
//  Created by Antony Kolesynskyi on 18.09.2018.
//  Copyright © 2018 Luis Padron. All rights reserved.
//

import Foundation
import UIKit

class DateTableView: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var holidaysArraySended: [Dates] = []
    var valueToPass: [Dates] = []
    @IBOutlet weak var tableView: UITableView!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return holidaysArraySended.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DataTableViewCell
        cell.backgroundColor = .clear
        cell.dataLabel.text = holidaysArraySended[indexPath.row].date
        cell.descriptionLabel.text = holidaysArraySended[indexPath.row].dateDescription
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        if let index = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cell" {
            if let indexPath = tableView.indexPathForSelectedRow {
               let dvc = segue.destination as! ChoosenDateController
               // print("\(holidaysArraySended[indexPath.row].date) kjljk")
                dvc.choosenDate = holidaysArraySended[indexPath.row].date
                dvc.choosenDescription = holidaysArraySended[indexPath.row].dateDescription
            }
            
        }
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}






















