//
//  ViewController.swift
//  HW12
//
//  Created by Admin on 31.05.2020.
//  Copyright © 2020 home. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var weather: [City] = []
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityWeatherLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WeatherLoader().loadWeather()
        
    }
    
    
}




