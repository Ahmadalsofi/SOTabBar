//
//  SOTabBar.swift
//  SOTabBar
//
//  Created by ahmad alsofi on 1/3/20.
//  Copyright © 2020 ahmad alsofi. All rights reserved.
//

import UIKit

// use this protocol to detect when a tab bar item is pressed
@available(iOS 10.0, *)
protocol SOTabBarDelegate: AnyObject {
     func tabBar(_ tabBar: SOTabBar, didSelectTabAt index: Int)
}

@available(iOS 10.0, *)
public class SOTabBar: UIView {
    
   internal var viewControllers = [UIViewController]() {
        didSet {
            drawTabs()
            guard !viewControllers.isEmpty else { return }
            drawConstraint()
            layoutIfNeeded()
            didSelectTab(index: 0)
        }
    }
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.clipsToBounds = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let innerCircleView: UIView = {
        let view = UIView()
        view.backgroundColor = SOTabBarSetting.tabBarBackground
        return view
    }()
    
    private let outerCircleView: UIView = {
        let view = UIView()
        view.backgroundColor = SOTabBarSetting.tabBarTintColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let tabSelectedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    weak var delegate: SOTabBarDelegate?
    
    private var selectedIndex: Int = 0
    private var previousSelectedIndex = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        dropShadow()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        dropShadow()
    }
    
    private func dropShadow() {
        backgroundColor = SOTabBarSetting.tabBarBackground
        layer.shadowColor = SOTabBarSetting.tabBarShadowColor
        layer.shadowOpacity = 0.6
        layer.shadowOffset = CGSize(width: 0, height: -2)
        layer.shadowRadius = 3
    }
    
    private func drawTabs() {
        for vc in viewControllers {
            let barView = SOTabBarItem(tabBarItem: vc.tabBarItem)
            barView.heightAnchor.constraint(equalToConstant: SOTabBarSetting.tabBarHeight).isActive = true
            barView.translatesAutoresizingMaskIntoConstraints = false
            barView.isUserInteractionEnabled = false
            self.stackView.addArrangedSubview(barView)
        }
    }
    
    private func drawConstraint() {
        addSubview(stackView)
        addSubview(innerCircleView)
      
        innerCircleView.addSubview(outerCircleView)
        outerCircleView.addSubview(tabSelectedImageView)
        
        innerCircleView.frame.size = SOTabBarSetting.tabBarCircleSize
        innerCircleView.layer.cornerRadius = SOTabBarSetting.tabBarCircleSize.width / 2
        
        outerCircleView.layer.cornerRadius = (innerCircleView.frame.size.height - 10) / 2
        
        stackView.frame = self.bounds.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        
        var constraints = [
            outerCircleView.centerYAnchor.constraint(equalTo: self.innerCircleView.centerYAnchor),
            outerCircleView.centerXAnchor.constraint(equalTo: self.innerCircleView.centerXAnchor),
            outerCircleView.heightAnchor.constraint(equalToConstant: innerCircleView.frame.size.height - 10),
            outerCircleView.widthAnchor.constraint(equalToConstant: innerCircleView.frame.size.width - 10),
            tabSelectedImageView.centerYAnchor.constraint(equalTo: outerCircleView.centerYAnchor),
            tabSelectedImageView.centerXAnchor.constraint(equalTo: outerCircleView.centerXAnchor),
            tabSelectedImageView.heightAnchor.constraint(equalToConstant: SOTabBarSetting.tabBarSizeSelectedImage),
            tabSelectedImageView.widthAnchor.constraint(equalToConstant: SOTabBarSetting.tabBarSizeSelectedImage),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor)
        ]
        if #available(iOS 11.0, *) {
            constraints.append(stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor))
        } else {
            constraints.append(stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor))
        }
        NSLayoutConstraint.activate(constraints)
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let touchArea = touches.first?.location(in: self).x else {
            return
        }
        let index = Int(floor(touchArea / tabWidth))
        didSelectTab(index: index)
    }
    
    private func didSelectTab(index: Int) {
        if index + 1 == selectedIndex {return}
        animateTitle(index: index)
 
        previousSelectedIndex = selectedIndex
        selectedIndex  = index + 1
        
        delegate?.tabBar(self, didSelectTabAt: index)
        animateCircle(with: circlePath)
        animateImage()
        
        guard let image = self.viewControllers[index].tabBarItem.selectedImage else {
            fatalError("You should insert selected image to all View Controllers")
        }
        self.tabSelectedImageView.image = image
    }
    
    private func animateTitle(index: Int) {
        self.stackView.arrangedSubviews.enumerated().forEach {
            guard let tabView = $1 as? SOTabBarItem else { return }
            ($0 == index ? tabView.animateTabSelected : tabView.animateTabDeSelect)()
        }
    }
    
    private func animateImage() {
        tabSelectedImageView.alpha = 0
        UIView.animate(withDuration: SOTabBarSetting.tabBarAnimationDurationTime) { [weak self] in
            self?.tabSelectedImageView.alpha = 1
        }
    }
    
    private func animateCircle(with path: CGPath) {
        let caframeAnimation = CAKeyframeAnimation(keyPath: #keyPath(CALayer.position))
        caframeAnimation.path = path
        caframeAnimation.duration = SOTabBarSetting.tabBarAnimationDurationTime
        caframeAnimation.fillMode = .both
        caframeAnimation.isRemovedOnCompletion = false
        innerCircleView.layer.add(caframeAnimation, forKey: "circleLayerAnimationKey")
    }
}

@available(iOS 10.0, *)
private extension SOTabBar {

    var tabWidth: CGFloat {
        return UIScreen.main.bounds.width / CGFloat(viewControllers.count)
    }

    var circlePath: CGPath {
        let startPoint_X = CGFloat(previousSelectedIndex) * CGFloat(tabWidth) - (tabWidth * 0.5)
        let endPoint_X = CGFloat(selectedIndex ) * CGFloat(tabWidth) - (tabWidth * 0.5)
        let y = SOTabBarSetting.tabBarHeight * 0.1
        let path = UIBezierPath()
        path.move(to: CGPoint(x: startPoint_X, y: y))
        path.addLine(to: CGPoint(x: endPoint_X, y: y))
        return path.cgPath
    }
    
}
