//
//  ViewController.swift
//  unsplashApp
//
//  Created by Oleg Bogdanov on 2023-05-11.
//

import UIKit
import AuthenticationServices
import Security
import SnapKit




final class IntroViewController: UIViewController {
    
    private let introview = IntroView()
    private var authorizeUrl = "https://unsplash.com/oauth/authorize"
    private var authTokenUrl = "https://unsplash.com/oauth/token"
    weak var delegate: SendAlertsToIntroViewController?
    private var showAlert = false
    
    
    
    
    
    //MARK: Подгружаем элементы
    override func loadView() {
        super.loadView()
        introview.moveToAuthSession()
        introview.tapExploreButton()
        configure()
//        let leftConstForImageView = introview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
//        let rightConstForImageView = introview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
//        let bottomConstForImageView = introview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
//        let topConstForImageView = introview.topAnchor.constraint(equalTo: view.topAnchor, constant: 0)
//        NSLayoutConstraint.activate([leftConstForImageView, rightConstForImageView,bottomConstForImageView,topConstForImageView])
        delegate?.sentSuccessAlert()
      
}
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK: функция для перехода на ExploreViewController
     @objc func moveToExplore () {
        let exploreVC = ExploreViewController()
       self.navigationController?.pushViewController(exploreVC, animated: true)
        //self.present(exploreVC, animated: true)
 }
    
    private func configure() {
        view.addSubview(introview)
        introview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
  
}

extension IntroViewController: SendAlertsToIntroViewController {
    func sentSuccessAlert() {
        show(self, sender: UIButton?.self)
        
    }
    
    func sentDuplicateToken() {
        show(self, sender: UIButton?.self)
    }
    
    
}






