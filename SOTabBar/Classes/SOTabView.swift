//
//  SOTabView.swift
//  SOTabBar
//
//  Created by ahmad alsofi on 1/3/20.
//  Copyright © 2020 ahmad alsofi. All rights reserved.
//

import UIKit
@available(iOS 10.0, *)
class SOTabView: UIView {
    
    let image: UIImage
    let title: String
    
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = self.title
        lbl.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.semibold)
        lbl.textColor = UIColor.darkGray
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var tabImageView: UIImageView = {
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    init(tabBar: UITabBarItem) {
        guard let selecteImage = tabBar.image else {
            fatalError("You should set image to all view controllers")
        }
        self.image = selecteImage
        self.title = tabBar.title ?? ""
        super.init(frame: .zero)
        drawConstraints()
    }
    
    private func drawConstraints() {
        self.addSubview(titleLabel)
        self.addSubview(tabImageView)
        var constraints = [NSLayoutConstraint]()
        constraints.append(tabImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor))
        constraints.append(tabImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor))
        constraints.append(tabImageView.heightAnchor.constraint(equalToConstant: SOTabBarSetting.tabBarSizeImage))
        constraints.append(tabImageView.widthAnchor.constraint(equalToConstant: SOTabBarSetting.tabBarSizeImage))
        constraints.append(titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: SOTabBarSetting.tabBarHeight))
        constraints.append(titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor))
        constraints.append(titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor))
        constraints.append(titleLabel.heightAnchor.constraint(equalToConstant: 26))
        constraints.forEach({ $0.isActive = true })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   internal func animateTabSelected() {
        tabImageView.alpha = 1
        titleLabel.alpha = 0
        UIView.animate(withDuration: SOTabBarSetting.tabBarAnimationDurationTime) { [weak self] in
            self?.titleLabel.alpha = 1
            self?.titleLabel.frame.origin.y = SOTabBarSetting.tabBarHeight / 1.8
            self?.tabImageView.frame.origin.y = -5
            self?.tabImageView.alpha = 0
        }
    }
    
    internal func animateTabDeSelect() {
        tabImageView.alpha = 1
        UIView.animate(withDuration: SOTabBarSetting.tabBarAnimationDurationTime) { [weak self] in
            self?.titleLabel.frame.origin.y = SOTabBarSetting.tabBarHeight
            self?.tabImageView.frame.origin.y = (SOTabBarSetting.tabBarHeight / 2) - CGFloat(SOTabBarSetting.tabBarSizeImage / 2)
            self?.tabImageView.alpha = 1
        }
    }
}
