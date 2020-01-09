//
//  TrackItem+CoreDataProperties.swift
//  
//
//  Created by user161495 on 1/9/20.
//
//

import Foundation
import CoreData


extension TrackItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TrackItem> {
        return NSFetchRequest<TrackItem>(entityName: "TrackItem")
    }

    @NSManaged public var kms: String?
    @NSManaged public var liters: String?
    @NSManaged public var date: String?
    @NSManaged public var image: NSObject?

}
