//
//  RMLoginViewController.swift
//  swiftRunMan
//
//  Created by Aspmcll on 16/2/28.
//  Copyright © 2016年 Aspmcll. All rights reserved.
//

import UIKit

class RMLoginViewController: UIViewController{

    @IBOutlet weak var userNameLabel: UITextField!
    
    @IBOutlet weak var userPassWordLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // RMXMPPManager.getSharedInstach().loginDeleage = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        
        print("销毁了:%p",self)
        
    }
    @IBAction func clickLogInBtn(sender: AnyObject) {
        
        print("userName:\(userNameLabel.text!),password:\(userPassWordLabel.text!)")
        RMUser.getSharedInstace().userName = userNameLabel.text
        RMUser.getSharedInstace().userPassWord = userPassWordLabel.text
    
   
        RMXMPPManager.getSharedInstach().userLoginWithBlock { (theReuslt) -> Void in
            
            
            switch theReuslt {
                
            case LOGInResult.LOGInResultConnectError:
                print("连接失败")
            case LOGInResult.LOGInResultAuthError:
                print("授权失败")
            case LOGInResult.LOGInResultSuccess:
                print("登录成功")
            default:
                print("其他错误")
                
            }

        }
    }
    
       
    func loginSuccess() {
        
        print("登录成功")
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        UIApplication.sharedApplication().keyWindow?.rootViewController = storyboard.instantiateViewControllerWithIdentifier("Login")
        
    }
    
}

