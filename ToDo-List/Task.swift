//
//  Task.swift
//  ToDo-List
//
//  Created by Daniel Yamrak on 02.06.2021.
//

import Foundation

struct Task: Codable, Equatable {
    
//    enum Priority {
//        case high, normal, low
//    }
    
    var title: String
    var description: String
    var isDone = false
//    var priority: Priority = .normal
    
}
