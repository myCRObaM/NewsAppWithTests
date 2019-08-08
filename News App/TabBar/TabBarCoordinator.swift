//
//  AppCoordinator.swift
//  News App
//
//  Created by Matej Hetzel on 01/08/2019.
//  Copyright © 2019 Matej Hetzel. All rights reserved.
//

import Foundation
import UIKit

class TabBarCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    let parent: TabBarController
    var detailsViewCoordinator: DetailsViewCoordinator?
    var allNewsNavController = UINavigationController()
    var allNewsViewController: NewsTableViewController!
    var favoriteNewsNavController = UINavigationController()
    var favoriteNewsViewController = FavoriteNewsViewController()
    
    init (controller: TabBarController){
        parent = controller
    }
    
    func start() {
        setupControllers()
    }
    
    func setupControllers() {
        allNewsNavController = allNewsNavigation()
        favoriteNewsNavController = favoriteNavigation()
        
        let newsTableView = NewsTableViewCoordinator(navController: allNewsNavController, root: self)
        let favnewsTableView = FavoriteNewsTableCoordinator(navController: favoriteNewsNavController, root: self)
        
        newsTableView.start()
        favnewsTableView.start()
        allNewsNavController.viewControllers = [allNewsViewController]
        favoriteNewsNavController.viewControllers = [favoriteNewsViewController]
        
        parent.viewControllers = [allNewsNavController, favoriteNewsNavController]
    }
    
    func allNewsNavigation() -> UINavigationController{
        let navController = UINavigationController()
        navController.title = "News feed"
        navController.tabBarItem.image = UIImage(named: "note")
        return navController
    }
    func favoriteNavigation() -> UINavigationController{
        let navController = UINavigationController()
        navController.title = "Favorites"
        navController.tabBarItem.image = UIImage(named: "list")
        return navController
    }
}

