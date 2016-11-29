//
//  NodeKeys.swift
//  Login_and_Register
//
//  Created by Rodney Sampson on 11/28/16.
//
//

import Foundation

enum NodeKey {
    
    enum User: String {
        case id
        case username
        case email
        case password
        case users
        
        var key: String {
            return self.rawValue
        }
    }
    
}
