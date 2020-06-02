//
//  WeatherLoader.swift
//  HW12
//
//  Created by Admin on 03.06.2020.
//  Copyright © 2020 home. All rights reserved.
//

import Foundation


protocol WeatherLoaderDelegate {
    func loaded(weather: [City])
}


class WeatherLoader {
    
    var delegate: WeatherLoaderDelegate?
    
    func loadWeather() {
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=Moscow&units=metric&lang=ru&appid=963c5c088b06689acbddeaad7c1cb399")!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
                let jsonDict = json as? NSDictionary {
                
//                print(jsonDict)
                
                var weather: [City] = []
                
                for (_, data) in jsonDict where data is NSDictionary {
                    if let allWeather = City(data: data as! NSDictionary) {
                        
                        weather.append(allWeather)
                        
                    }
                }
                print(weather.count)
                self.delegate?.loaded(weather: weather)
            }
        }
        task.resume()
        
    }
    
    
    
}
