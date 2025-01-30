//
//  TabBarController.swift
//  ITRoots-Task
//
//  Created by Donia Elshenawy on 27/01/2025.
//

import UIKit

final class TabBarController: UITabBarController, UITabBarControllerDelegate {

    let homeViewController = HomeViewController()
    let mapViewController = MapViewController()
    let moreViewController = MoreViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = UIColor(named: "blackColor")
        tabBar.layer.backgroundColor = UIColor(named: "appColor")?.cgColor
        tabBar.layer.borderColor = UIColor.lightGray.cgColor
        tabBar.layer.masksToBounds = false
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        setTabBar()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.hidesBottomBarWhenPushed = true
    }
    
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            tabBar.frame = CGRect(x: 0, y: view.frame.maxY - 80, width: tabBar.frame.size.width , height: 80)
            tabBar.backgroundColor = UIColor(named: "appColor")
        }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        SimpleAnnimationWhenSelectItem(item)
    }

    // MARK: Add navigation to all screens and set images in all tabs.
    func setTabBar() {
        let controllers = [
            homeViewController,
            mapViewController,
            moreViewController
        ]
        
        viewControllers = controllers.map { UINavigationController(rootViewController: $0) }
        setTabBarItem(for: 0, image: "home-unselect", selectImage: "home-select")
        setTabBarItem(for: 1, image: "map-unselect", selectImage: "map-select")
        setTabBarItem(for: 2, image: "more-unselect", selectImage: "more-select")
        
        self.tabBar.tintColor = UIColor(named: "appColor")
        self.tabBar.unselectedItemTintColor = UIColor(named: "blackColor")
        self.tabBar.frame.size.height = 120
        
        let tabBarApperance = UITabBarAppearance()
        tabBarApperance.configureWithOpaqueBackground()
        tabBarApperance.backgroundColor = UIColor(named: "whiteColor")
        
        tabBarApperance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(named: "appColor") ?? .black, .font: UIFont.systemFont(ofSize: 12)]
        tabBarApperance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 12)]
        
        tabBar.standardAppearance = tabBarApperance
        tabBar.scrollEdgeAppearance = tabBarApperance
        UITabBar.appearance().scrollEdgeAppearance = tabBarApperance
        UITabBar.appearance().standardAppearance = tabBarApperance
    }

    // MARK: Set tabBar image and selected image.
    func setTabBarItem(for index: Int, image: String, selectImage: String) {
        tabBar.items?[index].image = UIImage(named: image)
        tabBar.items?[index].selectedImage = UIImage(named: selectImage)
    }
    
    // MARK: Set tabBar title
    func setTabBarTitle(for index: Int, title: String) {
        tabBar.items?[index].title = title
    }

    func SimpleAnnimationWhenSelectItem(_ item: UITabBarItem) {
        guard let barItemView = item.value(forKey: "view") as? UIView else { return }
        let timeInterval: TimeInterval = 0.3
        let propertyAnimator = UIViewPropertyAnimator(duration: timeInterval, dampingRatio: 0.5) {
            barItemView.transform = CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.9)
        }
        propertyAnimator.addAnimations({ barItemView.transform = .identity }, delayFactor: CGFloat(timeInterval))
        propertyAnimator.startAnimation()
    }
}

