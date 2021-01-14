//
//  DiscoverContentView.swift
//  AjmoClone
//
//  Created Luka Šarčević on 11.01.2021..
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class DiscoverContentView: UIView {
  var refreshControlRefreshHandler: Action?
  private(set) lazy var compositionalLayout = DiscoverLayout()
  private(set) lazy var collectionView = UICollectionView(frame: .zero,
                                                          collectionViewLayout: compositionalLayout.layout)

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Private Methods
private extension DiscoverContentView {
  @objc func refreshControlValueChanged() {
    refreshControlRefreshHandler?()
  }
}

private extension DiscoverContentView {
  func setupViews() {
    setupView()
    setupCollectionView()
  }

  func setupView() {
    backgroundColor = .white
  }

  func setupCollectionView() {
    addSubview(collectionView)
    collectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    collectionView.backgroundView = UIImageView(image: ImageAssets.Images.backgroundPattern.image)
    collectionView.alwaysBounceVertical = true
    collectionView.register(NewsCell.self)
    collectionView.register(PromoCell.self)
    collectionView.register(VenueCell.self)
    collectionView.register(VenueCategoryCell.self)
    collectionView.register(VenueTagCell.self)
    collectionView.registerSupplementaryView(HeaderView.self, kind: UICollectionView.elementKindSectionHeader)
    collectionView.refreshControl = UIRefreshControl()
    collectionView.refreshControl?.addTarget(self, action: #selector(refreshControlValueChanged), for: .valueChanged)
  }
}
