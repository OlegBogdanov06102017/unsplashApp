import UIKit
import SnapKit


class PhotoCell: UICollectionViewCell {
    
    static let reuseID = "afterCollection"
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        makeConstraints()
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
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    func configure(imageURL: String) {
        guard let url = URL(string: imageURL) else {
            imageViewCell.image = nil
            return
        }
        imageViewCell.kf.setImage(with: url)
    }
    
    private func makeConstraints() {
        imageViewCell.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
