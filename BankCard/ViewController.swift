//
//  ViewController.swift
//  BankCard
//
//  Created by Алексей Колыченков on 29.11.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var builder = {
        return ViewBuilder(controller: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#141414FF")
        builder.setPageTitle(text: "Design your virtual card")
        builder.getCard()
        builder.setCollectionColorSlider()
        builder.setCollectionIconSlider()
        builder.setDescriptionText()
        builder.setButton()
    }


}

