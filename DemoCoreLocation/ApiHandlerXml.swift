//
//  ApiHandlerXml.swift
//  DemoCoreLocation
//
//  Created by SHILEI CUI on 3/29/19.
//  Copyright © 2019 scui5. All rights reserved.
//

import Foundation

let urlXml = "http://static.klipfolio.com/static/klips/saas/example_data/sales.xml"

class ApiHandlerXml: NSObject {
    static let sharedInstance = ApiHandlerXml()
    private override init() {}
    
    // parse url xml and completion the area which is arrray of dictionary
    func parseXmlCall(completion: @escaping (_ arrayWeather: Array<Dictionary<String, Any>>?, _ error: Error?) -> Void){
        URLSession.shared.dataTask(with: URL(string: urlXml)!) { (data, response, error) in
            do{
                let dataStr1 = String(data: data!, encoding: String.Encoding.utf8)
                let dict1 = try XMLReader.dictionary(forXMLString: dataStr1)
                let rt :  Dictionary<String, Any> = dict1["root"] as! Dictionary<String, Any>
                let qtd : Dictionary<String, Any> = rt["qtd"] as! Dictionary<String, Any>
                let area : Array<Dictionary<String, Any>> = qtd["area"] as! Array<Dictionary<String, Any>>
                completion(area,nil)
            }catch{ 
            }
            }.resume()
    }
    
    //find local xml path and return URL
    func findXmlPath(res : String, ext: String)->URL?{
        if let path = Bundle.main.url(forResource: res, withExtension: ext){
            return path
        }
        return nil
    }
    
}
