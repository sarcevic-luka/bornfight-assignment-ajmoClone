//
//  VenueCell.swift
//  AjmoClone
//
//  Created by Luka Šarčević on 13.01.2021..
//

import UIKit
import Kingfisher

class VenueCell: UICollectionViewCell {
  typealias ViewModel = (title: String, imageUrl: URL?, description: String, distance: String)
  private lazy var containerView = UIView()
  private lazy var venueImageView = UIImageView()
  private lazy var titleLabel = UILabel()
  private lazy var descriptionLabel = UILabel()
  private lazy var distanceLabel = UILabel()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }

  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension VenueCell {
  func update(_ viewModel: ViewModel) {
    if let venuePictureUrl = viewModel.imageUrl {
      venueImageView.kf.setImage(with: venuePictureUrl, options: [.transition(.fade(0.25))])
    }
    titleLabel.text = viewModel.title
    descriptionLabel.text = viewModel.description
    distanceLabel.text = viewModel.distance
  }
}

// MARK: - Private Methods
private extension VenueCell {
  func setupViews() {
    setupView()
    setupContainerView()
    setupVenueImageView()
    setupTitleLabel()
    setupDescriptionLabel()
    setupDistanceLabel()
  }

  func setupView() {
    contentView.backgroundColor = .clear
  }

  func setupContainerView() {
    contentView.addSubview(containerView)
    containerView.snp.makeConstraints {
      $0.edges.equalToSuperview().inset(10)
    }
    containerView.layer.borderWidth = 1
    containerView.layer.borderColor = UIColor.darkGray.cgColor
    containerView.layer.cornerRadius = 12
    containerView.clipsToBounds = true
    containerView.backgroundColor = .white
  }

  func setupVenueImageView() {
    containerView.addSubview(venueImageView)
    venueImageView.snp.makeConstraints {
      $0.leading.top.trailing.equalToSuperview()
      $0.height.equalTo(containerView.snp.width).multipliedBy(0.6)
    }
    venueImageView.image = ImageAssets.Images.landscapePlaceholder.image
  }

  func setupTitleLabel() {
    containerView.addSubview(titleLabel)
    titleLabel.snp.makeConstraints {
      $0.top.equalTo(venueImageView.snp.bottom).inset(10)
      $0.leading.trailing.equalToSuperview().inset(12)
    }
    titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
    titleLabel.textColor = .black
  }

  func setupDescriptionLabel() {
    containerView.addSubview(descriptionLabel)
    descriptionLabel.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).inset(8)
      $0.leading.bottom.equalToSuperview().inset(12)
    }
    descriptionLabel.font = .systemFont(ofSize: 12)
    descriptionLabel.textColor = .darkGray
  }

  func setupDistanceLabel() {
    containerView.addSubview(distanceLabel)
    distanceLabel.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).inset(8)
      $0.trailing.bottom.equalToSuperview().inset(12)
    }
    distanceLabel.font = .systemFont(ofSize: 12)
    distanceLabel.textColor = .darkGray
  }
}
