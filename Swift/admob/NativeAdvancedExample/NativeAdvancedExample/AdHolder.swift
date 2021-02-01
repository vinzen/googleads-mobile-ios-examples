//
//  AdHolder.swift
//  NativeAdvancedExample
//
//  Created by Vincent Douant on 01/02/2021.
//  Copyright © 2021 Google. All rights reserved.
//

import GoogleMobileAds

class AdHolder : NSObject {
    private var completion: (GADUnifiedNativeAdView) -> Void = { _ in }
    private var loaded = false
    private var adLoader: GADAdLoader!
    private lazy var nativeAdView: GADUnifiedNativeAdView = {
        let nibObjects = Bundle.main.loadNibNamed("UnifiedNativeAdView", owner: nil, options: nil)!
        let adView = nibObjects.first as! GADUnifiedNativeAdView
        return adView
    }()
    private let adUnitID = "ca-app-pub-3940256099942544/3986624511"
    var rootViewController: UIViewController!

    func load(completion: @escaping (GADUnifiedNativeAdView) -> Void) {
        if adLoader?.isLoading == true {
            self.completion = completion
            return
        }
        if loaded {
            completion(nativeAdView)
            return
        }
        adLoader = GADAdLoader(
            adUnitID: adUnitID, rootViewController: rootViewController,
            adTypes: [.unifiedNative], options: nil)
        adLoader.delegate = self
        adLoader.load(GADRequest())
        self.completion = completion
    }
}

extension AdHolder: GADUnifiedNativeAdLoaderDelegate {

    func adLoader(_ adLoader: GADAdLoader, didFailToReceiveAdWithError error: GADRequestError) {

    }

    func adLoader(_ adLoader: GADAdLoader, didReceive nativeAd: GADUnifiedNativeAd) {
        // Populate the native ad view with the native ad assets.
        // The headline and mediaContent are guaranteed to be present in every native ad.
        (nativeAdView.headlineView as? UILabel)?.text = nativeAd.headline
        nativeAdView.mediaView?.mediaContent = nativeAd.mediaContent

        // Some native ads will include a video asset, while others do not. Apps can use the
        // GADVideoController's hasVideoContent property to determine if one is present, and adjust their
        // UI accordingly.
        let mediaContent = nativeAd.mediaContent

        // These assets are not guaranteed to be present. Check that they are before
        // showing or hiding them.
        (nativeAdView.bodyView as? UILabel)?.text = nativeAd.body
        nativeAdView.bodyView?.isHidden = nativeAd.body == nil

        (nativeAdView.callToActionView as? UIButton)?.setTitle(nativeAd.callToAction, for: .normal)
        nativeAdView.callToActionView?.isHidden = nativeAd.callToAction == nil

        (nativeAdView.iconView as? UIImageView)?.image = nativeAd.icon?.image
        nativeAdView.iconView?.isHidden = nativeAd.icon == nil

        nativeAdView.starRatingView?.isHidden = nativeAd.starRating == nil

        (nativeAdView.storeView as? UILabel)?.text = nativeAd.store
        nativeAdView.storeView?.isHidden = nativeAd.store == nil

        (nativeAdView.priceView as? UILabel)?.text = nativeAd.price
        nativeAdView.priceView?.isHidden = nativeAd.price == nil

        (nativeAdView.advertiserView as? UILabel)?.text = nativeAd.advertiser
        nativeAdView.advertiserView?.isHidden = nativeAd.advertiser == nil

        // In order for the SDK to process touch events properly, user interaction should be disabled.
        nativeAdView.callToActionView?.isUserInteractionEnabled = false

        // Associate the native ad view with the native ad object. This is
        // required to make the ad clickable.
        // Note: this should always be done after populating the ad views.
        nativeAdView.nativeAd = nativeAd

        loaded = true
        completion(nativeAdView)
    }
}
