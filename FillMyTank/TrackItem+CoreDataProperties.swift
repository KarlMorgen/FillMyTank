//
//  TrackItem+CoreDataProperties.swift
//  
//
//  Created by user161495 on 1/18/20.
//
//

import Foundation
import CoreData


extension TrackItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TrackItem> {
        return NSFetchRequest<TrackItem>(entityName: "TrackItem")
    }

    @NSManaged public var kms: Int32
    @NSManaged public var liters: Float
    @NSManaged public var date: String?

}
