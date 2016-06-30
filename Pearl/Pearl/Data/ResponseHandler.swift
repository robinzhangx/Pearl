//
//  ResponseHandler.swift
//  Pearl
//
//  Created by robin on 6/30/16.
//  Copyright © 2016 robiz.co. All rights reserved.
//

import Foundation
import Alamofire

public protocol ResponseObjectSerializable {
    init?(response: NSHTTPURLResponse?, data: AnyObject)
}

public protocol ResponseCollectionSerializable {
    static func collection(response response: NSHTTPURLResponse?, data: AnyObject) -> [Self]
}

extension Request {
    public func responseObject<T: ResponseObjectSerializable>(completionHandler: Response<T, NSError> -> Void) -> Self {
        return makeResponse(completionHandler) { (response, data) -> T? in
            T(response: response, data: data)
        }
    }
    
    public func responseCollection<T: ResponseCollectionSerializable>(completionHandler: Response<[T], NSError> -> Void) -> Self {
        return makeResponse(completionHandler) { (response, data) -> [T]? in
            T.collection(response: response, data: data)
        }
    }
    
    private func makeResponse<P>(completionHandler: Alamofire.Response<P, NSError> -> Void, converter: (response: NSHTTPURLResponse?, data: AnyObject) -> P?) -> Self {
        let serializer = ResponseSerializer<P, NSError> { request, response, data, error in
            guard error == nil else { return .Failure(error!) }
            let result = Request.JSONResponseSerializer(options: .AllowFragments).serializeResponse(request, response, data, error)
            if let response = response, json: AnyObject = result.value {
                if response.statusCode >= 200 && response.statusCode < 400 {
                    if let p = converter(response: response, data: json) {
                        return .Success(p)
                    } else {
                        return .Failure(NSError(domain: ApiResponse.ErrorDomain,
                            code: ApiResponse.ErrorCode.UnknownResponse,
                            userInfo: [NSLocalizedDescriptionKey: ApiResponse.ErrorMessage.Failed]))
                    }
                } else {
                    return .Failure(NSError(domain: ApiResponse.ErrorDomain,
                        code: ApiResponse.ErrorCode.HttpError,
                        userInfo: [NSLocalizedDescriptionKey: ApiResponse.ErrorMessage.HttpStatus]))
                }
            } else {
                return .Failure(result.error!)
            }
        }
        return response(responseSerializer: serializer, completionHandler: completionHandler)
    }
}
