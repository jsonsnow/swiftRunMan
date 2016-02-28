//
//  RMRegisterController.swift
//  swiftRunMan
//
//  Created by Aspmcll on 16/2/28.
//  Copyright © 2016年 Aspmcll. All rights reserved.
//

import UIKit

class RMRegisterController: UIViewController {

    @IBOutlet weak var userRegistrNameLable: UITextField!
    
    @IBOutlet weak var userRegisterPasswdLabel: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func clickCompleteBtn(sender: AnyObject) {
        
        weak var mySelf = self
        RMUser.getSharedInstace().userName = self.userRegistrNameLable.text
        RMUser.getSharedInstace().userPassWord = self.userRegisterPasswdLabel.text
        RMUser.getSharedInstace().isLogin = false
        RMXMPPManager.getSharedInstach().userRegisterWithBlock { (theResult) -> Void in
            
            
            switch theResult {
                
            case LOGInResult.LOGInResultConnectError:
                print("连接失败")
            case LOGInResult.RegisterResultError:
                print("授权失败")
            case LOGInResult.RegisterResultSuccess:
                    
                    print("注册成功")
                    mySelf?.dismissViewControllerAnimated(true, completion: nil)

            default:
                print("其他错误")
                
            }

            
        }
        
    }
    
    
    
}
