//
//  UserLoginResponseContainer.swift
//  Login_and_Register
//
//  Created by Rodney Sampson on 11/29/16.
//
//

import Vapor

final class UserAuthResponse {
    
    var id: Node?
    var username: String
    var email: String
    
    init(user: User) {
        self.id = user.id
        self.username = user.username
        self.email = user.email
    }
    
    func node() throws -> Node {
        return try Node(node: [
            Key.User.id.rawValue: id,
            Key.User.username.rawValue: username,
            Key.User.email.rawValue: email
            ])
    }
    
    
}
