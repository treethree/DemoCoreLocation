//
//  ParseLocalXmlViewController.swift
//  DemoCoreLocation
//
//  Created by SHILEI CUI on 3/29/19.
//  Copyright © 2019 scui5. All rights reserved.
//

import UIKit

class ParseLocalXmlViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource{
    

    @IBOutlet weak var tblView: UITableView!
    var foodArray : Array<Dictionary<String, Any>> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        localXmlCall()
    }
    // return number of rows in each section from food array.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodArray.count
    }
    // generate reusable cell and assign name and price for each cell.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "localCell")
        
        // for in project xml file
        let obj = foodArray[indexPath.row]
        cell!.textLabel!.text = obj["name"] as? String
        cell!.detailTextLabel!.text = obj["price"] as? String
        return cell!
    }
    //call api to get local xml path and parse it.
    func localXmlCall(){
        let path = ApiHandlerXml.sharedInstance.findXmlPath(res: "Breakfast", ext: ".xml")
        let data = try! Data(contentsOf: path!)
        let dataStr = String(data: data,encoding: String.Encoding.utf8)
        let dict = try? XMLReader.dictionary(forXMLString: dataStr)
        let bfmenu: Dictionary<String, Any> = dict!["breakfast_menu"] as! Dictionary<String, Any>
        let fd : Array<Dictionary<String, Any>> = bfmenu["food"] as! Array<Dictionary<String, Any>>
        
        self.foodArray = fd
        DispatchQueue.main.async {
            self.tblView.reloadData()
        }
        
    }
    
    

}
