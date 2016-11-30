//
//  NodeKeys.swift
//  Login_and_Register
//
//  Created by Rodney Sampson on 11/28/16.
//
//

import Foundation

enum Key {
    
    enum User: String {
        case id
        case username
        case email
        case password
        case passwordConfirm
        case users
    }
    
    enum Error: String {
        
        case errorMessage
        
        enum Register: String {
            case none
        }
        
        enum Login: String {
            case none
        }
        
    }
    
}
