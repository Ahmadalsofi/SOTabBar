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
            soTabBar.viewControllers = viewControllers
        }
    }
    
    private lazy var soTabBar: SOTabBarView = {
        let soBarView = SOTabBarView()
        soBarView.tabBarDelegate = self
        soBarView.translatesAutoresizingMaskIntoConstraints = false
        return soBarView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(soTabBar)
        self.view.addSubview(containerView)
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
            constraints.append(soTabBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        } else {
            constraints.append(soTabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        }
        constraints.append(soTabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        constraints.append(soTabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        constraints.append(soTabBar.heightAnchor.constraint(equalToConstant: SOTabBarSetting.tabBarHeight))
        
        view.bringSubviewToFront(soTabBar)
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
