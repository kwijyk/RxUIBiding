//
//  RxTableViewController.swift
//  RxBindUI
//
//  Created by Serhii Haponov on 7/18/18.
//  Copyright © 2018 Serhii Haponov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RxTableViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    let disposedBag = DisposeBag()
    
    let food = Observable.just([Food(name: "Chiza", flickerID: "Chizza"),
                Food(name: "Hot Dog", flickerID: "HotDog"),
                Food(name: "Picka-chu", flickerID: "Pickachu")])
    
    override func viewDidLoad() {
        super.viewDidLoad()

        food.bind(to: tableView.rx.items(cellIdentifier: "Cell")) { row, food, cell in
            cell.textLabel?.text = food.name
            cell.detailTextLabel?.text = food.flickerID
            cell.imageView?.image = food.image
        }.disposed(by: disposedBag)
        
        tableView.rx.modelSelected(Food.self).subscribe(onNext: {
            print("Your selected: \($0)")
        }).disposed(by: disposedBag)
       
    }
}
