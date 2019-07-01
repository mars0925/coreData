//
//  Car+CoreDataProperties.swift
//  designCoreData
//
//  Created by Mars on 2019/7/1.
//  Copyright © 2019 drs24. All rights reserved.
//
//

import Foundation
import CoreData


extension Car {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Car> {
        return NSFetchRequest<Car>(entityName: "Car")
    }

    @NSManaged public var plate: String?
    @NSManaged public var belongto: UserData?

}
