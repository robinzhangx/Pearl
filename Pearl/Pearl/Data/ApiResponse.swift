//
//  ApiResponse.swift
//  Pearl
//
//  Created by robin on 6/30/16.
//  Copyright © 2016 robiz.co. All rights reserved.
//

import Foundation

class ApiResponse {
    static let ErrorDomain = "com.pearl.error"
    
    struct ErrorMessage {
        static let Failed           = ""
        static let StatusUnknown    = "服务异常，请重试"
        static let HttpStatus       = "服务异常，请重试"
        static let Network          = "网络不给力，请重试"
        static let InvalidToken     = "用户已在其他设备登录"
    }
    
    struct ErrorCode {
        static let UnknownResponse              = -1
        static let HttpError                    = 0
    }
}
