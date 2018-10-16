//
//  CustomHud.swift
//  test
//
//  Created by sinyilin on 2018/10/5.
//  Copyright © 2018年 sinyilin. All rights reserved.
//

import UIKit
import MBProgressHUD

class CustomHud: NSObject {

    public func ShowHUD(hud:MBProgressHUD,message:String)
    {
        hud.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        hud.center = hud.center
        hud.detailsLabel.text = message
        hud.isHidden = false
        hud.show(animated: true)
        
    }
    public func HiddenHUD(hud:MBProgressHUD)
    {
        hud.backgroundColor = nil
        hud.hide(animated: true)
    }
}
