//
//  NoteModelLocal+CoreDataProperties.swift
//  Pointly
//
//  Created by Никита on 12.09.2025.
//
//

import Foundation
import CoreData


extension NoteModelLocal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteModelLocal> {
        return NSFetchRequest<NoteModelLocal>(entityName: "NoteModelLocal")
    }

    @NSManaged public var day: String?
    @NSManaged public var descr: String?
    @NSManaged public var id: Int16
    @NSManaged public var isDone: Bool
    @NSManaged public var priority: String?
    @NSManaged public var text: String?
    @NSManaged public var time: String?
    @NSManaged public var userId: String?

}

extension NoteModelLocal : Identifiable {

}
