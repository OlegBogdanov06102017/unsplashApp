//
//  IntroView.swift
//  unsplashApp
//
//  Created by Oleg Bogdanov on 2023-06-14.
//

import Foundation
import UIKit


final class IntroView: UIView {
    let authorize = ApiManager()
    
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
        label.textAlignment = .left //в фигме написано что размещение по центру фрейма но выглядит убого
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
        //MARK: ImageView
        image.translatesAutoresizingMaskIntoConstraints = false
        let leftConstForImageView = image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0)
        let rightConstForImageView = image.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
        let bottomConstForImageView = image.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        let topConstForImageView = image.topAnchor.constraint(equalTo: topAnchor, constant: 0)
        NSLayoutConstraint.activate([leftConstForImageView, rightConstForImageView,bottomConstForImageView,topConstForImageView])
        //MARK: Explore Unspalsh photos
        let leftConst = exploreUnspalshPhotoText.leftAnchor.constraint(equalTo: leftAnchor, constant: 24)
        let rightConst = exploreUnspalshPhotoText.rightAnchor.constraint(equalTo: rightAnchor, constant: -10)
        let topConst = exploreUnspalshPhotoText.topAnchor.constraint(equalTo: topAnchor, constant: 292)
        NSLayoutConstraint.activate([leftConst, rightConst, topConst])
        
        //MARK: The source of freely-usable images. Powered by creators everywhere.
        let leftSourceConst = sourceText.leftAnchor.constraint(equalTo: leftAnchor, constant: 24)
        let rightSourceConst = sourceText.rightAnchor.constraint(equalTo: rightAnchor, constant: -24)
        let constBetweenTwoSubViews = sourceText.topAnchor.constraint(equalTo: exploreUnspalshPhotoText.bottomAnchor, constant: 16) //попробовал сделать констрейнт между двумя лэйблами. не уверене что верно как проверить в дебагере
        NSLayoutConstraint.activate([leftSourceConst, rightSourceConst, constBetweenTwoSubViews])
        
        //MARK: Кнопка Log in
        let leftLogInConst = logInButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16)
        let rightSLogInConst = logInButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16)
        let constBetweenLogInSource = logInButton.topAnchor.constraint(equalTo: sourceText.bottomAnchor, constant: 150)
        let constBetweenLogInExplore = logInButton.bottomAnchor.constraint(equalTo: sourceText.bottomAnchor, constant: 206)// от низа source text до низа loginbutton
        NSLayoutConstraint.activate([leftLogInConst, rightSLogInConst, constBetweenLogInSource, constBetweenLogInExplore])
        
        //MARK: Explore photos button
        let leftExploreButtonConst = explorePhotosButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16)
        let rightExploreButtonConst = explorePhotosButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16)
        let explorePhotosToLogIn = explorePhotosButton.bottomAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 66) // от низа loginbutton до низа explore photos
        let constBetweenLogInExploreSource = explorePhotosButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 10)
        NSLayoutConstraint.activate([leftExploreButtonConst, rightExploreButtonConst, constBetweenLogInExploreSource, explorePhotosToLogIn])
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
