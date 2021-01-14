//
//  NewsCell.swift
//  AjmoClone
//
//  Created by Luka Šarčević on 13.01.2021..
//

import UIKit
import Kingfisher

class NewsCell: UICollectionViewCell {
  typealias ViewModel = (title: String, imageUrl: URL?, description: String?, createdAt: TimeInterval)
  private lazy var containerView = UIView()
  private lazy var newsImageView = UIImageView()
  private lazy var titleLabel = UILabel()
  private lazy var descriptionLabel = UILabel()
  private lazy var typeLabel = UILabel()
  private lazy var publishedLabel = UILabel()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension NewsCell {
  func update(_ viewModel: ViewModel) {
    if let newsPictureUrl = viewModel.imageUrl {
      newsImageView.kf.setImage(with: newsPictureUrl, options: [.transition(.fade(0.25))])
    } else {
      newsImageView.image = ImageAssets.Images.landscapePlaceholder.image
    }
    titleLabel.text = viewModel.title
    descriptionLabel.text = viewModel.description ?? ""
    // Hardcoded, but left open to extending ViewModel - it looks like it shouldn't be fixed
    typeLabel.text = "Event"
    let startDate = Date(timeIntervalSince1970: TimeInterval(viewModel.createdAt))
    let formatedDate = TimeDateFormatter().string(from: startDate, using: .dayMonthYearDoted)
    publishedLabel.text = " - published: " + formatedDate
  }
}

// MARK: - Private Methods
private extension NewsCell {
  func setupViews() {
    setupView()
    setupContainerView()
    setupNewsImageView()
    setupTitleLabel()
    setupDescriptionLabel()
    setupTypeLabel()
    setupPublishedLabel()
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
  
  func setupNewsImageView() {
    containerView.addSubview(newsImageView)
    newsImageView.snp.makeConstraints {
      $0.leading.top.trailing.equalToSuperview()
      $0.height.equalTo(containerView.snp.width).multipliedBy(0.7)
    }
    newsImageView.image = ImageAssets.Images.landscapePlaceholder.image
  }
  
  func setupTitleLabel() {
    containerView.addSubview(titleLabel)
    titleLabel.snp.makeConstraints {
      $0.top.greaterThanOrEqualTo(newsImageView.snp.bottom)
      $0.leading.trailing.equalToSuperview().inset(12)
    }
    titleLabel.font = .systemFont(ofSize: 20, weight: .semibold)
    titleLabel.numberOfLines = 2
    titleLabel.textColor = .black
  }
  
  func setupDescriptionLabel() {
    containerView.addSubview(descriptionLabel)
    descriptionLabel.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(12)
      $0.leading.trailing.equalToSuperview().inset(12)
    }
    descriptionLabel.font = .systemFont(ofSize: 12)
    descriptionLabel.numberOfLines = 2
    descriptionLabel.textColor = .darkGray
  }
  
  func setupTypeLabel() {
    containerView.addSubview(typeLabel)
    typeLabel.snp.makeConstraints {
      $0.top.equalTo(descriptionLabel.snp.bottom).inset(-12)
      $0.leading.equalToSuperview().inset(12)
      $0.bottom.equalToSuperview().inset(12)
    }
    typeLabel.font = .systemFont(ofSize: 12)
    typeLabel.textColor = .red
  }
  
  func setupPublishedLabel() {
    containerView.addSubview(publishedLabel)
    publishedLabel.snp.makeConstraints {
      $0.top.equalTo(descriptionLabel.snp.bottom).inset(-8)
      $0.bottom.equalToSuperview().inset(12)
      $0.leading.equalTo(typeLabel.snp.trailing).inset(-4)

    }
    publishedLabel.textAlignment = .right
    publishedLabel.font = .systemFont(ofSize: 12)
    publishedLabel.textColor = .darkGray
  }
}
