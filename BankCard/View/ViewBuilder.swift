//
//  ViewBuilder.swift
//  BankCard
//
//  Created by Алексей Колыченков on 29.11.2023.
//

import UIKit

enum RestoreIDs: String {
    case colors, images
}

final class ViewBuilder: NSObject {
    private let manager = ViewManager.shared
    private var index = 0 {
        didSet {
            colorCollection.reloadData()
        }
    }
    private var card = UIView() //сюда будем присваивать карту
    private let balance: Float = 9.999
    private let cardNumber: Int = 1234
    
    private var colorCollection: UICollectionView!
    private var imageCollection: UICollectionView!
    
    var controller: UIViewController
    var view: UIView
    
    var cardColor = ["#16A085FF", "#003F32FF"] {
        willSet {
            if let colorView = view.viewWithTag(7) { //если смогли найти вью по тегу
                colorView.layer.sublayers?.remove(at: 0)
                let gradient = manager.getGradient(colors: newValue)
                
                colorView.layer.insertSublayer(gradient, at: 0) //удаляем слой с градиентом и присваиваем новый, полученный из newValue
            }
        }
    }
    
    var cardIcon: UIImage = .init(resource: .icon1) {
        willSet {
            if let iconView = card.viewWithTag(8) as? UIImageView {
                iconView.image = newValue
            }
        }
    }

    init(controller: UIViewController) {
        self.controller = controller
        self.view = controller.view
    }
    
    private lazy var pageTitle: UILabel = {
        let title = UILabel()
        title .textColor = .white
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        title.numberOfLines = 0
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    func setPageTitle(text: String) {
        pageTitle.text = text
        view.addSubview(pageTitle)
        
        NSLayoutConstraint.activate([
            pageTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            pageTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            pageTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
    }
    
    func getCard() {
        card = manager.setCard(colors: cardColor, balance: balance, cardNumber: cardNumber, cardImage: cardIcon)
        
        view.addSubview(card)
        
        NSLayoutConstraint.activate([
            card.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            card.topAnchor.constraint(equalTo: pageTitle.bottomAnchor, constant: 30)
        ])
    }
    
    func setCollectionColorSlider() {
        let colorTitle = manager.slideTitle(titleText: "Select color")
        
        colorCollection = manager.getCollection(id: RestoreIDs.colors.rawValue, dataSource: self, delegate: self)
        colorCollection.register(ColorCell.self, forCellWithReuseIdentifier: "cell")
        
        view.addSubview(colorTitle)
        view.addSubview(colorCollection)
        
        NSLayoutConstraint.activate([
        colorTitle.topAnchor.constraint(equalTo: card.bottomAnchor, constant: 50),
        colorTitle.leadingAnchor.constraint (equalTo: view.leadingAnchor, constant: 30),
        colorTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

        colorCollection.topAnchor.constraint(equalTo: colorTitle.bottomAnchor, constant: 20),
        colorCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        colorCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setCollectionIconSlider() {
        let iconSliderTitle = manager.slideTitle(titleText: "Add shapes")
        
        imageCollection = manager.getCollection(id: RestoreIDs.images.rawValue, dataSource: self, delegate: self)
        imageCollection.register(IconCell.self, forCellWithReuseIdentifier: "cell")
        
        view.addSubview(iconSliderTitle)
        view.addSubview(imageCollection)
        
        NSLayoutConstraint.activate([
            iconSliderTitle.topAnchor.constraint(equalTo: colorCollection.bottomAnchor, constant: 40),
            iconSliderTitle.leadingAnchor.constraint (equalTo: view.leadingAnchor, constant: 30),
            iconSliderTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            imageCollection.topAnchor.constraint(equalTo: iconSliderTitle.bottomAnchor, constant: 20),
            imageCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setDescriptionText() {
        let descrText: UILabel = {
            let text = UILabel()
            text.text = "Don't worry. You can always change the design of your virtual card. Just enter the settings."
            text.setLineHeight(lineHeight: 10)
            text.textColor = UIColor(hex: "#6F6F6FFF")
            text.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
            text.numberOfLines = 0
            text.translatesAutoresizingMaskIntoConstraints = false
            return text
        }()
        
        view.addSubview(descrText)
        
        NSLayoutConstraint.activate([
            descrText.topAnchor.constraint(equalTo: imageCollection.bottomAnchor, constant: 40),
            descrText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            descrText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
    
    func setButton() {
        let btn = {
            let btn = UIButton(primaryAction: nil)
            btn.setTitle("Continue", for: .normal)
            btn.setTitleColor(.black, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            btn.backgroundColor = .white
            btn.layer.cornerRadius = 20
            btn.translatesAutoresizingMaskIntoConstraints = false
            
            btn.layer.shadowColor = UIColor.white.cgColor
            btn.layer.shadowRadius = 10
            btn.layer.shadowOpacity = 0.5
            
            return btn
        }()
        
        view.addSubview(btn)
        
        NSLayoutConstraint.activate([
            btn.heightAnchor.constraint(equalToConstant: 60),
            btn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            btn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            btn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
}

extension ViewBuilder: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.restorationIdentifier {
        case RestoreIDs.colors.rawValue:
            return manager.colors.count
        case RestoreIDs.images.rawValue:
            return manager.images.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.restorationIdentifier {
        case RestoreIDs.colors.rawValue:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ColorCell {
                let color = manager.colors[indexPath.item]
                cell.setCell(colors: color)

                if index == 0, indexPath.item == 0 {
                    cell.selectItem()
                } 
          
                return cell
            }
        case RestoreIDs.images.rawValue:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? IconCell {
                let icon = manager.images[indexPath.item]
                cell.setIcon(icon: icon)
                return cell
            }
        default:
            return UICollectionViewCell()
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.restorationIdentifier {
        case RestoreIDs.colors.rawValue:
            let color = manager.colors[indexPath.item] //элемент на который мы нажали
            self.cardColor = color
           
            let selectedCell = collectionView.cellForItem(at: indexPath) as? ColorCell
            print("Select", indexPath.item)
            index = indexPath.item
//            if index != 0 {
//                
//                selectedCell?.selectItem()
//            }
//            collectionView.reloadData()
//            print("Select", indexPath.item)
      
        case RestoreIDs.images.rawValue:
            let image = manager.images[indexPath.item]
            self.cardIcon = image
            
            let cell = collectionView.cellForItem(at: indexPath) as? IconCell
            cell?.selectItem()
        default:
            return
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
     
        switch collectionView.restorationIdentifier {
        case RestoreIDs.colors.rawValue:
           
            let cell = collectionView.cellForItem(at: indexPath) as? ColorCell
       
                cell?.deselectItem()

         
            print("Deselect", indexPath.item)
        case RestoreIDs.images.rawValue:
            let cell = collectionView.cellForItem(at: indexPath) as? IconCell
            cell?.deselectItem()
        default:
            return
        }
    }
}
