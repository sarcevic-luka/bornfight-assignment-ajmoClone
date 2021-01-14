//
//  DiscoverContentView.swift
//  AjmoClone
//
//  Created Luka Šarčević on 11.01.2021..
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class DiscoverContentView: UIView {
  private(set) lazy var flowLayout = UICollectionViewFlowLayout()
  private(set) lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)

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
  }
}
