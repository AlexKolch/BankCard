//
//  ViewManager.swift
//  BankCard
//
//  Created by Алексей Колыченков on 29.11.2023.
//

import UIKit

final class ViewManager {
    
    let colors: [ [String] ] = [
    ["#16A085FF", "#003F32FF"],
    ["#9A00D1FF", "#45005DFF"],
    ["#FA6000FF", "#FAC6A6FF"],
    ["#DE0007FF", "#8A0004FF"],
    ["#2980B9FF", "#2771A1FF"],
    ["#E74C3CFF", "#93261BFF"]
    ]
    
    let images: [UIImage] = [.init(resource: .icon1), .init(resource: .icon2), .init(resource: .icon3), .init(resource: .icon4), .init(resource: .icon5), .init(resource: .icon6)]

    static let shared = ViewManager()
    private init() {}
    
    func getGradient(frame: CGRect = CGRect(origin: .zero, size: CGSize(width: 306, height: 175)), colors: [String]) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = colors.map {
            UIColor(hex: $0)?.cgColor ?? UIColor.white.cgColor
        }
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        
        gradient.locations = [0,1] //плавность перехода
        
        return gradient
    }

    func setCard(colors: [String], balance: Float, cardNumber: Int, cardImage: UIImage) -> UIView {
        let card = {
            let card = UIView()
            let gradient = getGradient(colors: colors)
            card.layer.insertSublayer(gradient, at: 0) //кладем слой вниз, чтобы не перекрыть лейбл и имейдж
            card.clipsToBounds = true
            card.layer.cornerRadius = 30
            card.translatesAutoresizingMaskIntoConstraints = false
            card.widthAnchor.constraint(equalToConstant: 306).isActive = true
            card.heightAnchor.constraint(equalToConstant: 175).isActive = true
            card.tag = 7 //даем тэг, чтобы найти это вью
            return card
        }()
        
        let imageOnCard = {
            let imageView = UIImageView()
            imageView.image = cardImage
            imageView.layer.opacity = 0.3
            imageView.clipsToBounds = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
            imageView.tag = 8
            return imageView
        }()
        
        let balanceLabel = {
            let label = UILabel()
            label.text = "$\(balance)"
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
            return label
        }()
        
        let numberLabel = {
            let label = UILabel()
            label.textColor = .white
            label.text = "****\(cardNumber)"
            label.layer.opacity = 0.6
            return label
        }()
        
        let hStack = {
           let stack = UIStackView()
            stack.axis = .horizontal
            stack.distribution = .equalSpacing
            stack.alignment = .center
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.addArrangedSubview(balanceLabel)
            stack.addArrangedSubview(numberLabel)
            return stack
        }()
        
        card.addSubview(imageOnCard)
        card.addSubview(hStack)
        
        NSLayoutConstraint.activate([
            imageOnCard.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: -10),
            imageOnCard.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: 30),
            
            hStack.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 30),
            hStack.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -30),
            hStack.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -30)
        ])
        
        return card
    }
    
    func slideTitle(titleText: String) -> UILabel{
        let title = UILabel()
        title.text = titleText
        title.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        title.textColor = .white
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }
    
    func getCollection(id: String, dataSource: UICollectionViewDataSource, delegate: UICollectionViewDelegate) -> UICollectionView {
        let collection = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: 62, height: 62)
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 0
            layout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
            
            let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collection.restorationIdentifier = id
            collection.backgroundColor = .clear
            collection.showsHorizontalScrollIndicator = false
            collection.dataSource = dataSource
            collection.delegate = delegate
            collection.translatesAutoresizingMaskIntoConstraints = false
            collection.heightAnchor.constraint(equalToConstant: 70).isActive = true
            return collection
        }()
        return collection
    }
    
}
