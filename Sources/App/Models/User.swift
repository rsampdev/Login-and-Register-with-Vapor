//
//  User.swift
//  Login_and_Register
//
//  Created by Rodney Sampson on 11/28/16.
//
//

import Vapor
import Fluent

final class User: Model {
    var id: Node?
    var username: String
    var email: String
    var password: String
    var exists: Bool = false
    
    init(username: String, email: String, password: String) {
        self.username = username
        self.email = email
        self.password = password
    }
    
    init(node: Node, in context: Context) throws {
        self.id = try node.extract(Key.User.id.rawValue)
        self.username = try node.extract(Key.User.username.rawValue)
        self.email = try node.extract(Key.User.email.rawValue)
        self.password = try node.extract(Key.User.password.rawValue)
    }
    
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            Key.User.id.rawValue: id,
            Key.User.username.rawValue: username,
            Key.User.email.rawValue: email,
            Key.User.password.rawValue: password
            ])
    }
    
    static func prepare(_ database: Database) throws {
        try database.create(Key.User.users.rawValue) { users in
            users.id()
            users.string(Key.User.username.rawValue)
            users.string(Key.User.email.rawValue)
            users.string(Key.User.password.rawValue)
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete(Key.User.users.rawValue)
    }
    
}
