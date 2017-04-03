//
//  DotsVC.swift
//  PetrolPay
//
//  Created by Виталий Волков on 12.03.17.
//  Copyright © 2017 Виталий Волков. All rights reserved.
//

import UIKit

class DotsVC: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let registrationPVC = segue.destination as? RegistrationPageVC {
            registrationPVC.registrationDelegate = self
        }

    }

}

extension DotsVC: RegistrationVCDelegate {
    /**
     Called when the current index is updated.
     
     - parameter tutorialPageViewController: the TutorialPageViewController instance
     - parameter index: the index of the currently visible page.
     */
    internal func registrationPageVC(registrationPageVC: RegistrationPageVC, didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
    }

    /**
     Called when the number of pages is updated.
     
     - parameter tutorialPageViewController: the TutorialPageViewController instance
     - parameter count: the total number of pages.
     */
    internal func registrationPageVC(registrationPageVC: RegistrationPageVC, didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
}
