//
//  PearlApp.swift
//  Pearl
//
//  Created by robin on 6/26/16.
//  Copyright © 2016 robiz.co. All rights reserved.
//

import Foundation
import SSKeychain

class PearlApp {
    static let sharedInstance = PearlApp()
    
    private(set) var userToken: String? {
        didSet { persistToken() }
    }
    
    var isLogin: Bool { return userToken != nil }
    
    private let service = "Pearl"
    private let accounts = (token: "token", uuid: "uuid")
    
    // MARK: - Functions
    init() {
        if let token = SSKeychain.passwordForService(service, account: accounts.token, error: nil) {
            userToken = token
        }
    }
    
    // MARK: - Private
    private func persistToken() {
        if userToken != nil {
            if !SSKeychain.setPassword(userToken, forService: service, account: accounts.token) {
                print("Error persisting token!")
            }
        } else {
            if !SSKeychain.deletePasswordForService(service, account: accounts.token) {
                print("Error removing token!")
            }
        }
    }
}
