import UIKit
import SnapKit

final class ExploreViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    
//    private var items: [ListItems]!
    
    private let section = MockData.shared.pageSectionData
    
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
    
    private func createExploreSection() -> NSCollectionLayoutSection {
        // section -> group -> item -> size
        
        // MARK: - item size , with Explore text
        
        let topItemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(0),
            heightDimension: .absolute(0)
        )
        
        let topItem = NSCollectionLayoutItem(layoutSize: topItemSize)
        topItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 146, trailing: 219)
        
        // MARK: - item size , with collectiobView
        
        let leadingItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.7),
            heightDimension: .fractionalHeight(1)
        )
        let leadingItem = NSCollectionLayoutItem(layoutSize: leadingItemSize)
        leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 42, leading: -16, bottom: 0, trailing: 24)
        
        // MARK: - group size
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.3)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            repeatingSubitem: leadingItem,
            count: 2
        )
        
        // MARK: - section size
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        //MARK: Header for Explore section
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.1)
        )
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]
        
        return section
    }
        
    private func createNewSection() -> NSCollectionLayoutSection {
        // section -> group -> item -> size
        
        // MARK: - item size , with New text
        
        let topItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(26)
        )
        
        let topItem = NSCollectionLayoutItem(layoutSize: topItemSize)
        topItem.contentInsets = NSDirectionalEdgeInsets(top: 18, leading: 16, bottom: 18, trailing: 16)
        
        // MARK: - item size , with collectiobView
        
        let leadingItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(0.3)
        )
        
        let leadingItem = NSCollectionLayoutItem(layoutSize: leadingItemSize)
        leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
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
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        section.orthogonalScrollingBehavior = .continuous
        
        //MARK: Header for NEW Section
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.1)
        )
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        section.boundarySupplementaryItems = [header]
        
        return section
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
            return 3
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExploreCollectionViewCell.reuseID, for: indexPath)
            cell.backgroundColor = .cyan
            return cell
        case .exploreSection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExploreCollectionViewCell.reuseID, for: indexPath)
            cell.backgroundColor = .blue
            return cell
        case .newSection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseID, for: indexPath)
            cell.backgroundColor = .green
            cell.layer.cornerRadius = 10
            cell.layer.borderWidth = 1
            return cell
        }
        
    }
    
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




