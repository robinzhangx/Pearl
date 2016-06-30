//
//  Api.swift
//  Pearl
//
//  Created by robin on 6/30/16.
//  Copyright © 2016 robiz.co. All rights reserved.
//

import Foundation

extension Router {
    enum Api: ApiRoutable {
        case Login(mobile: String)
        case ConfirmLogin(mobile: String, code: String)
        case Register(mobile: String)
        case ConfirmRegister(id: String, mobile: String, code: String)
        case User
        case Logout
        case CreateActivity(id: String, category: Activity.Category, icon: String, title: String, content: String, datetime: NSDate)
        case DeleteActivity(id: String)
        case UpdateActivity(id: String, category: Activity.Category?, icon: String?, title: String?, content: String?, datetime: NSDate?)
        case GetStream(id: String, start: NSDate?, end: NSDate?)
        case Babies
        case CreateBaby(nickname: String, gender: Baby.Gender, birthday: NSDate)
        case DeleteBaby(id: String)
        case UpdateBaby(id: String, nickname: String?, gender: Baby.Gender?, birthday: NSDate?)
        case GetBaby(id: String)
        
        case Feedback(content: String, contact: String)
        
        var routingInfo: RoutingInfo {
            switch self {
            case .Login(let mobile):
                return (.POST, "/account/login/", ["mobile": mobile])
            case .ConfirmLogin(let mobile, let code):
                return (.POST, "/account/login_confirm/", ["mobile": mobile, "validate_code": code])
            case .Register(let mobile):
                return (.POST, "/users/", ["mobile": mobile])
            case .ConfirmRegister(let id, let mobile, let code):
                return (.POST, "/users/\(id)/create_confirm/", ["mobile": mobile, "validate_code": code])
            case .User:
                return (.GET, "/users/me/", nil)
            case .Logout:
                return (.POST, "/account/logout/", nil)
            case .CreateActivity(let id, let category, let icon, let title, let content, let datetime):
                return (.POST, "/babies/\(id)/stream/", ["category": category.rawValue, "icon": icon, "title": title, "content": content, "happened_at": datetime])
            case .DeleteActivity(let id):
                return (.DELETE, "/activities/\(id)/", nil)
            case .UpdateActivity(let id, let category, let icon, let title, let content, let datetime):
                return (.POST, "/activities/\(id)/", Router.filterParams(["category": category?.rawValue, "icon": icon, "title": title, "content": content, "happened_at": datetime]))
            case .GetStream(let id, let start, let end):
                return (.GET, "/babies/\(id)/stream/", Router.filterParams(["start": start, "end": end]))
            case .Babies:
                return (.GET, "/babies/", nil)
            case .CreateBaby(let nickname, let gender, let birthday):
                return (.POST, "/babies/", ["nickname": nickname, "gender": gender.rawValue, "birthday": birthday])
            case .DeleteBaby(let id):
                return (.DELETE, "/babies/\(id)/", nil)
            case .UpdateBaby(let id, let nickname, let gender, let birthday):
                return (.POST, "/babies/\(id)/", Router.filterParams(["nickname": nickname, "gender": gender?.rawValue, "birthday": birthday]))
            case .GetBaby(let id):
                return (.GET, "/babies/\(id)/", nil)
                
            case .Feedback(let content, let contact):
                return (.POST, "/feedbacks/", ["content": content, "contact": contact])
            }
        }
    }
}