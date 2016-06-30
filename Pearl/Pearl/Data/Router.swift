//
//  Router.swift
//  Pearl
//
//  Created by robin on 6/30/16.
//  Copyright © 2016 robiz.co. All rights reserved.
//

import Foundation
import Alamofire

typealias RoutingInfo = (method: Alamofire.Method, path: String, params: [String: AnyObject]?)

protocol ApiRoutable: URLRequestConvertible {
    var routingInfo: RoutingInfo { get }
}

extension ApiRoutable {
    var URLRequest: NSMutableURLRequest {
        return Router.generateUrlRequest(routingInfo)
    }
}

class Router {
    static func generateUrlRequest(info: RoutingInfo) -> NSMutableURLRequest {
        var info = info
        if info.params == nil {
            info.params = [String: AnyObject]()
        }
        let base = NSURL(string: "http://115.28.200.77") // TODO: configurable
        let request = NSMutableURLRequest(URL: base!.URLByAppendingPathComponent(info.path))
        request.HTTPMethod = info.method.rawValue
        if let token = PearlApp.sharedInstance.userToken {
            request.setValue("token " + token, forHTTPHeaderField: "Authorization")
        }
        let version: String = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as? String ?? ""
        request.setValue("iOS-\(version)", forHTTPHeaderField: CustomHeaders.ClientVersion)
        return ParameterEncoding.URL.encode(request, parameters: info.params).0
    }
    
    static func filterParams(params: [String: AnyObject?]) -> [String: AnyObject] {
        var filtered = [String: AnyObject]()
        for (k, v) in params {
            if let value: AnyObject = v {
                filtered[k] = value
            }
        }
        return filtered
    }
    
    struct CustomHeaders {
        static let ClientVersion    = "X-Client-Version"
    }
}
