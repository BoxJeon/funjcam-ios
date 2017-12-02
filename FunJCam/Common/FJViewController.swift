//
//  BaseViewController.swift
//  FunJCam
//
//  Created by boxjeon on 2017. 1. 12..
//  Copyright © 2017년 the42apps. All rights reserved.
//

class FJViewController: UIViewController, NibLoadable {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return FJConstant.device.hasNotch ? .lightContent : .default
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.updateNavigationBarAsTransparent()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }
    
}
