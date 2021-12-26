//
//  PageViewController.swift
//  UIPageViewController-TopTabBarPOC
//
//  Created by Akash soni on 26/12/21.
//

import UIKit
/*
 http://www.codefonsi.com
 
 https://www.youtube.com/watch?v=oX9o-DnMHsE
 */
class PageViewController: UIPageViewController {
    lazy var pageViewControllers:[UIViewController] = {
        return [initViewController("OneViewController"),initViewController("TwoViewController"),initViewController("ThreeViewController"),initViewController("FourViewController")]
    }()
    private func initViewController(_ name:String)-> UIViewController{
        let story = UIStoryboard(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: name)
        return vc
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        if let firstVC = pageViewControllers.first{
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for view in view.subviews{
            if view is UIScrollView{
                view.frame = UIScreen.main.bounds 
            } else if view is UIPageControl{
                view.isHidden = true
            }
        }
    }
}
extension PageViewController:UIPageViewControllerDelegate,UIPageViewControllerDataSource{
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageViewControllers.count
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstVC = pageViewController.viewControllers?.first, let firstIndex = pageViewControllers.index(of: firstVC) else { return 0 }
        
        return firstIndex
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = pageViewControllers.firstIndex(of: viewController) else { return nil }
        let previousIndex = vcIndex - 1
        guard previousIndex >= 0 else { return pageViewControllers.last }
        guard pageViewControllers.count >= previousIndex else { return nil }
        return pageViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = pageViewControllers.firstIndex(of: viewController) else { return nil }
        let nextIndex = vcIndex + 1
        guard nextIndex < pageViewControllers.count else { return pageViewControllers.first }
        guard  pageViewControllers.count > nextIndex else { return nil }
        return pageViewControllers[nextIndex]

    }
    
    
}
