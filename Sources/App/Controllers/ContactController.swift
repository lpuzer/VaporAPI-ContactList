//
// SongController.swift
//  
//
//  Created by Luciano Puzer on 11/02/22.
//

import Fluent
import Vapor

struct ConstactController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let contacts = routes.grouped("contacts")
        contacts.get(use: index)
        contacts.post(use: create)
        contacts.put(use: update)
        contacts.group(":contactId") { contact in
            contact.delete(use: delete)
        }
    }
    
    //POST Request /contacts route
    func index(req: Request) throws -> EventLoopFuture<[Contact]> {
        return Contact.query(on: req.db).all()
    }
    
    //GET Request /contacts route
    func create(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let contact = try req.content.decode(Contact.self)
        return contact.save(on: req.db).transform(to: .ok)
    }
    
    
    //PUT Request /contacts route
    func update(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let contact = try req.content.decode(Contact.self)

        return Contact.find(contact.id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap {
                $0.name = contact.name
                $0.phone = contact.phone
                $0.backcolor = contact.backcolor
                $0.fontcolor = contact.fontcolor
                return $0.update(on: req.db).transform(to: .ok)
            }
    }
    
    
    //DELETE Request /contacts/id route
    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        Contact.find(req.parameters.get("contactId"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
    
}
