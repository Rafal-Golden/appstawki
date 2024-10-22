//
//  User.swift
//  Appstawki
//
//  Created by Rafal Korzynski on 21/10/2024.
//
import Foundation


struct User: Codable {
    var firstName      = ""
    var lastName       = ""
    var email          = ""
    var birthday       = Date()
    var extraNapkins   = false
    var allYouCanDrink = false
}
