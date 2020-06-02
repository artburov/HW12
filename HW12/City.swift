//
//  City.swift
//  HW12
//
//  Created by Admin on 02.06.2020.
//  Copyright © 2020 home. All rights reserved.
//

import Foundation

class City {
    let name: String
    var temp: Double

    init?(data: NSDictionary) {
        guard let name = data["name"] as? String,
            let temp = data["temp"] as? Double else {
                return nil
        }
        self.name = name
        self.temp = temp
    }

}




struct Temp {
    let temp: Double
}
