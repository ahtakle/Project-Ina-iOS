//
//  TutorialController.swift
//  Ina
//
//  Created by Zachary Skemp on 6/30/17.
//  Copyright © 2017 ProjectIna. All rights reserved.
//

import UIKit

class TutorialController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource
{
    
    let pages = ["TutorialContent1", "TutorialContent2", "TutorialContent3", "TutorialContent4", "TutorialContent5", "TutorialContent6", "TutorialContent7"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        
        let vc = UIStoryboard(name: "Tutorial", bundle: nil).instantiateViewController(withIdentifier: "TutorialContent1")
        setViewControllers([vc], // Has to be a single item array, unless you're doing double sided stuff I believe
            direction: .forward,
            animated: true,
            completion: nil)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
    viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let identifier = viewController.restorationIdentifier {
            if let index = pages.index(of: identifier) {
                if index > 0 {
                    return UIStoryboard(name: "Tutorial", bundle: nil).instantiateViewController(withIdentifier: pages[index-1])
                }
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let identifier = viewController.restorationIdentifier {
            if let index = pages.index(of: identifier) {
                if index < pages.count - 1 {
                    return UIStoryboard(name: "Tutorial", bundle: nil).instantiateViewController(withIdentifier: pages[index+1])
                }
            }
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        if let identifier = viewControllers?.first?.restorationIdentifier {
            if let index = pages.index(of: identifier) {
                return index
            }
        }
        return 0
    }
//    var arrPageTitle: NSArray = NSArray()
//    var arrPagePhoto: NSArray = NSArray()
//    var pageControl = UIPageControl()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        //Other view stuff
//        arrPageTitle = ["This is The App Guruz", "This is Table Tennis 3D", "This is Hide Secrets"];
//        arrPagePhoto = ["week_1.jpg", "week_2.jpg", "week_3.jpg"];
//        self.dataSource = self
//        self.setViewControllers([getViewControllerAtIndex(index: 0)] as [UIViewController], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
//        
//        //configurePageControl()
//    }
//    
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
//    {
//        let pageContent: TutorialContentViewController = viewController as! TutorialContentViewController
//        var index = pageContent.pageIndex
//        if ((index == 0) || (index == NSNotFound))
//        {
//            return nil
//        }
//        index -= 1;
//        return getViewControllerAtIndex(index: index)
//    }
//    
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
//    {
//        let pageContent: TutorialContentViewController = viewController as! TutorialContentViewController
//        var index = pageContent.pageIndex
//        if (index == NSNotFound)
//        {
//            return nil;
//        }
//        index += 1;
//        if (index == arrPageTitle.count)
//        {
//            return nil;
//        }
//        return getViewControllerAtIndex(index: index)
//    }
//    
//    func getViewControllerAtIndex(index: NSInteger) -> TutorialContentViewController
//    {
//        // Create a new view controller and pass suitable data.
//        let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "TutorialContentViewController") as! TutorialContentViewController
//        pageContentViewController.strDescription = "\(arrPageTitle[index])"
//        pageContentViewController.strImageName = "\(arrPagePhoto[index])"
//        pageContentViewController.pageIndex = index
//        return pageContentViewController
//    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        for view in view.subviews {
//            if view is UIScrollView {
//                view.frame = UIScreen.main.bounds // Why? I don't know.
//            }
//            else if view is UIPageControl {
//                view.backgroundColor = UIColor.clear
//            }
//        }
//    }
    
//    func configurePageControl() {
//        // The total number of pages that are available is based on how many available colors we have.
//        pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 50,width: UIScreen.main.bounds.width,height: 50))
//        self.pageControl.numberOfPages = arrPageTitle.count
//        self.pageControl.currentPage = 0
//        self.pageControl.tintColor = UIColor.black
//        self.pageControl.pageIndicatorTintColor = UIColor.white
//        self.pageControl.currentPageIndicatorTintColor = UIColor.black
//        self.view.addSubview(pageControl)
//    }
//    
//    // MARK: Delegate functions
//    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
//        let pageContentViewController = pageViewController.viewControllers![0]
//        self.pageControl.currentPage = pageViewController.index(ofAccessibilityElement: pageContentViewController)
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
