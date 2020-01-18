//
//  TrackItem+CoreDataClass.swift
//  FillMyTank
//
//  Created by user161495 on 1/18/20.
//  Copyright © 2020 MarouenAbdi. All rights reserved.
//
//

import Foundation
import CoreData

@objc(TrackItem)
public class TrackItem: NSManagedObject {

    @NSManaged public var date: String?
    @NSManaged public var kms: Int32
    @NSManaged public var liters: Float

}
