//
//  MainViewController.swift
//  Example
//
//  Created by Antony Kolesynskyi on 09.07.2018.
//  Copyright © 2018 Luis Padron. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    
    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var labelTwo: UILabel!
    @IBOutlet weak var transitionButton: UIButton!
    @IBOutlet weak var bgImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.isStatusBarHidden = true
        labelOne.alpha = 0
        labelTwo.alpha = 0
        transitionButton.alpha = 0
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.bgImage.alpha = 1
        }) { (true) in
            self.showLabelOne()
        }
    }
    
    func showLabelOne() {
        UIView.animate(withDuration: 0.5, animations: {
            self.labelOne.alpha = 1
        }, completion: { (true) in
            showLabelTwo()
        })
        
        func showLabelTwo() {
            UIView.animate(withDuration: 0.5, animations: {
                self.labelTwo.alpha = 1
            }, completion: { (true) in
                showTransitionButton()
                
            })
            func showTransitionButton() {
                UIView.animate(withDuration: 0.5, animations: {
                    self.transitionButton.alpha = 1
                })
            }
        }
        
    }
    
    
    
}

