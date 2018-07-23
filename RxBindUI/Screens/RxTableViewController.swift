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
import RxDataSources


//MARK: - Simple table view
//class RxTableViewController: UIViewController {
//
//    @IBOutlet private weak var tableView: UITableView!
//    let disposedBag = DisposeBag()
//    
//    let food = Observable.just([Food(name: "Chiza", flickerID: "Chizza"),
//                Food(name: "Hot Dog", flickerID: "HotDog"),
//                Food(name: "Picka-chu", flickerID: "Pickachu")])
//
//    let dataSource = RxTableViewSectionedReloadDataSource
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        food.bind(to: tableView.rx.items(cellIdentifier: "Cell")) { row, food, cell in
//            cell.textLabel?.text = food.name
//            cell.detailTextLabel?.text = food.flickerID
//            cell.imageView?.image = food.image
//        }.disposed(by: disposedBag)
//
//        tableView.rx.modelSelected(Food.self).subscribe(onNext: {
//            print("Your selected: \($0)")
//        }).disposed(by: disposedBag)
//        
//        
//        
//     
//    }
//}


//MARK: - Sectioned table view // Forward delegate
class RxTableViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    let disposedBag = DisposeBag()
    let foodData = SectionModelFood()
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Food>>(configureCell: { _, _, _, _ in
        return fatalError()
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource.configureCell = { _, tableView, indexPath, food in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else {
                fatalError()
            }
            cell.textLabel?.text = food.name
            cell.detailTextLabel?.text = food.flickerID
            cell.imageView?.image = food.image
            return cell
        }
        foodData.foods.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposedBag)
        
        tableView.rx.setDelegate(self).disposed(by: disposedBag)
    
    }
}

//MARK: - Forward delegate
extension RxTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
