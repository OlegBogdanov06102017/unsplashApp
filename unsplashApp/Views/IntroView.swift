//
//  IntroView.swift
//  unsplashApp
//
//  Created by Oleg Bogdanov on 2023-06-14.
//

import Foundation
import UIKit
import SnapKit

final class IntroView: UIView {
    private let authorize = ApiManager()
    
    //MARK: Свойства класса
    let image: UIImageView = {
        let imageBack = UIImage(named: "image 1")
        let imageView = UIImageView(image: imageBack)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let exploreUnspalshPhotoText: UILabel = {
        let label = UILabel()
        //MARK: Explore Unspalsh photos
        label.font = UIFont.boldSystemFont(ofSize: 48)
        label.text = "Explore Unsplash photos"
        label.textColor = .white
        label.numberOfLines = 0 // или 3? // 0 это когда лэйбл сам подстраивается под количество строк
        label.textAlignment = .left//в фигме написано что размещение по центру фрейма но выглядит убого
        //label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let sourceText: UILabel = {
        let label = UILabel()
        //MARK: The source of freely-usable images. Powered by creators everywhere.
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "The source of freely-usable images. Powered by creators everywhere."
        label.textColor = .white
        label.numberOfLines = 2
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var logInButton: UIButton = {
        let viewController = ApiManager()
        let button = UIButton(type: .system)
        //MARK: Кнопка Log in
        button.setTitle("Log in", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.titleLabel?.tintColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        button.backgroundColor = UIColor(red: 255/255 , green: 255/255, blue: 255/255, alpha: 1)
        button.layer.cornerRadius = 5
        button.titleLabel?.textAlignment = .center
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let explorePhotosButton: UIButton = {
        //MARK: Explore photos button
        let button = UIButton(type: .system)
        button.setTitle("Explore photos", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.titleLabel?.tintColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        button.layer.borderWidth = 2  // установил размер ширины для границы
        button.layer.borderColor = UIColor.white.cgColor
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 5
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        addSubview(image)
        addSubview(exploreUnspalshPhotoText)
        addSubview(sourceText)
        addSubview(logInButton)
        addSubview(explorePhotosButton)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupConstraints() {
        // MARK: ImageView
        let leftConstForImageView = image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0)
        let rightConstForImageView = image.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
        let bottomConstForImageView = image.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        let topConstForImageView = image.topAnchor.constraint(equalTo: topAnchor, constant: 0)
        
        NSLayoutConstraint.activate([
            leftConstForImageView,
            rightConstForImageView,
            bottomConstForImageView,
            topConstForImageView
        ])
        
        // MARK: Explore Unspalsh photos
        exploreUnspalshPhotoText.snp.makeConstraints { make in
            make.left.equalTo(image.snp.left).offset(24)
            make.right.equalTo(image.snp.right).offset(-10)
            make.top.equalTo(image.snp.top).offset(290)
        }
        
        // MARK: The source of freely-usable images. Powered by creators everywhere.
        sourceText.snp.makeConstraints { make in
            make.left.equalTo(image.snp.left).offset(24)
            make.right.equalTo(image.snp.right).offset(-24)
            make.top.equalTo(exploreUnspalshPhotoText.snp.bottom).offset(16)
        }
                
        // MARK: Кнопка Log in
        
        logInButton.snp.makeConstraints { make in
            make.left.equalTo(image.snp.left).offset(16)
            make.right.equalTo(image.snp.right).offset(-16)
            make.top.equalTo(sourceText.snp.bottom).offset(150)
            make.bottom.equalTo(sourceText.snp.bottom).offset(206)
        }
        
        //MARK: Explore photos button
        
        explorePhotosButton.snp.makeConstraints { make in
            make.left.equalTo(image.snp.left).offset(16)
            make.right.equalTo(image.snp.right).offset(-16)
            make.bottom.equalTo(logInButton.snp.bottom).offset(66) // от низа loginbutton до низа explore photos
            make.top.equalTo(logInButton.snp.bottom).offset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func moveToAuthSession() {
        logInButton.addTarget(authorize, action: #selector(ApiManager.authorize), for: .touchUpInside)
    }
    func tapExploreButton() {
        let intro = IntroViewController()
        explorePhotosButton.addTarget(intro, action: #selector(intro.moveToExplore), for: .touchUpInside)
    }
    
    
}


////MARK: Метод для создания алерт об успешной авторизации
//func successAlert() -> UIAlertController {
//    let alert = UIAlertController(title: "Success", message: "You have successfuly passed authorization", preferredStyle: .alert)
//    let action = UIAlertAction(title: "OK", style: .default)
//    alert.addAction(action)
////        present(alert, animated: true)
//    return alert
//}
////MARK: Метод для уже успешной авторизации
//func alreadySuccess() -> UIAlertController {
//    let alert = UIAlertController(title: "Success", message: "You have already authorized", preferredStyle: .alert)
//    let action = UIAlertAction(title: "OK", style: .default)
//    alert.addAction(action)
////        present(alert, animated: true)
//    return alert
//}
