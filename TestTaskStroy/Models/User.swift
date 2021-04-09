//
//  User.swift
//  TestTaskStroy
//
//  Created by Сергей on 08.04.2021.
//

import Foundation


struct User {
    let nickName: String
    let firstName: String
    let lastName: String
    var image: String?
    var city: String?
    var numberOfFollowers = 0
    var education: String?
    var work: String?
    var status: String?
    var device: String?
    
    var fullName: String { "\(firstName) \(lastName)" }
}

extension User {
    
    static func generateMe() -> User {
        User(
            nickName: "ageres7",
            firstName: "Сергей",
            lastName: "Долгих",
            image: "sp-studio",
            city: "Оренбург",
            education: "ОФ РЭУ им. Г.В. Плеханова",
            work: "ООО Секретория",
            status: "оnline",
            device: "iphone"
        )
    }
    
    static func generateMeNil() -> User {
        User(
            nickName: "ageres7",
            firstName: "Сергей",
            lastName: "Долгих",
            image: "sp-studio"
        )
    }
    
    static func generateFrends() -> [User] {
        [
            User(nickName: "janet.weaver",
                 firstName: "Janet",
                 lastName: "Weaver",
                 image: "1-image"),
            
            User(nickName: "george.bluth",
                 firstName: "George",
                 lastName: "Bluth",
                 image: "2-image"),
            
            User(nickName: "emma.wong",
                 firstName: "Emma",
                 lastName: "Wong",
                 image: "3-image"),
            
            User(nickName: "eve.holt",
                 firstName: "Eve",
                 lastName: "Holt",
                 image: "4-image"),
            
            User(nickName: "charles.morri",
                 firstName: "Charles",
                 lastName: "Morris",
                 image: "5-image"),
            
            User(nickName: "tracey.ramos",
                 firstName: "Tracey",
                 lastName: "Ramos",
                 image: "6-image"),
            
            User(nickName: "michael.lawson",
                 firstName: "Michael",
                 lastName: "Lawson",
                 image: "7-image"),
            
            User(nickName: "lindsay.ferguson",
                 firstName: "Lindsay",
                 lastName: "Ferguson",
                 image: "8-image"),
            
            User(nickName: "tobias.funke",
                 firstName: "Tobias",
                 lastName: "Funke",
                 image: "9-image"),
            
            User(nickName: "byron.fields",
                 firstName: "Byron",
                 lastName: "Fields",
                 image: "10-image"),
            
            User(nickName: "george.edwards",
                 firstName: "George",
                 lastName: "Edwards",
                 image: "11-image"),
            
            User(nickName: "rachel.howell",
                 firstName: "Rachel",
                 lastName: "Howell",
                 image: "12-image"),
        ]
    }
}

