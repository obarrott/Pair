//
//  PersonError.swift
//  PairRandomizer
//
//  Created by Owen Barrott on 10/16/20.
//  Copyright © 2020 Owen Barrott. All rights reserved.
//

import Foundation

enum PersonError: LocalizedError {
    case thrownError(Error)
    case couldNotUnwrap
    
    var errorDescription: String {
        switch self {
        case .thrownError(let error):
            return "There was an error: \(error), \(error.localizedDescription)"
        case .couldNotUnwrap:
            return "Unable to unwrap result returned from \(#function)"
        }
    }
}
