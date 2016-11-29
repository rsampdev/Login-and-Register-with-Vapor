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
    
    init(username: String, email: String, password: String) {
        self.username = username
        self.email = email
        self.password = password
    }
    
    init(node: Node, in context: Context) throws {
        id = try node.extract(NodeKey.User.id.key)
        username = try node.extract(NodeKey.User.username.key)
        email = try node.extract(NodeKey.User.email.key)
        password = try node.extract(NodeKey.User.password.key)
    }
    
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            NodeKey.User.id.key: id,
            NodeKey.User.username.key: username,
            NodeKey.User.email.key: email,
            NodeKey.User.password.key: password
            ])
    }
    
    static func prepare(_ database: Database) throws {
        try database.create(NodeKey.User.users.key) { users in
            users.id()
            users.string(NodeKey.User.username.key)
            users.string(NodeKey.User.email.key)
            users.string(NodeKey.User.password.key)
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete(NodeKey.User.users.key)
    }
    
}
