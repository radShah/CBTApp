//
//  Thought.swift
//  CBTApp
//
//  Created by Radha on 5/12/16.
//  Copyright © 2016 TurnToTech. All rights reserved.
//

import Foundation
import CoreData

@objc(Model)
class Model : NSManagedObject {
    @NSManaged var emotion : String
    @NSManaged var action : String
    @NSManaged var activatingEvent : String
    @NSManaged var thinkingError : String
    @NSManaged var belief : String
    
}
