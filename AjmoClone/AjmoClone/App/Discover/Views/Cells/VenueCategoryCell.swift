//
//  VenueCategoryCell.swift
//  AjmoClone
//
//  Created by Luka Šarčević on 13.01.2021..
//

import UIKit

class VenueCategoryCell: UICollectionViewCell {
  typealias ViewModel = (title: String, imageUrl: URL)
  private lazy var containerView = UIView()
  private lazy var venueImageView = UIImageView()
  private lazy var titleLabel = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension VenueCategoryCell {
  func update(_ viewModel: ViewModel) {
    titleLabel.text = viewModel.title
    venueImageView.kf.setImage(with: viewModel.imageUrl, options: [.transition(.fade(0.25))])
  }
}

// MARK: - Private Methods
private extension VenueCategoryCell {
  func setupViews() {
    setupView()
    setupContainerView()
    setupVenueImageView()
    setupTitleLabel()
  }
  
  func setupView() {
    contentView.backgroundColor = .clear
  }
  
  func setupContainerView() {
    contentView.addSubview(containerView)
    containerView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    containerView.layer.cornerRadius = 8
    containerView.clipsToBounds = true
  }
  
  func setupVenueImageView() {
    containerView.addSubview(venueImageView)
    venueImageView.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalToSuperview().inset(5)
    }
    titleLabel.font = .systemFont(ofSize: 12)
  }
  
  func setupTitleLabel() {
    containerView.addSubview(titleLabel)
    titleLabel.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.bottom.equalToSuperview().inset(5)
    }
    titleLabel.font = .systemFont(ofSize: 12)
  }
}
