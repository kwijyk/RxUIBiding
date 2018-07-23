//
//  SectionModelFood.swift
//  RxBindUI
//
//  Created by Serhii Haponov on 7/20/18.
//  Copyright © 2018 Serhii Haponov. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

struct SectionModelFood {
    
    let foods = Observable.just([
        SectionModel(model: "C", items: [Food(name: "Chiza", flickerID: "Chizza")]),
        SectionModel(model: "H", items: [Food(name: "Hot Dog", flickerID: "HotDog")]),
        SectionModel(model: "P", items: [Food(name: "Picka-chu", flickerID: "Pickachu")]),
        ])

}
