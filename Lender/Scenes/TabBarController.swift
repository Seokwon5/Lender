//
//  TabBarController.swift
//  Lender
//
//  Created by 이석원 on 2022/10/12.
//

import UIKit

class TabBarController: UITabBarController {
    
    private lazy var homeViewController: UIViewController = {
        let viewController = UINavigationController(rootViewController: HomeViewController())
        let tabBarItem = UITabBarItem(title: "홈",
                                      image: UIImage(systemName: "mail"),
                                      tag: 0)
        viewController.tabBarItem = tabBarItem
        
        return viewController
    }()
    
    private lazy var mapViewController : UIViewController = {
        let viewController = UIViewController()
        let tabBarItem = UITabBarItem(title: "지도",
                                      image: UIImage(systemName: "map"),
                                      tag: 1)
        viewController.tabBarItem = tabBarItem
        
        return viewController
    }()
    
    private lazy var postViewController : UIViewController = {
        let viewController = UIViewController()
        let tabBarItem = UITabBarItem(title: "글쓰기",
                                      image: UIImage(systemName: "plus"),
                                      tag: 2)
        viewController.tabBarItem = tabBarItem
        
        return viewController
    }()
    
    private lazy var chattingViewController : UIViewController = {
        let viewController = UIViewController()
        let tabBarItem = UITabBarItem(title: "채팅",
                                      image: UIImage(systemName: "bubble.right"),
                                      tag: 3)
        viewController.tabBarItem = tabBarItem
        
        return viewController
    }()
    
    private lazy var profileViewController : UIViewController = {
        let viewController = UINavigationController(rootViewController: LoginViewController())
        let tabBarItem = UITabBarItem(title: "내 프로필",
                                      image: UIImage(systemName: "person"),
                                      tag: 4)
        viewController.tabBarItem = tabBarItem
        
        return viewController
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            homeViewController,
            mapViewController,
            postViewController,
            chattingViewController,
            profileViewController
        ]

    }
    
}
