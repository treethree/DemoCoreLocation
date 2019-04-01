//
//  ThirdViewController.swift
//  DemoCoreLocation
//
//  Created by SHILEI CUI on 3/28/19.
//  Copyright © 2019 scui5. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet weak var lblText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        lblText.text = NSLocalizedString("Ktesting", comment: "")
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
