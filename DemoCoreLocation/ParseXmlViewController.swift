//
//  ParseXmlViewController.swift
//  DemoCoreLocation
//
//  Created by SHILEI CUI on 3/29/19.
//  Copyright © 2019 scui5. All rights reserved.
//

import UIKit

class ParseXmlViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tblView: UITableView!
    var areaArray : Array<Dictionary<String, Any>> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseXmlCall()
    }

    // Api call to get area data and assign to area array then reload tableView
    func parseXmlCall(){
        ApiHandlerXml.sharedInstance.parseXmlCall { (area, error) in
            self.areaArray = area!
            DispatchQueue.main.async {
                self.tblView.reloadData()
            }
        }
    }
    
    // set number of rows in each section from area array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return areaArray.count
    }
    
    //for each cell in row we set value for that custom cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "xmlCell", for: indexPath)
        let obj = areaArray[indexPath.row]
        cell.textLabel!.text = obj["name"] as? String
        cell.detailTextLabel!.text = obj["bookings"] as? String
        return cell
    }
}

