import UIKit
import SnapKit

class ExploreCollectionViewCell: UICollectionViewCell {

    static let reuseID = "ExploreSection"

    let myCollectionCell: UIImageView = {
        let imageView = UIImageView()
        //imageView.frame = CGRect(x: 0, y: 0, width: 319, height: 130)
        //imageView.backgroundColor = .blue
        imageView.layer.cornerRadius = 37
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .center
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .brown
        return imageView
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
        addSubview(myCollectionCell)
    }
    
    func makeConstraints() {
        myCollectionCell.snp.makeConstraints { make in
            make.left.equalTo(myCollectionCell.snp.left).offset(16)
            make.right.equalTo(myCollectionCell.snp.right).offset(-40)
            make.top.equalTo(myCollectionCell.snp.top).offset(-16)
        }
    }
        
}



