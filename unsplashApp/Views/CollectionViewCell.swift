//
//  CollectionViewCell.swift
//  unsplashApp
//
//  Created by Oleg Bogdanov on 2023-07-05.
//

import UIKit
import Kingfisher

class CollectionViewCell: UICollectionViewCell{
    static let reuseIDCollection = "SecondSection"
    let myCollectionCell: UIImageView = {
        let imageView = UIImageView()
        //imageView.frame = CGRect(x: 0, y: 0, width: 319, height: 130)
        //imageView.backgroundColor = .blue
        imageView.layer.cornerRadius = 37
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .center
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .blue
        return imageView
    }()
    
    private var currentId: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(myCollectionCell)
    }
    
   func setupConstraints() {
       myCollectionCell.translatesAutoresizingMaskIntoConstraints = false
       let left = myCollectionCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0)
       let right = myCollectionCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
       let top = myCollectionCell.topAnchor.constraint(equalTo: topAnchor, constant: 0)
       let bottom = myCollectionCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
       NSLayoutConstraint.activate([left, right, top, bottom])
    }
    
    
    func configure(with imageUrls: String) {
        if let url = URL(string: imageUrls) {
            URLSession.shared.dataTask(with: url) {data, _ , _ in
                if let data = data {
                    DispatchQueue.main.async {
                        self.myCollectionCell.image = UIImage(data: data)
                    }
                }
            }
        }
    }
}



