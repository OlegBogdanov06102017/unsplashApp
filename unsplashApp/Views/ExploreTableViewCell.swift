//
//  ExploreTableViewCell.swift
//  unsplashApp
//
//  Created by Oleg Bogdanov on 2023-07-03.
//

import UIKit

protocol Configurable {
    
    associatedtype Model
    
    func configure(with model: Model)
}

class ExploreTableViewCell: UITableViewCell, Configurable {
    static let reuseID = "ZeroSection"
   
    
    let myCell: UILabel = {
        let label = UILabel()
//        label.frame = CGRect(x: 0, y: 0, width: 76, height: 26)
        label.text = "Explore"
        label.font = UIFont.systemFont(ofSize: 22)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
        setupConst()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        self.addSubview(myCell)
    }
    
    func setupConst() {
        myCell.translatesAutoresizingMaskIntoConstraints = false
        let left = myCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        let right = myCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40)
        let top = myCell.topAnchor.constraint(equalTo: topAnchor, constant: 16)
        
        NSLayoutConstraint.activate([left, right, top])
    }
    
    func configure(with model: String) {
        myCell.text = model
    }
}



