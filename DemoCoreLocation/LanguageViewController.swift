//
//  LanguageViewController.swift
//  DemoCoreLocation
//
//  Created by SHILEI CUI on 3/28/19.
//  Copyright © 2019 scui5. All rights reserved.
//

import UIKit
import Loki

class LanguageViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Choose Your Language"
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (LKManager.sharedInstance()?.languages.count)!
        //return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "lanCell")

        if let item = LKManager.sharedInstance()?.languages[indexPath.row] as? LKLanguage{
        LKManager.sharedInstance()?.currentLanguage = item
        cell?.textLabel?.text = LKManager.sharedInstance()?.currentLanguage.name!
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = LKManager.sharedInstance()?.languages[indexPath.row] as? LKLanguage
        LKManager.sharedInstance()?.currentLanguage = item
        let vc = storyboard?.instantiateViewController(withIdentifier: "ThirdViewController") as? ThirdViewController
        navigationController?.pushViewController(vc!, animated: true)
    }

}
