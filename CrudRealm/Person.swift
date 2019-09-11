//
//  Person.swift
//  CrudRealm
//
//  Created by Thiago Valente on 11/09/19.
//  Copyright © 2019 Thiago Valente. All rights reserved.
//

import Foundation
import RealmSwift

class Person: Object {
    @objc dynamic var name = ""
    @objc dynamic var age = 0
    @objc dynamic var created = Date()
}
