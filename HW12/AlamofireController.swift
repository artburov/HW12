//
//  AlamofireController.swift
//  HW12
//
//  Created by Admin on 06.06.2020.
//  Copyright © 2020 home. All rights reserved.
//

import UIKit
import Alamofire

class AlamofireController: UIViewController {
    
    public var cityName: String?
    public var findWeather: Any?
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityWeatherLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        executeJSON()
        
    }
    
    func executeJSON() {
        AF.request("http://api.openweathermap.org/data/2.5/weather?q=Moscow&units=metric&lang=ru&appid=963c5c088b06689acbddeaad7c1cb399", method: .get).responseJSON(completionHandler: { response in
            
            switch response.result {
            case .success(_):
                if let jsonDict = response.value as? [String: AnyObject] {
                    
                    self.cityName = jsonDict["name"] as? String ?? nil
                    self.findWeather = jsonDict["main"]!["temp"] as? Double ?? 0.0
                }
            case .failure(_):
                break
            }
            
            //Async thred for loading change func in main thread
            DispatchQueue.main.async {
                self.changeLabels()
            }
        })
    }
    
    //Changes labels title, func getStringValue from Double extension
    func changeLabels() {
        let weatherValue = self.findWeather! as! Double
        cityWeatherLabel.text = weatherValue.getStringValue(withFloatingPoints: 1) + "\(" градусов")"
        cityNameLabel.text = self.cityName!
    }
}
