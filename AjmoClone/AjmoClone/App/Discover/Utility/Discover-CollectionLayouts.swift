//
//  Discover-CollectionLayouts.swift
//  AjmoClone
//
//  Created by Luka Šarčević on 14.01.2021..
//

import UIKit

protocol DiscoverLayoutSectionDelegate: class {
  func layoutSectionType(for sectionIndex: Int) -> DiscoverDataSourceSection?
}

class DiscoverLayout {
  weak var layoutDelegate: DiscoverLayoutSectionDelegate? {
    didSet { layout.invalidateLayout() }
  }
  private(set) lazy var layout = generateDiscoverLayout()
}

private extension DiscoverLayout {
  func generateDiscoverLayout() -> UICollectionViewLayout {
    UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment -> NSCollectionLayoutSection? in
      
      guard let sectionType = self?.layoutDelegate?.layoutSectionType(for: sectionIndex) else {
        return nil
      }
      
      switch sectionType {
      case .promo: return self?.generatePromoLayout()
      case .news: return self?.generateNewsLayout()
      case .venue: return self?.generateVenuesLayout()
      case .venueTag(let items): return self?.generateTagsLayout(with: items.count)
      case .venueCategory(_, let items): return self?.generateTagsLayout(with: items.count)
      }
    }
  }
  
  func generatePromoLayout() -> NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                          heightDimension: .fractionalWidth(2/3))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitem: item, count: 1)
    group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
    
    let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                            heightDimension: .estimated(30))
    
    let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
      layoutSize: headerSize,
      elementKind: UICollectionView.elementKindSectionHeader,
      alignment: .top)
    
    let section = NSCollectionLayoutSection(group: group)
    section.boundarySupplementaryItems = [sectionHeader]
    section.orthogonalScrollingBehavior = .groupPaging
    section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 0)
    
    return section
  }
  
  func generateNewsLayout() -> NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85),
                                          heightDimension: .fractionalWidth(1.2))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitem: item, count: 1)
    group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
    
    let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                            heightDimension: .estimated(30))
    
    let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
      layoutSize: headerSize,
      elementKind: UICollectionView.elementKindSectionHeader,
      alignment: .top)
    
    let section = NSCollectionLayoutSection(group: group)
    section.boundarySupplementaryItems = [sectionHeader]
    section.orthogonalScrollingBehavior = .groupPagingCentered
    
    return section
  }
  
  func generateVenuesLayout() -> NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                          heightDimension: .fractionalWidth(0.9))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitem: item, count: 1)
    group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
    
    let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                            heightDimension: .estimated(30))
    
    let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
      layoutSize: headerSize,
      elementKind: UICollectionView.elementKindSectionHeader,
      alignment: .top)
    
    let section = NSCollectionLayoutSection(group: group)
    section.boundarySupplementaryItems = [sectionHeader]
    section.orthogonalScrollingBehavior = .groupPagingCentered
    
    return section
  }
  
  func generateTagsLayout(with itemsCount: Int) -> NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                          heightDimension: .fractionalHeight(1.0))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)

    let groupFractionalWidth = 1.0
    let groupFractionalHeight: Float = 0.2
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(CGFloat(groupFractionalWidth)),
      heightDimension: .fractionalWidth(CGFloat(groupFractionalHeight)))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: min(itemsCount, 3))
    group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
    
    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 0)
    
    return section
  }
}
