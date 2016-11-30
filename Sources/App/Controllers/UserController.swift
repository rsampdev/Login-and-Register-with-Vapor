//
//  UserController.swift
//  Login_and_Register
//
//  Created by Rodney Sampson on 11/28/16.
//
//

import Foundation
import Vapor
import HTTP

final class UserController {
    
    func revertAndPrepare(_ request: Request) throws -> ResponseRepresentable {
        do {
            guard let database = User.database else {
                return try JSON(node: [Key.Error.errorMessage.rawValue: "error=database does not exist"])
            }
            
            try User.revert(database)
            try User.prepare(database)
            
            var sampson = User(username: "sampson", email: "sampson@sampson.sampson", password: "sampson")
            try sampson.save()
            
            return try JSON(node: ["message": "User table successfuly reverted and prepared"])
        } catch let error {
            return try JSON(node: [Key.Error.errorMessage.rawValue: "error=\(error)"])
        }
    }
    
    func register(_ request: Request) throws -> ResponseRepresentable {
        guard let json = request.json else {
            return try JSON(node: [Key.Error.errorMessage.rawValue: "Invalid request type"])
        }
        
        guard let username = json[Key.User.username.rawValue]?.string,
            let email = json[Key.User.email.rawValue]?.string,
            let password = json[Key.User.password.rawValue]?.string,
            let passwordConfirm = json[Key.User.passwordConfirm.rawValue]?.string else {
                return try JSON(node: [Key.Error.errorMessage.rawValue: "Invalid request parameters"])
        }
        
        if try User.query().filter(Key.User.username.rawValue, username).first() != nil {
            return try JSON(node: Node([Key.Error.errorMessage.rawValue: "Username is already in use"]))
        }
        
        if try User.query().filter(Key.User.email.rawValue, email).first() != nil {
            return try JSON(node: Node([Key.Error.errorMessage.rawValue: "Email is already in use"]))
        }
        
        if !(username.trimmingCharacters(in: CharacterSet.alphanumerics).isEmpty) {
            return try JSON(node: [Key.Error.errorMessage.rawValue: "Username can only contain alphanumerics and must be 7 or more characters "])
        }
        
        if password.count < 7 {
            return try JSON(node: [Key.Error.errorMessage.rawValue: "Password must be 7 or more characters"])
        }
        
        if password != passwordConfirm {
            return try JSON(node: Node([Key.Error.errorMessage.rawValue: "Passwords must match"]))
        }
        
        var user = User(username: username, email: email, password: password)
        try user.save()
        
        let response = UserAuthResponse(user: user)
        
        return try JSON(node: response.node())
    }
    
    func login(_ request: Request) throws -> ResponseRepresentable {
        guard let json = request.json else {
            return try JSON(node: [Key.Error.errorMessage.rawValue: "Invalid request type"])
        }
        
        guard let username = json[Key.User.username.rawValue]?.string, let password = json[Key.User.password.rawValue]?.string else {
            return try JSON(node: [Key.Error.errorMessage.rawValue: "Invalid username or password"])
        }
        
        guard let user = try User.query().filter(Key.User.username.rawValue, contains: username).first() else {
            return try JSON(node: [Key.Error.errorMessage.rawValue: "Unknown user credentials"])
        }
        
        guard user.password == password else {
            return try JSON(node: [Key.Error.errorMessage.rawValue: "Password does not match"])
        }
        
        let response = UserAuthResponse(user: user)
        
        let data = try JSON(node: response.node())
        
        return data
    }
    
}
