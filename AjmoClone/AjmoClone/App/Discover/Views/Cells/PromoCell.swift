//
//  PromoCell.swift
//  AjmoClone
//
//  Created by Luka Šarčević on 12.01.2021..
//

import UIKit
import Kingfisher

class PromoCell: UICollectionViewCell {
  typealias ViewModel = (highlightedText: String, imageUrl: URL?, title: String, caption: String)
  private lazy var promoImageView = UIImageView()
  private lazy var highlightedView = UIView()
  private lazy var highlightedTextLabel = UILabel()
  private lazy var highlightedIconImageView = UIImageView()
  private lazy var titleLabel = UILabel()
  private lazy var captionLabel = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension PromoCell {
  func update(_ viewModel: ViewModel) {
    highlightedTextLabel.text = viewModel.highlightedText
    if let promoPictureUrl = viewModel.imageUrl {
      promoImageView.kf.setImage(with: promoPictureUrl, options: [.transition(.fade(0.25))])
    }
    titleLabel.text = viewModel.title
    captionLabel.text = viewModel.caption
  }
}

// MARK: - Private Methods
private extension PromoCell {
  func setupViews() {
    setupView()
    setupPromoImageView()
    setupHighlightedView()
    setupHighlightedImageView()
    setupHighlightedTextLabel()
    setupCaptionLabel()
    setupTitleLabel()
  }
  
  func setupView() {
    contentView.backgroundColor = .clear
  }
  
  func setupPromoImageView() {
    contentView.addSubview(promoImageView)
    promoImageView.snp.makeConstraints {
      $0.edges.equalToSuperview().inset(24)
    }
    promoImageView.layer.cornerRadius = 5
    promoImageView.clipsToBounds = false
  }
  
  func setupHighlightedView() {
    contentView.addSubview(highlightedView)
    highlightedView.snp.makeConstraints {
      $0.top.equalToSuperview().inset(12)
      $0.height.equalTo(25)
      $0.edges.equalToSuperview().inset(24)
    }
    highlightedView.layer.cornerRadius = 2
    highlightedView.clipsToBounds = true
    promoImageView.backgroundColor = .blue
  }
  
  func setupHighlightedImageView() {
    highlightedView.addSubview(highlightedIconImageView)
    highlightedIconImageView.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(4)
      $0.size.equalTo(18)
      $0.centerY.equalToSuperview()
    }
    highlightedIconImageView.image = ImageAssets.Icons.chalice.image
    highlightedIconImageView.contentMode = .scaleAspectFit
    highlightedIconImageView.tintColor = .white
  }
  
  func setupHighlightedTextLabel() {
    highlightedView.addSubview(highlightedTextLabel)
    highlightedTextLabel.snp.makeConstraints {
      $0.leading.equalTo(highlightedIconImageView.snp.trailing).inset(5)
      $0.centerY.equalToSuperview()
    }
    highlightedTextLabel.textColor = .white
  }
  
  func setupCaptionLabel() {
    promoImageView.addSubview(captionLabel)
    captionLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(8)
      $0.bottom.equalToSuperview().inset(8)
    }
    captionLabel.textColor = .white
    captionLabel.font = .systemFont(ofSize: 16)
  }
  
  func setupTitleLabel() {
    promoImageView.addSubview(titleLabel)
    titleLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(8)
      $0.bottom.equalTo(captionLabel.snp.top).inset(4)
    }
    captionLabel.textColor = .white
    captionLabel.font = .systemFont(ofSize: 20)
  }
}
