//
//  Droplet+Setup.swift
//  Login_and_Register
//
//  Created by Rodney Sampson on 11/30/16.
//
//

import Vapor
import VaporMySQL

func load(_ drop: Droplet) throws {
    try drop.addProvider(VaporMySQL.Provider.self)
    
    drop.preparations.append(User.self)
    
    let userController = UserController()
    
    drop.post("revertAndPrepareUserDatabase", handler: userController.revertAndPrepare)
    
    drop.post("register", handler: userController.register)
    
    drop.post("login", handler: userController.login)
    
    drop.console.print("Thank you for using my Login and Register API built with Vapor", newLine: true)
}
