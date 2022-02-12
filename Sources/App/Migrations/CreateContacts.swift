//
//  CreateSongs.swift
//  
//
//  Created by Luciano Puzer on 11/02/22.
//

import Fluent

struct CreateContacts: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("contacts")
            .id()
            .field("name", .string, .required)
            .field("phone", .int, .required)
            .field("backcolor", .string, .required)
            .field("fontcolor", .string, .required)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("contacts").delete()
    }
    
    
}
