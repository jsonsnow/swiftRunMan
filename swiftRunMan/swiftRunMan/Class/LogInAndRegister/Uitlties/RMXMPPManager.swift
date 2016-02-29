//
//  RMXMPPManager.swift
//  swiftRunMan
//
//  Created by Aspmcll on 16/2/28.
//  Copyright © 2016年 Aspmcll. All rights reserved.
//

import UIKit
import Foundation


enum LOGInResult {
    
    case LOGInResultSuccess
    case LOGInResultAuthError
    case LOGInResultConnectError
    case RegisterResultSuccess
    case RegisterResultError
    
}


class RMXMPPManager: NSObject,XMPPStreamDelegate{
    
    weak var loginDeleage:RMXMPPLoginDelegate?
    var xmppStream:XMPPStream!
    var xmppRoserStore:XMPPRosterCoreDataStorage!
    var xmppRoser:XMPPRoster!
    
    var logInBlock:((theResult:LOGInResult) -> Void)?
    static var onceToKen:dispatch_once_t = 0
    static var manager  :RMXMPPManager? = nil

    func userLoginWithBlock(reusltBlock:((theReuslt:LOGInResult) ->Void)) {
        
    self.logInBlock = reusltBlock
    self.conectToServer()
        
        
    }
    
    func userRegisterWithBlock(resultBlock:((theResult:LOGInResult) ->Void)) {
        
        self.logInBlock = resultBlock
        self.conectToServer()
        
    }
//    func userLogin() {
//        
//        self.conectToServer()
//        
//    }
    
    override init() {
        
        super.init()
     
        self.setupXmppStream()
        
    }
    class func getSharedInstach() -> RMXMPPManager {
        
        dispatch_once(&onceToKen) { () -> Void in
            
            manager = RMXMPPManager()
        }
        
        return manager!
    }
    //设置流 设置代理
    func setupXmppStream() {
      
        xmppStream = XMPPStream()
        xmppStream.addDelegate(self, delegateQueue: dispatch_get_main_queue())
        self.xmppRoserStore = XMPPRosterCoreDataStorage.sharedInstance()
        self.xmppRoser = XMPPRoster(rosterStorage: xmppRoserStore)
        xmppRoser.activate(xmppStream)
        
    }
    //连接服务器
    func conectToServer() {
        
        if xmppStream != nil {
            
            xmppStream.disconnect()
            
        }
       // xmppStream.disconnect()// 不然第二次没法登
        
        if xmppStream == nil {
            
            self.setupXmppStream()
            
        }
        var userNames:String!
        userNames = RMUser.getSharedInstace().userName
        xmppStream.hostName = XMPPHOSTNMAE
        xmppStream.hostPort = XMPPPORT
        xmppStream.myJID = XMPPJID.jidWithUser(userNames, domain: XMPPDOMAIN, resource: "iphone")
        if RMUser.getSharedInstace().isLogin == true {
            
            do {
                
                try xmppStream.connectWithTimeout(XMPPStreamTimeoutNone)
                
            } catch let error as NSError{
                
                print(error.description)
            }

            
        } else {
            
           
            do {
                
                try xmppStream.connectWithTimeout(XMPPStreamTimeoutNone)
                
            } catch let error as NSError{
                
                print(error.description)
            }
            
            
            
        }
        //let jidStr = String("\(userNames)@\(XMPPDOMAIN)")
        
        xmppStream.myJID = XMPPJID.jidWithUser(userNames, domain: XMPPDOMAIN, resource: "iphone")
        
    }

    //连接成功发送密码
    
    func sendPassword() {
        
        var userPasswd:String!
        
        if RMUser.getSharedInstace().isLogin == true {
            
            userPasswd = RMUser.getSharedInstace().userPassWord
            
            do {
                
                try xmppStream.authenticateWithPassword(userPasswd)
                
            } catch {
                
                print("发送密码错误");
            }

            
        } else {
            
            userPasswd = RMUser.getSharedInstace().userPassWord
            
            do {
                
                try xmppStream.registerWithPassword(userPasswd)
                
            } catch {
                
                print("发送密码失败")
            }
            
            RMUser.getSharedInstace().isLogin = true
        }
        
        
        
    }
    
    func sendOnline() {
        
        let presence = XMPPPresence()
        xmppStream.sendElement(presence)
    }
    

    
    func xmppStreamDidDisconnect(sender: XMPPStream!, withError error: NSError!) {
        

        loginDeleage?.loginNetError()
        
        if error != nil {
            
            self.logInBlock!(theResult: LOGInResult.LOGInResultConnectError)

        }
        
        
    }

    func xmppStreamDidConnect(sender: XMPPStream!) {
        
      
        self.sendPassword()
        
        
    }
    
    func xmppStreamDidAuthenticate(sender: XMPPStream!) {
        
        
        self.sendOnline()
        loginDeleage?.loginSuccess()
        self.logInBlock!(theResult: LOGInResult.LOGInResultSuccess)
        
    }
    func xmppStream(sender: XMPPStream!, didNotAuthenticate error: DDXMLElement!) {
        
              loginDeleage?.loginFailed()
        self.logInBlock!(theResult: LOGInResult.LOGInResultAuthError)
    }
    
    func xmppStreamDidRegister(sender: XMPPStream!) {
        
        self.logInBlock!(theResult: LOGInResult.RegisterResultSuccess)
        
    }
    
    func xmppStream(sender: XMPPStream!, didNotRegister error: DDXMLElement!) {
        
        self.logInBlock!(theResult: LOGInResult.RegisterResultError)
        
    }
    //获取授权信息
    //授权成功 发送在线消息
    
}
