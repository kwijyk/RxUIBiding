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
    @IBOutlet private weak var conllectionView: UICollectionView!
    
    let disposedBag = DisposeBag()
    
   let dataSource = RxTableViewSectionedReloadDataSource<SectionModel>()
    
    let data = Variable([
        AnimatedSectionModel(title: "Section 0", data: ["0-0"])]
        )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

}
