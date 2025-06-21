//
//  ExploreTableView.swift
//  unsplashApp
//
//  Created by Oleg Bogdanov on 2023-06-20.
//

import UIKit

class ExploreTableView: UITableView  {
    
    let exploreTableViewID = "cell"
   
    
    
    let myTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        addSubview(myTableView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
      /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
