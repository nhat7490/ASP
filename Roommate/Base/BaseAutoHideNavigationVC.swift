//
//  BaseAutoHideNavigationVC.swift
//  Roommate
//
//  Created by TrinhHC on 12/5/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit

class BaseAutoHideNavigationVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UIScrollviewDelegate
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        super.scrollViewDidScroll(scrollView)
        let offset = scrollView.contentOffset.y
        if offset  > 50.0{
            UIView.animate(withDuration: 1.5, delay: 0, options: UIViewAnimationOptions(), animations: {
                self.navigationController?.setNavigationBarHidden(true, animated: true)
                print("Hide")
            }, completion: nil)
        }else{
            
            UIView.animate(withDuration: 1.5, delay: 0, options: UIViewAnimationOptions(), animations: {
                self.navigationController?.setNavigationBarHidden(false, animated: true)
                print("Unhide")
            }, completion: nil)
        }
    }

}
