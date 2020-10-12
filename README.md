
 <h1 align="center"> SOTabBar </h1>
<p align="center">
    <a href="https://travis-ci.org/Ahmadalsofi/SOTabBar">
        <img src="https://img.shields.io/travis/Ahmadalsofi/SOTabBar.svg?style=flat" />
    </a>
    <img src="https://img.shields.io/badge/Swift-4 | 5-orange.svg?style=flat" />
    <a href="https://cocoapods.org/pods/SOTabBar">
        <img src="https://img.shields.io/cocoapods/v/SOTabBar.svg?style=flat" alt="CocoaPods" />
    </a>
	<a href="https://cocoapods.org/pods/SOTabBar">
        <img src="https://img.shields.io/cocoapods/p/SOTabBar.svg?style=flat" alt="Platforms" />
    </a>
	<a href="https://github.com/Carthage/Carthage">
        <img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat" />
    </a>
  	<a href="https://cocoapods.org/pods/SOTabBar">
        <img src="https://img.shields.io/cocoapods/l/SOTabBar.svg?style=flat" />
    </a>
	<a href="https://github.com/ahmadalsofi/sotabbar/releases">
        <img src="https://img.shields.io/github/release/ahmadalsofi/SOTabBar.svg" />
    </a>
  <a href="https://github.com/Ahmadalsofi/SOTabBar/issues">
        <img src="https://img.shields.io/github/issues-raw/ahmadalsofi/sotabbar" />
    </a>
  <a href="https://github.com/Ahmadalsofi/SOTabBar/releases">
        <img src="https://img.shields.io/github/release-date/ahmadalsofi/sotabbar" />
    </a>
	<br>
	<br>
	<br>
	<br>
    <img src="Screenshots/headerGif.gif" width="520" height="216"/>
</p>


---
<a href="https://github.motakasoft.com/trending/?d=2020-01-08&l=swift">
<p align="center"><img src="Screenshots/trending.png?raw=true"/></p>
</a>

---

## 📋 Requirements
SOTabBar requires iOS 9.3 or above, and is compatibile with Swift 4/5.

## 📲 Installation
### CocoaPods
SOTabBar is available through [CocoaPods](http://cocoapods.org):

```ruby
pod 'SOTabBar'
```

### Carthage
SOTabBar is also available through [Carthage](https://github.com/Carthage/Carthage):

```ogdl
github "Ahmadalsofi/SOTabBar"
```


## 🚀 Usage

### The Basics
1) Set up your view controller with the an array of view controllers that you want to appear.
2) Make  your main View Controller subclass from SOTabBarViewController.
3) return the array of your ViewControllers: 

```swift
import UIKit
import SOTabBar
class MainViewController: SOTabBarViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "First_ID")
        let secondVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Second_ID")
       
        firstVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "firstImage"), selectedImage: UIImage(named: "firstSelectedImage"))
        secondVC.tabBarItem = UITabBarItem(title: "Chat", image: UIImage(named: "secondImage"), selectedImage: UIImage(named: "secondSelectedImage"))
	
        viewControllers = [firstVC, secondVC]
    }
}
```
4) you can trigger your tab bar action by override the following function in your MainViewController
```swift
 override func soTabBar(_ tabBar: SOTabBarView, didSelectTabAt index: Int) {
      print("did Tapped On \(index)")
  }
```


## 🎨 Customization
**You should set your customization before return the array of the viewcontrollers**

```swift
class MainViewController: SOTabBarViewController {

    override func loadView() {
        super.loadView()
	    // SOTabBarSetting.propertyToCustomize = value
    }
}
```
#### tabBarHeight
```swift
    SOTabBarSetting.tabBarHeight = 100.0
```
<img src="Screenshots/tabBarHeight.png" width="220" height="388"/>

#### tabBarTintColor
```swift
    SOTabBarSetting.tabBarTintColor = UIColor.red
```
<img src="Screenshots/tabBarTintColor.png" width="220" height="388"/>

#### tabBarBackground
```swift
    SOTabBarSetting.tabBarBackground = UIColor.purple
```
<img src="Screenshots/tabBarBackground.png" width="220" height="388"/>

#### tabBarCircleSize
```swift
    SOTabBarSetting.tabBarCircleSize = CGSize(width: 50.0, height: 50.0)
  	 // or 
    SOTabBarSetting.tabBarCircleSize = CGSize(width: 80.0, height: 80.0)
```
<img src="Screenshots/tabBarCircleSize_50.png" width="220" height="388"/> <img src="Screenshots/tabBarCircleSize_80.png" width="220" height="388"/>

#### tabBarSizeImage
```swift
    SOTabBarSetting.tabBarSizeImage = CGSize(width: 40.0, height: 40.0)
```
<img src="Screenshots/tabBarSizeImage_40.png" width="220" height="388"/>

#### tabBarShadowColor
```swift
    SOTabBarSetting.tabBarShadowColor = UIColor.red.cgcolor
```
<img src="Screenshots/tabBarShadowColor_red.png" width="220" height="388"/>

#### tabBarSizeSelectedImage
```swift
    SOTabBarSetting.tabBarSizeSelectedImage = CGSize(width: 40.0, height: 40.0)
```
<img src="Screenshots/tabBarSizeSelectedImage_40.png" width="220" height="388"/>

#### tabBarAnimationDurationTime
```swift
    SOTabBarSetting.tabBarAnimationDurationTime = 2
```
<img src="Screenshots/tabBarAnimationDurationTime_2.gif" width="240" height="104"/>


## 👨🏻‍💻 Author
- Created by [Ahmad AlSofi](https://www.linkedin.com/in/ahmadalsofi/)
- Ahmadalsofi, alsofiahmad@yahoo.com

## ❤️ Contributing
Bug reports and pull requests are welcome on GitHub

## 👮🏻‍♂️ License
The library is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
