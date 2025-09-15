import UIKit
import SnapKit

class ExploreCollectionViewCell: UICollectionViewCell {

    static let reuseID = "ExploreSection"

    let myCollectionCell: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    let cellTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.numberOfLines = 1
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        contentView.addSubview(myCollectionCell)
        contentView.addSubview(cellTitle)
    }
    
    func makeConstraints() {
        myCollectionCell.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        cellTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    func configure(imageURL: String, title: String) {
        guard let url = URL(string: imageURL) else {
            myCollectionCell.image = nil
            return
        }
        myCollectionCell.kf.setImage(with: url)
        cellTitle.text = title
    }
}



