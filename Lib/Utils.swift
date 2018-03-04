//
//  Utils.swift
//  MDB Socials
//
//  Created by Mudabbir Khan on 3/3/18.
//  Copyright © 2018 MHK. All rights reserved.
//

import Foundation
import PromiseKit
import Haneke
import CoreLocation

class Utils {
    static func getImage(withUrl: String) -> Promise<UIImage> {
        return Promise { fulfill, _ in
            let cache = Shared.imageCache
            if let imageUrl = URL(string: withUrl) {
                cache.fetch(URL: imageUrl as URL).onSuccess({ img in
                    fulfill(img)
                })
            }
        }
    }
    
    static func doubleToCurrencyString(val: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = NSLocale(localeIdentifier: "en_US") as Locale!
        return formatter.string(from: NSNumber(value: val))!
    }
    
    static func getDistance(location1: CLLocation, location2: CLLocation) -> Double {
        let distance = location1.distance(from: location2)
        let miles = distance/1609.344
        return Double(round(100*miles)/100)
    }
    
    static func getPercentageString(decimal: Double) -> String {
        let x = decimal * 100
        let rounded = Double(round(100*x)/100)
        return "\(x)%"
    }
}
