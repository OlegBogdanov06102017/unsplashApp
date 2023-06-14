//
//  IntroView.swift
//  unsplashApp
//
//  Created by Oleg Bogdanov on 2023-06-14.
//

import Foundation
import UIKit


class IntroView: UIView {
    
    
    let exploreUnspalshPhotoText: UILabel = {
        let label = UILabel()
        //MARK: Explore Unspalsh photos
        let exploreFrame = CGRect(x: 24, y: 292 , width: 341, height: 186)
        label.frame = exploreFrame
        label.font = UIFont.boldSystemFont(ofSize: 48)
        label.text = "Explore Unsplash photos"
        label.textColor = .white
        label.numberOfLines = 0 // или 3? // 0 это когда лэйбл сам подстраивается под количество строк
        label.textAlignment = .left//в фигме написано что размещение по центру фрейма но выглядит убого
        return label
    }()
    let sourceText: UILabel = {
        
    }
    
    init() {
        super.init(frame: .zero)
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        addSubview(exploreUnspalshPhotoText)
    }
    func setupConstraints() {
        let leftConst = exploreUnspalshPhotoText.leftAnchor.constraint(equalTo: leftAnchor, constant: 24)
        let rightConst = exploreUnspalshPhotoText.rightAnchor.constraint(equalTo: rightAnchor, constant: 10)
        let topConst = exploreUnspalshPhotoText.topAnchor.constraint(equalTo: topAnchor, constant: 290)
        let bottomConst = exploreUnspalshPhotoText.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 336)
        NSLayoutConstraint.activate([leftConst, rightConst, topConst, bottomConst])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
