import UIKit
import SnapKit

class HeaderCell: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var headerImageView: UIImageView = {
        let image = UIImageView ()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.backgroundColor = .cyan
        return image
    }()
    
    
    private func setupView() {
        addSubview(headerImageView)
        makeConstaintsHeaderImage()
        headerImageView.addSubview(titleLabel)
        makeConstraintsTitleLabel()
        headerImageView.addSubview(subTitileLabel)
        makeConstraintsSubTitileLabel()
    }
    
    private func makeConstaintsHeaderImage() {
        headerImageView.snp.makeConstraints { make in
            make.left.equalTo(headerImageView.snp.left).offset(0)
            make.right.equalTo(headerImageView.snp.right).offset(0)
            make.bottom.equalTo(headerImageView.snp.bottom).offset(0)
            make.top.equalTo(headerImageView.snp.top).offset(0)
        }
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos for Everyone"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private func makeConstraintsTitleLabel() {
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left).offset(48)
            make.right.equalTo(titleLabel.snp.right).offset(-46)
            make.top.equalTo(titleLabel.snp.top).offset(112)
            make.bottom.equalTo(titleLabel.snp.bottom).offset(100)
        }
    }
    
    lazy var subTitileLabel: UILabel = {
        let label = UILabel()
        label.text = "Photo by somebody"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func makeConstraintsSubTitileLabel() {
        subTitileLabel.snp.makeConstraints { make in
            make.left.equalTo(subTitileLabel.snp.left).offset(114)
            make.right.equalTo(subTitileLabel.snp.right).offset(-115)
            make.top.equalTo(subTitileLabel.snp.top).offset(220)
            make.bottom.equalTo(subTitileLabel.snp.bottom).offset(16)
        }
    }
    
}
