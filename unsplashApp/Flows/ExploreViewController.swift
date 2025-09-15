import UIKit
import SnapKit
import Kingfisher

final class ExploreViewController: UIViewController {
    private var collectionView: UICollectionView!
    private let networkManager = ApiManager()
    private var timer: Timer?
    private var randomPhotoCount = 0
    private var latestPhoto: [Photo] = []
    //MARK: Have to comment func loadTopics() due to 50 request per 1 hour
  //  private var topics: [TopicForCollectionView] = []
    private var mockDataTopics = mockTopics
    private let exploreViewModel: ExploreViewModel
    private let activityIndicator = UIActivityIndicatorView()
    
    init(viewModel: ExploreViewModel) {
        self.exploreViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    enum SectionKind: Int, CaseIterable {
        case headerSection
        case exploreSection
        case newSection
    }
    
    
    
    override func loadView() {
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        setUpCollectionView()
        setUpConstraints()
        setAnimationForHeader()
        exploreViewModel.loadRandomPhoto()
        //MARK: Have to comment func loadTopics() due to 50 request per 1 hour
     //   exploreViewModel.loadTopics()
        bindExploreViewModelForPhotos()
        exploreViewModel.loadLatestPhoto()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startTimer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate()
        timer = nil
        
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
    //MARK: Have to comment func loadTopics() due to 50 request per 1 hour
//    private func bindExploreViewModel() {
//        exploreViewModel.onTopicUpdated = { [weak self] topics in
//            print("🔄 onTopicUpdated: \(topics.count) topics")
//            self?.topics = topics
//            self?.collectionView.reloadData()
//        }
//    }
    
    private func bindExploreViewModelForPhotos() {
        exploreViewModel.onDataUpdatedPhoto = { [weak self] in
            self?.collectionView.reloadData()
        }
        
        exploreViewModel.onError = { [weak self] error in
            print("Ошибка: \(error)")
        }
        
        exploreViewModel.onLoadingStateChange = { [weak self] isLoading in
            if isLoading {
                self?.activityIndicator.startAnimating()
            } else {
                self?.activityIndicator.stopAnimating()
            }
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { [weak self] _ in
                self?.exploreViewModel.loadRandomPhoto()
            }
    }
    
    private func setAnimationForHeader() {
        exploreViewModel.onRandomPhotoUpdated = { [weak self] urlPhoto, owner in
            guard let self = self else { return }
            self.randomPhotoCount += 1
            
            let headerIndexPath = IndexPath(item: 0, section: 0)
            if let header = self.collectionView.supplementaryView(
                forElementKind: UICollectionView.elementKindSectionHeader,
                at: headerIndexPath
            ) as? HeaderCell {
                if self.randomPhotoCount <= 3 {
                    header.updateImageFadeAnimation(with: urlPhoto)
                } else {
                    header.headerImageView.kf.setImage(with: urlPhoto)
                }
                
                header.configureSubTitleText(label: header.subTitleLabel, text: owner)
            }
            if self.randomPhotoCount >= 3 {
                self.timer?.invalidate()
                self.timer = nil
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
            return mockDataTopics.count
        case .newSection:
            return latestPhoto.count
            
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
            let item = mockDataTopics[indexPath.item]
            cell.configure(imageURL: item.imageUrl, title: item.title)
            return cell
        case .newSection:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseID, for: indexPath)
                    as? PhotoCell else {
                return UICollectionViewCell()
            }
            let photo = latestPhoto[indexPath.item]
            cell.configure(imageURL: photo.urls.regular)
            
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
