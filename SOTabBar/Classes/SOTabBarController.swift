//
//  SOTabBarController.swift
//  SOTabBar
//
//  Created by ahmad alsofi on 1/3/20.
//  Copyright © 2020 ahmad alsofi. All rights reserved.
//
import UIKit

@available(iOS 10.0, *)
public protocol SOTabBarControllerDelegate: NSObjectProtocol {
    func tabBarController(_ tabBarController: SOTabBarController, didSelect viewController: UIViewController)
}

@available(iOS 10.0, *)
open class SOTabBarController: UIViewController, SOTabBarDelegate {
    
    weak open var delegate: SOTabBarControllerDelegate?
    
    public var selectedIndex: Int = 0
    public var previousSelectedIndex = 0
    
    public var viewControllers = [UIViewController]() {
        didSet {
            tabBar.viewControllers = viewControllers
        }
    }
    
    private lazy var tabBar: SOTabBar = {
        let tabBar = SOTabBar()
        tabBar.delegate = self
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
        let safeAreaView = UIView()
        safeAreaView.translatesAutoresizingMaskIntoConstraints = false
        safeAreaView.backgroundColor = SOTabBarSetting.tabBarBackground
        self.view.addSubview(safeAreaView)
        self.view.bringSubviewToFront(safeAreaView)
        var constraints = [NSLayoutConstraint]()
        if #available(iOS 11.0, *) {
            constraints += [containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -(SOTabBarSetting.tabBarHeight)),
                            tabBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)]
        } else {
            constraints += [containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(SOTabBarSetting.tabBarHeight)),
                            tabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor)]
        }
        constraints += [containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                        containerView.topAnchor.constraint(equalTo: view.topAnchor),
                        tabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                        tabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                        tabBar.heightAnchor.constraint(equalToConstant: SOTabBarSetting.tabBarHeight),
                        safeAreaView.topAnchor.constraint(equalTo: tabBar.bottomAnchor),
                        safeAreaView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                        safeAreaView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                        safeAreaView.bottomAnchor.constraint(equalTo: view.bottomAnchor)]
        NSLayoutConstraint.activate(constraints)
    }
    
    func tabBar(_ tabBar: SOTabBar, didSelectTabAt index: Int) {
        
        let previousVC = viewControllers[index]
        previousVC.willMove(toParent: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParent()
        previousSelectedIndex = selectedIndex
        
        let vc = viewControllers[index]
        delegate?.tabBarController(self, didSelect: vc)
        addChild(vc)
        selectedIndex = index + 1
        vc.view.frame = containerView.bounds
        containerView.addSubview(vc.view)
        vc.didMove(toParent: self)
        
    }
    
}
