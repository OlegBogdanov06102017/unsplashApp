//
//  HeaderRandomImage.swift
//  unsplashApp
//
//  Created by Oleg Bogdanov on 2023-06-22.
//

import UIKit

class HeaderCell: UITableViewHeaderFooterView {
    
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var headerImageView: UIImageView = {
        let image = UIImageView ()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    
    func configureContents() {
       
        contentView.addSubview(headerImageView)
        
        NSLayoutConstraint.activate([
            headerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            headerImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            headerImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            headerImageView.heightAnchor.constraint(equalToConstant: 250),
            headerImageView.widthAnchor.constraint(equalToConstant: 390)
                
                    // Center the label vertically, and use it to fill the remaining
                    // space in the header view.
                ])
        
        
        /*
         // Only override draw() if you perform custom drawing.
         // An empty implementation adversely affects performance during animation.
         override func draw(_ rect: CGRect) {
         // Drawing code
         }
         */
        
    }
}
