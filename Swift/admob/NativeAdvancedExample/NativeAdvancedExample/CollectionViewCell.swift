//
//  CollectionViewCell.swift
//  NativeAdvancedExample
//
//  Created by Vincent Douant on 01/02/2021.
//  Copyright © 2021 Google. All rights reserved.
//

import UIKit
import GoogleMobileAds

class CollectionViewCell : UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

    func configure(_ adLoader: AdHolder) {
        adLoader.load { [weak self] (view) in
            self?.setAdView(view)
        }
    }

    func setAdView(_ nativeAdView: GADUnifiedNativeAdView) {
        nativeAdView.removeFromSuperview()
        nativeAdView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nativeAdView)
        nativeAdView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        nativeAdView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        nativeAdView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        nativeAdView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
    }
}
