//
//  Droplet+Test.swift
//  Login_and_Register
//
//  Created by Rodney Sampson on 11/30/16.
//
//

@testable import Vapor

func makeTestDroplet() throws -> Droplet {
    let drop = Droplet()
//    drop.arguments = ["dummy/path/", "prepare"]
    try load(drop)
    try drop.runCommands()
    return drop
}
