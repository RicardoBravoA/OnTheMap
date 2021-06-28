//
//  BrowserUtil.swift
//  OnTheMap
//
//  Created by Ricardo Bravo on 27/06/21.
//

import UIKit

class BrowserUtil {
    
    static func open(url: URL) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
}
