//
//  RegistrationPageVC.swift
//  PetrolPay
//
//  Created by Виталий Волков on 12.03.17.
//  Copyright © 2017 Виталий Волков. All rights reserved.
//

import UIKit

class RegistrationPageVC: UIPageViewController {
    
    
    weak var registrationDelegate:RegistrationVCDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
            registrationDelegate?.registrationPageVC(registrationPageVC: self, didUpdatePageCount:  orderedViewControllers.count)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newViewController(withOption: "Mobile"),
                self.newViewController(withOption: "Pay"),
                self.newViewController(withOption: "Gas"),
                self.newViewController(withOption: "Loyality"),
                self.newViewController(withOption: "Loyality2")]
    }()
    
    private func newViewController(withOption: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: "Enter\(withOption)VC")
    }

}

extension RegistrationPageVC: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = orderedViewControllers.index(of: firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }
    
    
}

extension RegistrationPageVC: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        if let firstViewController = viewControllers?.first
           {
            let index = orderedViewControllers.index(of: firstViewController)
            registrationDelegate?.registrationPageVC(registrationPageVC: self, didUpdatePageIndex: index!)
        }
    }
    
}



protocol RegistrationVCDelegate: class {
    /**
     Called when the number of pages is updated.
     
     - parameter tutorialPageViewController: the TutorialPageViewController instance
     - parameter count: the total number of pages.
     */
    func registrationPageVC(registrationPageVC: RegistrationPageVC,
                                    didUpdatePageCount count: Int)
    
    /**
     Called when the current index is updated.
     
     - parameter tutorialPageViewController: the TutorialPageViewController instance
     - parameter index: the index of the currently visible page.
     */
    func registrationPageVC(registrationPageVC: RegistrationPageVC,
                                    didUpdatePageIndex index: Int)
    
}
