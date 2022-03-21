//
//  Review+CoreDataProperties.swift
//  WeGoTrip
//
//  Created by  User on 19.03.2022.
//
//

import Foundation
import CoreData


extension Review {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Review> {
        return NSFetchRequest<Review>(entityName: "Review")
    }

    @NSManaged public var idTrip: Int32
    @NSManaged public var tripRate: Int32
    @NSManaged public var guideRate: Int32
    @NSManaged public var infoRate: Int32
    @NSManaged public var navigationRate: Int32
    @NSManaged public var wowEffect: String?
    @NSManaged public var improveView: String?

}
