//
//  ViewController.swift
//  AdSdkDemo
//
//  Created by Kotaro Arimura on 2023/12/18.
//

import UIKit
import FluctSDK

class ViewController: UIViewController {
    private var fluctBannerView: FSSAdView?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Ad SDK Demo"
        view.backgroundColor = .systemBackground
        configureGlassNavigationBar()
        setupScrollableContent()
    }

    private func configureGlassNavigationBar() {
        guard let navigationController = navigationController else { return }

        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        appearance.backgroundColor = UIColor.white.withAlphaComponent(0.22)
        appearance.shadowColor = UIColor.white.withAlphaComponent(0.35)
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.label
        ]

        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        navigationController.navigationBar.compactAppearance = appearance
        navigationController.navigationBar.tintColor = .label
        navigationController.navigationBar.isTranslucent = true
    }

    private func setupScrollableContent() {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        let guide = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: guide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),

            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])

        var previousBottom: NSLayoutYAxisAnchor = contentView.topAnchor

        for i in 1...30 {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            label.font = .systemFont(ofSize: 18, weight: .medium)
            label.text = "Row \(i): ScrollView sample content"

            contentView.addSubview(label)

            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: previousBottom, constant: 20),
                label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
            ])

            previousBottom = label.bottomAnchor

            if i == 6 {
                let bannerContainer = UIView()
                bannerContainer.translatesAutoresizingMaskIntoConstraints = false
                contentView.addSubview(bannerContainer)

                NSLayoutConstraint.activate([
                    bannerContainer.topAnchor.constraint(equalTo: previousBottom, constant: 20),
                    bannerContainer.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                    bannerContainer.widthAnchor.constraint(equalToConstant: 320),
                    bannerContainer.heightAnchor.constraint(equalToConstant: 50)
                ])

                let bannerView = FSSAdView(
                    groupId: "1000193340",
                    unitId: "1000306522",
                    size: CGSize(width: 320, height: 50)
                )
                bannerView.translatesAutoresizingMaskIntoConstraints = false
                bannerContainer.addSubview(bannerView)

                NSLayoutConstraint.activate([
                    bannerView.topAnchor.constraint(equalTo: bannerContainer.topAnchor),
                    bannerView.leadingAnchor.constraint(equalTo: bannerContainer.leadingAnchor),
                    bannerView.trailingAnchor.constraint(equalTo: bannerContainer.trailingAnchor),
                    bannerView.bottomAnchor.constraint(equalTo: bannerContainer.bottomAnchor)
                ])

                bannerView.loadAd()
                fluctBannerView = bannerView
                previousBottom = bannerContainer.bottomAnchor
            }
        }

        NSLayoutConstraint.activate([
            previousBottom.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }

}
