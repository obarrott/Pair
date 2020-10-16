//
//  PersonController.swift
//  PairRandomizer
//
//  Created by Owen Barrott on 10/16/20.
//  Copyright © 2020 Owen Barrott. All rights reserved.
//

import Foundation


class PersonController {
    
    static let shared = PersonController()
    
    var people: [Int : Person] = [ : ]
    var keyArray: [Int] = []
    var peopleArray: [ Person ] = []
    
    // MARK: - CRUD Functions
    
    // Create
    func createPerson(name: String) {
        let newPerson = Person(name: name)
        peopleArray.append(newPerson)
    }
    // Randomize
    func randomizeList(dictionary: [Int : Person]) {
        keyArray = Array(people.keys)
        keyArray.shuffle()
    }
    
    // Delete
    func deletePerson(person: Person) {
        
    }
    
} // End of Class




//print(people.count)
//       people[people.count + 1] = newPerson
//       print("\(String(describing: people[people.count]?.name))")
////       keyArray = Array(people.keys)



