//
//  SOTabBarViewController.swift
//  SOTabBar
//
//  Created by ahmad alsofi on 1/3/20.
//  Copyright © 2020 ahmad alsofi. All rights reserved.
//
import UIKit
@available(iOS 10.0, *)
open class SOTabBarViewController: UIViewController, SOTabBarDelegate {
    
    public var selectedIndex: Int = 0
    public var previousSelectedIndex = 0
    
    public var viewControllers: [UIViewController]! {
        didSet {
            drawConstraint()
        }
    }
    
    private lazy var soTabBar: SOTabBarView = {
        let soBarView = SOTabBarView()
        soBarView.viewControllers = viewControllers
        soBarView.setupView()
        soBarView.tabBarDelegate = self
        self.view.addSubview(soBarView)
        return soBarView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        self.view.addSubview(view)
        return view
    }()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func drawConstraint() {
        let safeAreaView = UIView()
        safeAreaView.backgroundColor = SOTabBarSetting.tabBarBackground
        self.view.addSubview(safeAreaView)
        
        var constraints = [NSLayoutConstraint]()
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            constraints.append(containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -(SOTabBarSetting.tabBarHeight)))
           } else {
            constraints.append(containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(SOTabBarSetting.tabBarHeight)))
        }
        constraints.append(containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        constraints.append(containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        constraints.append(containerView.topAnchor.constraint(equalTo: view.topAnchor))
        
        soTabBar.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            constraints.append(soTabBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
           } else {
            constraints.append(soTabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        }
        constraints.append(soTabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        constraints.append(soTabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        constraints.append(soTabBar.heightAnchor.constraint(equalToConstant: SOTabBarSetting.tabBarHeight))
        
        safeAreaView.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(safeAreaView.topAnchor.constraint(equalTo: soTabBar.bottomAnchor))
        constraints.append(safeAreaView.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        constraints.append(safeAreaView.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        constraints.append(safeAreaView.bottomAnchor.constraint(equalTo: view.bottomAnchor))

        view.bringSubviewToFront(soTabBar)
        view.bringSubviewToFront(safeAreaView)
        constraints.forEach({ $0.isActive = true })
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


// Here you can customize the tab bar to meet your neededs

public struct SOTabBarSetting {
    
    public static var tabBarHeight: CGFloat = 66
    public static var tabBarTintColor: UIColor = UIColor(red: 250/255, green: 51/255, blue: 24/255, alpha: 1)
    public static var tabBarBackground: UIColor = UIColor.white
    public static var tabBarCircleSize = CGSize(width: 65, height: 65)
    public static var tabBarSizeImage: CGFloat = 25
    public static var tabBarShadowColor = UIColor.lightGray.cgColor
    public static var tabBarSizeSelectedImage: CGFloat = 20
    public static var tabBarAnimationDurationTime: Double = 0.4
    
}


// use this protocol to detect when a tab bar item is pressed
@available(iOS 10.0, *)
protocol SOTabBarDelegate: AnyObject {
     func soTabBar(_ tabBar: SOTabBarView, didSelectTabAt index: Int)
}

