import UIKit
import SnapKit
import Kingfisher

final class ExploreViewController: UIViewController {
    private var collectionView: UICollectionView!
    private let networkManager = ApiManager()
    private var collections: [Collections] = []
    private var topics: [Topic] = []
    private var allphotosBySlug: [TopicPhoto] = []
    
    
    enum SectionKind: Int, CaseIterable {
        case headerSection
        case exploreSection
        case newSection
    }
    
    
    
    override func loadView() {
        super.loadView()
        hideNavigationBar()
        setUpCollectionView()
        setUpConstraints()
        loadTopics()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setUpCollectionView() {
        collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: makeLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        
        collectionView.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCell.reuseID)
        collectionView.register(SectionHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderCell.reuseID)
        collectionView.register(ExploreCollectionViewCell.self, forCellWithReuseIdentifier: ExploreCollectionViewCell.reuseID)
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseID)
        
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }
    
    private func setUpConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func makeLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            guard let section = SectionKind(rawValue: sectionIndex) else { return nil }
            
            switch section {
            case .headerSection:
                return self.createHeaderSection()
            case .exploreSection:
                return self.createExploreSection()
            case .newSection:
                return self.createNewSection()
            }
        }
    }
    
    //MARK: HEADER
    
    private func createHeaderSection() -> NSCollectionLayoutSection {
        
        //MARK: Size for header section
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.3)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        //MARK: Group for header section
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.3)
        )
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        //MARK: Section for header section
        
        let section = NSCollectionLayoutSection(group: group)
        
        //MARK: Header for header section
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(250)
        )
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    //MARK: EXPLORE
    
    private func createExploreSection() -> NSCollectionLayoutSection {
        
        // MARK: - item size , with collectiobView
        
        let leadingItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let leadingItem = NSCollectionLayoutItem(layoutSize: leadingItemSize)
        leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16)
        
        
        
        // MARK: - group size
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.8),
            heightDimension: .fractionalHeight(0.16)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            repeatingSubitem: leadingItem,
            count: 1
        )
        
        // MARK: - section size
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        //MARK: Header for Explore section
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.04)
        )
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]
        
        return section
    }
     
    //MARK: NEW
    
    private func createNewSection() -> NSCollectionLayoutSection {
        // section -> group -> item -> size
    
        // MARK: - item size , with collectiobView
        
        let leadingItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(0.3)
        )
        
        let leadingItem = NSCollectionLayoutItem(layoutSize: leadingItemSize)
        leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 18, leading: 0, bottom: 0, trailing: 0)
        
        // MARK: - group size
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            repeatingSubitem: leadingItem,
            count: 3
        )
        
        // MARK: - section size
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        //MARK: Header for NEW Section
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.04)
        )
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    private func loadTopics() {
        networkManager.getResponseTopic { topic, error in
            guard let topic = topic else { return }
            DispatchQueue.main.async {
                self.topics = topic
                self.fetchPhotos(topics: topic)
                self.collectionView.reloadData()
            }
        }
    }
    
    func fetchPhotos(topics: [Topic]) {
        for topic in topics {
            networkManager.getResponsePhotoBySlug(slug: topic.slug) { photos, error in
                if let firstPhoto = photos?.first {
                    print("Тема: \(topic.title), Фото: \(firstPhoto.urls?.small)")
                    DispatchQueue.main.async {
                        self.allphotosBySlug = photos!
                    }
                }
            }
        }
    }
    
}

extension ExploreViewController {
    func hideNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension ExploreViewController: UICollectionViewDataSource  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberSection = SectionKind(rawValue: section)!
        switch numberSection {
        case .headerSection:
            return 0
        case .exploreSection:
            return topics.count
        case .newSection:
            return 3
            
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        SectionKind.allCases.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let numberSection = SectionKind(rawValue: indexPath.section)!
        switch numberSection {
        case .headerSection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderCell.reuseID, for: indexPath)
            return cell
        case .exploreSection:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExploreCollectionViewCell.reuseID, for: indexPath) as? ExploreCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let item = topics[indexPath.item]
            if indexPath.item < allphotosBySlug.count {
                let imageItem = allphotosBySlug[indexPath.item]
                cell.configurePhoto(with: imageItem.urls?.small)
            } else {
                cell.configurePhoto(with: nil)
            }
            cell.cellTitle.text = item.title
            return cell
        case .newSection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseID, for: indexPath)
            cell.backgroundColor = .green
            cell.layer.borderWidth = 1
            return cell
        }
        
    }
    // MARK: Headers
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind  == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }
        
        switch indexPath.section {
        case 0:
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderCell.reuseID,
                for: indexPath
            ) as! HeaderCell
            networkManager.getRequestRandomPhoto { photo, error in
                guard let urlForPhoto = photo?.urls?.regular,
                      let urlPhoto = URL(string: urlForPhoto) else {
                    print("\(error?.localizedDescription)")
                    return
                }
                
                guard let urlForUser = photo?.user?.name else {
                    print("\(error?.localizedDescription)")
                    return
                }
                print(urlForPhoto)
                print(urlForUser)
                DispatchQueue.main.async {
                    sectionHeader.headerImageView.kf.setImage(with: urlPhoto)
                    sectionHeader.configureSubTitleText(label: sectionHeader.subTitileLabel, text: urlForUser)
                }
            }
            return sectionHeader
            
        case 1:
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SectionHeaderCell.reuseID,
                for: indexPath
            ) as! SectionHeaderCell
            sectionHeader.configure(title: "Explore")
            return sectionHeader
            
        case 2:
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SectionHeaderCell.reuseID,
                for: indexPath
            ) as! SectionHeaderCell
            sectionHeader.configure(title: "New")
            return sectionHeader
        default:
            return UICollectionReusableView()
        }
    }
}




