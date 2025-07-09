import UIKit


class PhotoCell: UICollectionViewCell {
    
    static let reuseID = "afterCollection"
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setupConst()
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
    
    
    func setupConst() {
       
        contentView.addSubview(imageViewCell)
        
        NSLayoutConstraint.activate([
            imageViewCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            imageViewCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            imageViewCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            imageViewCell.heightAnchor.constraint(equalToConstant: 250),
            imageViewCell.widthAnchor.constraint(equalToConstant: 390)
                
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
    
//    func configure(with model: PhotoCellViewModel) {
//        imageViewCell.image = model.id
//    }
}
