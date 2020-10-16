//
//  Person.swift
//  PairRandomizer
//
//  Created by Owen Barrott on 10/16/20.
//  Copyright © 2020 Owen Barrott. All rights reserved.
//

import Foundation
import CloudKit

struct PersonStrings {
    static let recordTypeKey = "Person"
    fileprivate static let nameKey = "name"
}

class Person {
    
    var name: String
    
    var recordID: CKRecord.ID
    
    init(name: String, recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.name = name
        
        self.recordID = recordID
    }
}

// MARK: - Extension
extension Person {
    convenience init?(ckRecord: CKRecord) {
        guard let name = ckRecord[PersonStrings.nameKey] as? String else { return nil }
        self.init(name: name, recordID: ckRecord.recordID)
    }
}

extension Person: Equatable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.recordID == rhs.recordID
    }
}

extension CKRecord {
    convenience init(person: Person) {
        self.init(recordType: PersonStrings.recordTypeKey, recordID: person.recordID)
        self.setValuesForKeys([
            PersonStrings.nameKey : person.name
        ])
    }
}
