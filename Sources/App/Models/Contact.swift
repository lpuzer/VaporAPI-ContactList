//
// Contact.swift
//  
//
//  Created by Luciano Puzer on 11/02/22.
//

import Fluent
import Vapor

final class Contact: Model, Content {
    static let schema = "contacts"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "phone")
    var phone: Int
    
    @Field(key: "backcolor")
    var backcolor: String
    
    @Field(key: "fontcolor")
    var fontcolor: String
    
    
    init() {}
    
    init(
        id: UUID? = nil,
        name: String,
        phone: Int,
        backcolor: String,
        fontcolor: String
    ) {
        self.id = id
        self.name = name
        self.phone = phone
        self.backcolor = backcolor
        self.fontcolor = fontcolor
    }
    
   

}
