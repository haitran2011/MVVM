//
//  APIDelegate.swift
//  MagadiHome
//
//  Created by Mustafa Ezzat on 5/6/17.
//  Copyright © 2017 Waqood. All rights reserved.
//

import Foundation

protocol APIDelegate{
    func requestDidStart()
    func requestDidEnd(payload:AnyObject)
    func requestDidEnd(with error:String)
}
