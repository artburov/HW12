//
//  ViewController.swift
//  HW12
//
//  Created by Admin on 31.05.2020.
//  Copyright © 2020 home. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    public var cityName: String?
    public var findWeather: Any?
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityWeatherLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=Moscow&units=metric&lang=ru&appid=963c5c088b06689acbddeaad7c1cb399")!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
                let jsonDict = json as? [String:AnyObject] {
                
                self.cityName = jsonDict["name"] as? String ?? nil
                self.findWeather = jsonDict["main"]!["temp"] as? Double ?? 0.0
                
                //Async thred for loading change func
                DispatchQueue.main.async {
                    self.changeLabels()
                }
            }
        }
        task.resume()
    }
    
    //Changes label title
    func changeLabels() {
        let weatherValue = self.findWeather! as! Double
        cityWeatherLabel.text = weatherValue.getStringValue(withFloatingPoints: 1) + "\(" градусов")"
        cityNameLabel.text = self.cityName!
    }
}

extension Double {
    //Converting Double into String with round after dot feature (ex. 14.x or 14.xx )
    func getStringValue(withFloatingPoints points: Int = 0) -> String {
        let valDouble = modf(self)
        let fractionalVal = (valDouble.1)
        if fractionalVal > 0 {
            return String(format: "%.*f", points, self)
        }
        return String(format: "%.0f", self)
    }
}




