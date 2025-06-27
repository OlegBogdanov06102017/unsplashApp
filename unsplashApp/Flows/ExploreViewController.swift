//
//  ExploreViewController.swift
//  unsplashApp
//
//  Created by Oleg Bogdanov on 2023-06-24.
//

import UIKit
import SnapKit

final class ExploreViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    
    private var items: [Items]!
    
    enum SectionKind: Int, CaseIterable {
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
        view.addSubview(collectionView)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ExploreCollectionViewCell.reuseID)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: PhotoCell.reuseID)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setUpConstraints() {
        collectionView.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).offset(0)
            make.right.equalTo(view.snp.right).offset(0)
            make.top.equalTo(view.snp.top).offset(0)
            make.bottom.equalTo(view.snp.bottom).offset(0)
        }
    }
    
    private func makeLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            guard let section = SectionKind(rawValue: sectionIndex) else { return nil }
            
            switch section {
            case .exploreSection:
                return self.createExploreSection()
            case .newSection:
                return self.createNewSection()
            }
        }
    }
    
    private func createExploreSection() -> NSCollectionLayoutSection {
        // section -> group -> item -> size
        // MARK: - item size , with Explore text
        
        let topItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(26)
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
        topItem.contentInsets = NSDirectionalEdgeInsets(top: 18, leading: 16, bottom: 18, trailing: 313)
        
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
        section.orthogonalScrollingBehavior = .continuous
        
        return section
        
    }
}

extension ExploreViewController {
    func hideNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberSection = SectionKind(rawValue: section)!
        switch numberSection {
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
        case .exploreSection:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExploreCollectionViewCell.reuseID, for: indexPath) as? ExploreCollectionViewCell else {return UICollectionViewCell() }
            cell.backgroundColor = .blue
            return cell
        case .newSection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseID, for: indexPath) as! PhotoCell
            cell.backgroundColor = .green
            cell.layer.cornerRadius = 10
            cell.layer.borderWidth = 1
            return cell
        }
        
    }

}


