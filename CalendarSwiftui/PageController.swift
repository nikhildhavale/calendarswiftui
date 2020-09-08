//
//  PageController.swift
//  CalendarSwiftui
//
//  Created by Nikhil on 08/09/20.
//  Copyright © 2020 Nikhil. All rights reserved.
//

import Foundation
import SwiftUI
struct PageViewController: UIViewControllerRepresentable {
    var controller: UIViewController!
    let pageViewController = UIPageViewController(
               transitionStyle: .scroll,
               navigationOrientation: .horizontal)
    let navigationDirection:UIPageViewController.NavigationDirection
    func makeUIViewController(context: Context) -> UIPageViewController {
       
        return pageViewController
    }
    
    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        pageViewController.setViewControllers(
            [controller], direction: navigationDirection, animated: true)
    }
}
struct PageView<Page: View>: View {
    var viewController:UIViewController!
    let navigationDirection:UIPageViewController.NavigationDirection
    init(_ view: Page,navigationDirection:UIPageViewController.NavigationDirection) {
        self.viewController = UIHostingController(rootView: view)
        self.navigationDirection = navigationDirection
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            PageViewController(controller: viewController, navigationDirection: navigationDirection)
                .padding(.trailing)
        }
    }
}


