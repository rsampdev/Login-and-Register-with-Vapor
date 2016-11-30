//
//  Droplet+Test.swift
//  Login_and_Register
//
//  Created by Rodney Sampson on 11/30/16.
//
//

@testable import Vapor

func makeTestDroplet() throws -> Droplet {
    let drop = Droplet(arguments: ["dummy/path/", "prepare"],
                       workDir: "/Users/Rodney_Sampson/Code/Development/Workspaces/Xcode Workspaces/GitHub/Login and Register/Login_and_Register/",
                       environment: .test,
                       config: nil,
                       localization: try Localization(localizationDirectory: "/Localization"))

    try load(drop)
    try drop.runCommands()
    return drop
}
