//
//  LogInProtocol.swift
//  swiftRunMan
//
//  Created by Aspmcll on 16/2/28.
//  Copyright © 2016年 Aspmcll. All rights reserved.
//

import Foundation

protocol RMXMPPLoginDelegate:NSObjectProtocol {
    
    func loginSuccess()
    func loginFailed()
    func loginNetError()
    
}