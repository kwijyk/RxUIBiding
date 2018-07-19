//
//  Food.swift
//  RxBindUI
//
//  Created by Serhii Haponov on 7/18/18.
//  Copyright © 2018 Serhii Haponov. All rights reserved.
//

import UIKit

struct Food {
    let name: String
    let flickerID: String
    let image: UIImage?
    
    init(name: String, flickerID: String) {
        self.name = name
        self.flickerID = flickerID
        image = UIImage(named: flickerID)
    }
}

extension Food: CustomStringConvertible {
    var description: String {
        return "\(name): flicker.com/\(flickerID)"
    }
}
