import UIKit
import SnapKit


class PhotoCell: UICollectionViewCell {
    
    static let reuseID = "afterCollection"
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    //    setupConst()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        addSubview(imageViewCell)
    }
    
    lazy var imageViewCell: UIImageView = {
        let image = UIImageView ()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    
//    func setupConst() {
//        
//        contentView.addSubview(imageViewCell)
//        
//        NSLayoutConstraint.activate([
//            imageViewCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
//            imageViewCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
//            imageViewCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
//            imageViewCell.heightAnchor.constraint(equalToConstant: 250),
//            imageViewCell.widthAnchor.constraint(equalToConstant: 375)
//        ])
//    }
}
