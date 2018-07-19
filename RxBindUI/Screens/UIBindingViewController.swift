//
//  UIBindingViewController.swift
//  RxBindUI
//
//  Created by Serhii Haponov on 7/18/18.
//  Copyright © 2018 Serhii Haponov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class UIBindingViewController: UIViewController {

    @IBOutlet private weak var button: UIButton!
    @IBOutlet private weak var hiLabel: UILabel!
    @IBOutlet private weak var firsetLabel: UILabel!
    @IBOutlet private weak var swichTriger: UISwitch!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var secondLabel: UILabel!
    @IBOutlet private weak var activityView: UIActivityIndicatorView!
    @IBOutlet private weak var datePicker: UIDatePicker!
    @IBOutlet private weak var thirdLabel: UILabel!
    @IBOutlet private weak var textFieldLabel: UILabel!
    @IBOutlet private weak var textViewLabel: UILabel!
    @IBOutlet private weak var slider: UISlider!
    @IBOutlet private weak var progressView: UIProgressView!
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private var tapGesture: UITapGestureRecognizer!
    @IBOutlet private weak var stepper: UIStepper!
    @IBOutlet private weak var stepperLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    
    private lazy var dateFormater: DateFormatter = {
        let formater  = DateFormatter()
        formater.dateStyle = .medium
        formater.timeStyle = .short
        return formater
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapGesture.rx.event.asDriver().drive(onNext: { _ in
            self.view.endEditing(true)
        }).disposed(by: disposeBag)
        
        textField.rx.text.orEmpty.bind(onNext: {
            self.textFieldLabel.text = $0
        }).disposed(by: disposeBag)
        
        textView.rx.text.orEmpty.bind(onNext: {
            self.textViewLabel.text = "Character =\($0.count)"
        }).disposed(by: disposeBag)
        
        button.rx.tap.asDriver().drive(onNext: {
            self.firsetLabel.text! += self.hiLabel.text!
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            })
        }).disposed(by: disposeBag)
        
        slider.rx.value.asDriver().drive(progressView.rx.progress).disposed(by: disposeBag)
        
        segmentedControl.rx.value.asDriver().skip(1).drive(onNext: {
            self.secondLabel.text = "Selected segment = \($0)"
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            })
        }).disposed(by: disposeBag)
        
        datePicker.rx.value.asDriver()
            .map {
                self.dateFormater.string(from: $0)
            }.skip(1).drive(thirdLabel.rx.text).disposed(by: disposeBag)
        

        stepper.rx.value.asDriver()
            .map {
                String(Int($0))
            }
            .drive(onNext: {
                self.stepperLabel.text = $0
            }).disposed(by: disposeBag)
        
        swichTriger.rx.value.asDriver()
            .map { !$0 }
            .drive(activityView.rx.isHidden).disposed(by: disposeBag)
        swichTriger.rx.value.asDriver().drive(activityView.rx.isAnimating).disposed(by: disposeBag)
        
    }
}
