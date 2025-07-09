import UIKit
import SnapKit

class HeaderCell: UICollectionReusableView {
    
    static let reuseID = "Header Cell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        makeConstaints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let headerImageView: UIImageView = {
        let image = UIImageView ()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.backgroundColor = .cyan
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos for Everyone"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    
    let subTitileLabel: UILabel = {
        let label = UILabel()
        label.text = "Photo by somebody"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .white
        return label
    }()
    
    private func setupView() {
        addSubview(headerImageView)
        addSubview(titleLabel)
        addSubview(subTitileLabel)
    }
    
    private func makeConstaints() {
        headerImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        subTitileLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(114)
            make.right.equalToSuperview().offset(-115)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
}
