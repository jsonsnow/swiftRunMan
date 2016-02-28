//
//  RMUser.swift
//  swiftRunMan
//
//  Created by Aspmcll on 16/2/28.
//  Copyright © 2016年 Aspmcll. All rights reserved.
//

import UIKit


class RMUser: NSObject {
    
    var userName:String?
    var userPassWord:String?
    var isLogin:Bool = true
    
    
    class func getSharedInstace() -> RMUser {
        
        struct Singleton {
            
            static var dispatchOnec:dispatch_once_t = 0
            static var instance:RMUser? = nil
            
        }
        
        dispatch_once(&Singleton.dispatchOnec) { () -> Void in
            
            Singleton.instance = RMUser()
        }
        
        return Singleton.instance!
    }

}
