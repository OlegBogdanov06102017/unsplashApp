//
//  CollectionView.swift
//  unsplashApp
//
//  Created by Oleg Bogdanov on 2023-07-05.
//
import Foundation
import UIKit
import Kingfisher

class CollectionViewTableCell: UITableViewCell {
    static let id = "Collect"
 
    private var collectionImages: [String] = []
    
    lazy var collectionViews: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 2.0
        flowLayout.minimumInteritemSpacing = 5.0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseIDCollection)
        collectionView.isScrollEnabled = true
        collectionView.alwaysBounceHorizontal = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {
        contentView.addSubview(collectionViews)
        
    }
    
    func setupConstraints() {
        collectionViews.translatesAutoresizingMaskIntoConstraints = false
        let left = collectionViews.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        let right = collectionViews.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40)
        let top = collectionViews.topAnchor.constraint(equalTo: topAnchor, constant: 16)
        let bottom = collectionViews.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        NSLayoutConstraint.activate([left, right, top, bottom])
    }
    
    //MARK: reload data
    
    func configure(with images: [String]) {
        self.collectionImages = images
        collectionViews.reloadData()
    }
}
    
    
    
    
    
    
    
    //MARK: Collection View
    
extension CollectionViewTableCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 10
            
        }
        //MARK: Выполняем запрос на получение коллекиця, в дальнейшей для добавления в коллекш вью (стурктура getResopnseCollection)
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIDCollection, for: indexPath) as? CollectionViewCell else {
                return UICollectionViewCell()
            }
//            cell.configure(with: collectionImages[indexPath.row])
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        //MARK: Размер ячейки
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 319, height: 130)
        }
        
    }
    
    

