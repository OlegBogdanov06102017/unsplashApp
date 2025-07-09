import Foundation
import UIKit
import SnapKit

final class IntroView: UIView {
    private let authorize = ApiManager()
    
    //MARK: Свойства класса
    let image: UIImageView = {
        let imageBack = UIImage(named: "image 1")
        let imageView = UIImageView(image: imageBack)
        return imageView
    }()
    
    let labelStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()
    
    let buttonStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
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
        return label
    }()
    
    let emptyView: UILabel = {
        let view = UILabel()
        view.backgroundColor = .clear
        return view
    }()
    
    var logInButton: UIButton = {
        let button = UIButton(type: .system)
        //MARK: Кнопка Log in
        button.setTitle("Log in", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.titleLabel?.tintColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        button.backgroundColor = UIColor(red: 255/255 , green: 255/255, blue: 255/255, alpha: 1)
        button.layer.cornerRadius = 5
        button.heightAnchor.constraint(equalToConstant: 56).isActive = true
        button.titleLabel?.textAlignment = .center
        button.isUserInteractionEnabled = true
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
        button.heightAnchor.constraint(equalToConstant: 56).isActive = true
        button.isUserInteractionEnabled = true
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        addSubview(image)
        self.addSubview(labelStackView)
        labelStackView.addArrangedSubview(exploreUnspalshPhotoText)
        labelStackView.addArrangedSubview(sourceText)
        addSubview(emptyView)
        bringSubviewToFront(emptyView)
        self.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(logInButton)
        buttonStackView.addArrangedSubview(explorePhotosButton)
    }
    
    func setupConstraints() {
        // MARK: ImageView
        image.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        // MARK: Label stack view
        
        labelStackView.snp.makeConstraints { make in
            make.bottom.equalTo(emptyView.snp.top)
            make.right.left.equalToSuperview().inset(24)
        }
        
        // MARK: Clear view
        
        emptyView.snp.makeConstraints { make in
            make.top.equalTo(labelStackView.snp.bottom)
            make.bottom.equalTo(buttonStackView.snp.top)
            make.height.equalTo(100)
            make.left.right.equalToSuperview()
        }
        
        // MARK: Button stack view
        
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(emptyView.snp.bottom)
            make.bottom.equalToSuperview().offset(-46)
            make.right.left.equalToSuperview().inset(16)
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
