//
//  ColorCell.swift
//  BankCard
//
//  Created by Алексей Колыченков on 04.12.2023.
//

import UIKit

class ColorCell: UICollectionViewCell {
    
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
    
    func setCell(colors: [String]) {
        let gradient = ViewManager.shared.getGradient(frame: CGRect(origin: .zero, size: CGSize(width: 62, height: 62)), colors: colors)
        self.layer.addSublayer(gradient)
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
        
        self.addSubview(checkImage)
        
        NSLayoutConstraint.activate([
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
