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
        
        let weakSelf = self
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.mode = MBProgressHUDModeAnnularDeterminate
        hud.labelText = "正在登陆"
        hud.hide(true, afterDelay: 1)
        hud.color = UIColor.whiteColor()
        weak var weakHud = hud
        print("userName:\(userNameLabel.text!),password:\(userPassWordLabel.text!)")
        RMUser.getSharedInstace().userName = userNameLabel.text
        RMUser.getSharedInstace().userPassWord = userPassWordLabel.text
    
   
        RMXMPPManager.getSharedInstach().userLoginWithBlock { (theReuslt) -> Void in
            
            
            switch theReuslt {
                
            case LOGInResult.LOGInResultConnectError:
                print("连接失败")
                weakHud?.mode = MBProgressHUDModeText
                weakHud?.labelText = "连接失败"
                weakHud?.hide(true, afterDelay: 1)
                
            case LOGInResult.LOGInResultAuthError:
                print("授权失败")
                weakHud?.mode = MBProgressHUDModeText
                weakHud?.labelText = "授权失败"
                weakHud?.hide(true, afterDelay: 1)
                
            case LOGInResult.LOGInResultSuccess:
                print("登录成功")
                weakHud?.mode = MBProgressHUDModeText
                weakHud?.labelText = "登录成功"
                weakHud?.hide(true, afterDelay: 1)
                weakSelf.loginSuccess()
                
                
            default:
                print("其他错误")
                
            }

        }
    }
    
       
    func loginSuccess() {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        UIApplication.sharedApplication().keyWindow?.rootViewController = storyboard.instantiateViewControllerWithIdentifier("nvc")
        
    }
    
}

