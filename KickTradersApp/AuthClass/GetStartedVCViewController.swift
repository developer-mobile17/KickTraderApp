//
//  GetStartedVCViewController.swift
//  KickTradersApp
//
//  Created by anil kumar on 19/10/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit

class GetStartedVCViewController: UIPageViewController {
    var pages = [UIViewController]()
    var pageIndicator = UIPageControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        decoratePageControl()
        self.dataSource = self
        self.delegate = self
        
        
      
        
        
        let p1: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "introScreen1VC")
        let p2: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "introScreen2VC")
       

        // etc ...

        pages.append(p1)
        pages.append(p2)
      

        // etc ...

        setViewControllers([p1], direction: UIPageViewController.NavigationDirection.forward, animated: false, completion: nil)
        
    }
    
    
    fileprivate func decoratePageControl() {
        let pc = UIPageControl.appearance(whenContainedInInstancesOf: [GetStartedVCViewController.self])
     
        pc.currentPageIndicatorTintColor = .orange
        pc.pageIndicatorTintColor = .gray
        pc.backgroundColor = .red
    }
    
    

}

extension GetStartedVCViewController: UIPageViewControllerDataSource,UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController)-> UIViewController? {
       
        let cur = pages.firstIndex(of: viewController)!

        // if you prefer to NOT scroll circularly, simply add here:
        // if cur == 0 { return nil }

        var prev = (cur - 1) % pages.count
        if prev < 0 {
            prev = pages.count - 1
        }
        return pages[prev]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController)-> UIViewController? {
         
        let cur = pages.firstIndex(of: viewController)!

        // if you prefer to NOT scroll circularly, simply add here:
        // if cur == (pages.count - 1) { return nil }

        let nxt = abs((cur + 1) % pages.count)
        return pages[nxt]
    }

    func presentationIndex(for pageViewController: UIPageViewController)-> Int {
        return pages.count
    }
    
    
}
