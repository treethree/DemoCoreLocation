//
//  ApiHandler.swift
//  DemoCoreLocation
//
//  Created by SHILEI CUI on 3/26/19.
//  Copyright © 2019 scui5. All rights reserved.
//

import Foundation

let baseAPIUrl = "https://api.darksky.net/forecast/68a4eee2e315f76149908dc5f3a1d092/%f,%f"

class Apihandler: NSObject {
    static let sharedInstance = Apihandler()
    private override init() {}
    
    func getApiForWeather(lat : Double, lot : Double ,completion: @escaping (_ arrayWeather: Weather?, _ error: Error?) -> Void){

        
        let urlString = String(format: baseAPIUrl, arguments:[lat,lot])
        guard let url = URL(string: urlString) else{
            return
        }
        //print(urlString)
        URLSession.shared.dataTask(with : url){ (data, response, error) in
//            guard let data = data else {
//                return
//            }
            
            if error == nil{
                do{
                    //print(data)
                    print(urlString)
                    let weath = try? JSONDecoder().decode(Weather.self, from: data!)
                    //print(weath)
                    print(weath)
                    DispatchQueue.main.async {
                        
                        //print(weath!.latitude)
                        completion(weath,nil)
                        //print(weath?.currently)
                    }
//                    catch{
//                        completion(nil,error)
//                    }
                    }
                }
            }.resume()
        }
}

