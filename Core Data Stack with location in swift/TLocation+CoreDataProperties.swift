//
//  TLocation+CoreDataProperties.swift
//  Core Data Stack with location in swift
//
//  Created by AkashBuzzyears on 1/15/20.
//  Copyright © 2020 akash soni. All rights reserved.
//
//

import Foundation
import CoreData


extension TLocation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TLocation> {
        return NSFetchRequest<TLocation>(entityName: "TLocation")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var subtitle: Int16
    @NSManaged public var title: String?
    @NSManaged public var id: String?

}
