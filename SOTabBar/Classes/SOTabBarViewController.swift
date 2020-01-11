//
//  SOTabBarViewController.swift
//  SOTabBar
//
//  Created by ahmad alsofi on 1/3/20.
//  Copyright © 2020 ahmad alsofi. All rights reserved.
//
import UIKit
@available(iOS 10.0, *)
open class SOTabBarViewController: UIViewController, SOTabBarViewDelegate {
    
    public var selectedIndex: Int = 0
    public var previousSelectedIndex = 0
    
    public var viewControllers: [UIViewController]! {
        didSet {
            tabBar.viewControllers = viewControllers
        }
    }
    
    private lazy var tabBar: SOTabBarView = {
        let tabBar = SOTabBarView()
        tabBar.tabBarDelegate = self
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        return tabBar
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(containerView)
        self.view.addSubview(tabBar)
        self.view.bringSubviewToFront(tabBar)
        self.drawConstraint()
    }
    
    private func drawConstraint() {
        var constraints = [NSLayoutConstraint]()
        if #available(iOS 11.0, *) {
            constraints.append(containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -(SOTabBarSetting.tabBarHeight)))
        } else {
            constraints.append(containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(SOTabBarSetting.tabBarHeight)))
        }
        constraints.append(containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        constraints.append(containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        constraints.append(containerView.topAnchor.constraint(equalTo: view.topAnchor))
        
        if #available(iOS 11.0, *) {
            constraints.append(tabBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        } else {
            constraints.append(tabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        }
        constraints.append(tabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        constraints.append(tabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        constraints.append(tabBar.heightAnchor.constraint(equalToConstant: SOTabBarSetting.tabBarHeight))
        NSLayoutConstraint.activate(constraints)
    }
    
    open func soTabBar(_ tabBar: SOTabBarView, didSelectTabAt index: Int) {
        
        let previousVC = viewControllers?[index]
        previousVC?.willMove(toParent: nil)
        previousVC?.view.removeFromSuperview()
        previousVC?.removeFromParent()
        previousSelectedIndex = selectedIndex
        
        let vc = viewControllers[index]
        addChild(vc)
        selectedIndex = index + 1
        vc.view.frame = containerView.bounds
        containerView.addSubview(vc.view)
        vc.didMove(toParent: self)
        
    }
    
}
