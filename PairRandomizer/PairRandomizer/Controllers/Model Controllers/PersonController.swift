//
//  PersonController.swift
//  PairRandomizer
//
//  Created by Owen Barrott on 10/16/20.
//  Copyright © 2020 Owen Barrott. All rights reserved.
//

import Foundation
import CloudKit


class PersonController {
    
    static let shared = PersonController()
    
    var people: [Int : Person] = [ : ]
    var keyArray: [Int] = []
    var peopleArray: [ Person ] = []
    
    let publicDB = CKContainer.default().publicCloudDatabase
    
    // MARK: - CRUD Functions
    
    
    // Create
    func createPerson(name: String, completion: @escaping (Result<Person, PersonError>) -> Void) {
        let newPerson = Person(name: name)
        let newRecord = CKRecord(person: newPerson)
        publicDB.save(newRecord) { (record, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            guard let record = record,
                let savedPerson = Person(ckRecord: record ) else { return completion(.failure(.couldNotUnwrap))}
            print("Saved Person successfully")
            completion(.success(savedPerson))
        }
    }
    
    //Fetches persons from the cloud and sets them to the source of truth.
      func fetchAllPersons(completion: @escaping (Result<[Person], PersonError>) -> Void) {
          let fetchAllPredicate = NSPredicate(value: true)
          let query = CKQuery(recordType: PersonStrings.recordTypeKey, predicate: fetchAllPredicate)
          publicDB.perform(query, inZoneWith: nil) { (records, error) in
              if let error = error {
                  return completion(.failure(.thrownError(error)))
              }
              guard let records = records else { return completion(.failure(.couldNotUnwrap)) }
              print("Fetched People sucessfully")
              let fetchedPeople = records.compactMap( { Person(ckRecord: $0) })
              completion(.success(fetchedPeople))
          }
      }
    
    
    // Randomize
    func randomizeList() {
        peopleArray.shuffle()
    }
    
    // Delete
     func delete(_ person: Person, completion: @escaping( Result<Bool, PersonError>) -> Void) {
           let operation = CKModifyRecordsOperation(recordsToSave: nil, recordIDsToDelete: [person.recordID])
           operation.savePolicy = .changedKeys
           operation.qualityOfService = .userInteractive
           operation.modifyRecordsCompletionBlock = { (_, recordIDs, error) in
               if let error = error {
                   return completion(.failure((.thrownError(error))))
               }
               guard let recordIDs = recordIDs else { return completion(.failure((.couldNotUnwrap)))}
               print("\(recordIDs) was removed successfully")
               completion(.success(true))
           }
           publicDB.add(operation)
       }
    
} // End of Class




//print(people.count)
//       people[people.count + 1] = newPerson
//       print("\(String(describing: people[people.count]?.name))")
////       keyArray = Array(people.keys)



