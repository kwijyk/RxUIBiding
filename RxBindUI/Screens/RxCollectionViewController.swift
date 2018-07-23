//
//  RxCollectionViewController.swift
//  RxBindUI
//
//  Created by Serhii Haponov on 7/19/18.
//  Copyright © 2018 Serhii Haponov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

extension String {
    public typealias Identity = String
    public var identity: Identity { return self }
}

struct AnimatedSectionModel {
    let title: String
    var data: [String]
}

extension AnimatedSectionModel: AnimatableSectionModelType {

    typealias Item = String
    typealias Identity = String
    
    var identity: Identity { return title }
    var items: [Item] { return data }
    
    init(original: AnimatedSectionModel, items: [String]) {
        self = original
        data = items
    }
    
}

class RxCollectionViewController: UIViewController {

    @IBOutlet private var longGesture: UILongPressGestureRecognizer!
    @IBOutlet private weak var addBarButtonItem: UIBarButtonItem!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    let disposedBag = DisposeBag()
    
    var dataSource = RxCollectionViewSectionedAnimatedDataSource<AnimatedSectionModel>(configureCell: { _ , collectionView, indexPath, title in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.titleLabel.text = title
        return cell
    }, configureSupplementaryView: {dataSource, collectionView, kind, indexPath in
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as! Header
        header.titleLabel.text = "Section: \(kind)"
        return header
    })
    
    
    let data = Variable([
        AnimatedSectionModel(title: "Section 0", data: ["0-0"])
        ])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data.asDriver().drive(collectionView.rx.items(dataSource: dataSource)).disposed(by: disposedBag)
        
        addBarButtonItem.rx.tap.asDriver().drive(onNext: {
            let section = self.data.value.count
            let items: [String] = {
                var items = [String]()
                let random = Int(arc4random_uniform(5) + 1)
                (0...random).forEach {
                    items.append("\(section) - \($0)")
                }
                return items
            }()
            
            self.data.value += [(AnimatedSectionModel(title: "Section \(section)", data: items))]
        }).disposed(by: disposedBag)
        
        
        longGesture.rx.event.subscribe(onNext: {
            switch $0.state {
            case .began:
                guard let selectedIndexPath = self.collectionView.indexPathForItem(at: $0.location(in: $0.view!)) else { break }
                print(self.collectionView.beginInteractiveMovementForItem(at: selectedIndexPath))
            case .changed:
                self.collectionView.updateInteractiveMovementTargetPosition($0.location(in: $0.view!))
            case .ended:
                self.collectionView.endInteractiveMovement()
            default:
                self.collectionView.cancelInteractiveMovement()
            }
        }).disposed(by: disposedBag)
        
    }
}


