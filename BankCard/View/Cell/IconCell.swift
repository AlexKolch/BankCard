//
//  IconCell.swift
//  BankCard
//
//  Created by Алексей Колыченков on 04.12.2023.
//

import UIKit

class IconCell: UICollectionViewCell {
    
    private lazy var checkImage: UIImageView = {
        let imageV = UIImageView()
        imageV.image = UIImage(systemName: "checkmark")
        imageV.tintColor = .white
        imageV.translatesAutoresizingMaskIntoConstraints = false
        
        imageV.widthAnchor.constraint(equalToConstant: 24).isActive = true
        imageV.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        imageV.isHidden = true
        return imageV
    }()
    
   private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        imageView.layer.opacity = 0.2
        return imageView
    }()
    
    func setIcon(icon: UIImage) {
        imageView.image = icon
        self.addSubview(imageView)
        self.addSubview(checkImage)
        self.backgroundColor = UIColor(hex: "#1F1F1FFF")
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -10),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 10),
            checkImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            checkImage.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func selectItem() {
        checkImage.isHidden = false
    }
    
    func deselectItem() {
        checkImage.isHidden = true
    }
}
