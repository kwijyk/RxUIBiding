//
//  ViewController.swift
//  RxBindUI
//
//  Created by Serhii Haponov on 7/17/18.
//  Copyright © 2018 Serhii Haponov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PropertyBindingViewController: UIViewController {
    
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var button: UIButton!
    
    let disposeBag = DisposeBag()
    
    let textFieldText = BehaviorRelay(value: "Hey")
    let buttonSubject = PublishSubject<String>()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.rx.text.orEmpty.bind(to: textFieldText).disposed(by: disposeBag)
        textFieldText.asObservable().subscribe(onNext: {
            print($0)
        }).disposed(by: disposeBag)
        
        button.rx.tap.map{ "Heloo" }.bind(to: buttonSubject).disposed(by: disposeBag)
        buttonSubject.subscribe(onNext: {
            print($0)
        }).disposed(by: disposeBag)
        
        textField.rx.text.orEmpty.bind(onNext: {
            print($0)
        }).disposed(by: disposeBag)
    }
}

