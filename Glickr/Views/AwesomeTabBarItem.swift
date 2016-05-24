//
//  AwesomeTabBarItem.swift
//  Glickr
//
//  Created by Ilter Cengiz on 24/05/16.
//  Copyright © 2016 Ilter Cengiz. All rights reserved.
//

import UIKit
import FontAwesome_swift

class AwesomeTabBarItem: UITabBarItem {
    
    @IBInspectable var iconCode: String? {
        didSet {
            if let code = iconCode {
                if let fontAwesome = FontAwesome.fromCode(code) {
                    image = UIImage.fontAwesomeIconWithName(fontAwesome, textColor: .blackColor(), size: CGSizeMake(30.0, 30.0))
                    return
                }
            }
            image = nil
        }
    }
    
}
