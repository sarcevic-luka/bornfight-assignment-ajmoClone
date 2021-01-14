//
//  DiscoverViewController.swift
//  AjmoClone
//
//  Created Luka Šarčević on 11.01.2021..
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SnapKit

protocol DiscoverDisplayLogic: class {
  func displayDiscoveryDetails(using dataSource: DiscoverDataSource)
}

class DiscoverViewController: UIViewController {
  var presenter: DiscoverViewPresentingLogic?
  private lazy var contentView = DiscoverContentView()
  private var dataSource: DiscoverDataSource?
  
  override func loadView() {
    view = contentView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    setupNavigationBar()
    presenter?.onViewLoaded()
  }
}

// MARK: - DiscoverDisplayLogic
extension DiscoverViewController: DiscoverDisplayLogic {
  func displayDiscoveryDetails(using dataSource: DiscoverDataSource) {
    self.dataSource = dataSource
    contentView.collectionView.reloadData()
  }
}

private extension DiscoverViewController {
  func setupView() {
    setupContentView()
  }
  
  func setupContentView() {
    contentView.collectionView.dataSource = self
    contentView.collectionView.delegate = self
  }
}

// MARK: - UICollectionViewDataSource
extension DiscoverViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return dataSource?.numberOfSections() ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return dataSource?.numberOfItems(in: section) ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let item = dataSource?.item(at: indexPath) else { return UICollectionViewCell() }
    switch item {
    case .news(let newsViewModel):
      let cell = collectionView.dequeueReusableCell(NewsCell.self, at: indexPath)
      cell.update(newsViewModel)
      return cell
      
    case .promo(let promoViewModel):
      let cell = collectionView.dequeueReusableCell(PromoCell.self, at: indexPath)
      cell.update(promoViewModel)
      return cell
      
    case .venue(let venueViewModel):
      let cell = collectionView.dequeueReusableCell(VenueCell.self, at: indexPath)
      cell.update(venueViewModel)
      return cell
      
    case .venueTag(let tagViewModel):
      let cell = collectionView.dequeueReusableCell(VenueTagCell.self, at: indexPath)
      cell.update(tagViewModel)
      return cell
      
    case .venueCategory(let categoryViewModel):
      let cell = collectionView.dequeueReusableCell(VenueCategoryCell.self, at: indexPath)
      cell.update(categoryViewModel)
      return cell
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    guard let section = dataSource?.section(at: indexPath.item) else {
      return UICollectionReusableView()
    }
    switch section {
    case .news(let title, _), .venue(let title, _):
      let header = collectionView.dequeueReusableSupplementaryView(HeaderView.self, ofKind: kind, forIndexPath: indexPath)
      header.update(HeaderView.ViewModel(title, nil))
      return header
    default:
      return UICollectionReusableView()
    }
  }
}

// TODO: - UICollectionViewDelegateFlowLayout - replace 
extension DiscoverViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    if indexPath.section == 0 {
      let height: CGFloat = 266
      let insets = contentView.flowLayout.sectionInset
      return CGSize(width: collectionView.bounds.width - insets.left - insets.right, height: height)
    } else {
      let height: CGFloat = 380
      let insets = contentView.flowLayout.sectionInset
      return CGSize(width: collectionView.bounds.width - insets.left - insets.right, height: height)
    }
  }
}

private extension DiscoverViewController {
  func setupNavigationBar() {
    navigationItem.title = "Discover"
  }
}
