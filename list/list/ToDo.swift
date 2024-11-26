//
//  ToDo.swift
//  list
//
//  Created by student-2 on 23/11/24.
//

import UIKit
struct ToDo:Equatable,Codable{
    let id:UUID
    var title:String
    var isComplete:Bool
    var dueDate:Date
    var notes:String?
    static func ==(lhs:ToDo,rhs:ToDo)->Bool{
        return lhs.id==rhs.id
    }
    init(title: String, isComplete: Bool, dueDate: Date, notes: String? = nil) {
        self.id = UUID()
        self.title = title
        self.isComplete = isComplete
        self.dueDate = dueDate
        self.notes = notes
    }
    static func loadSampleToDos()->[ToDo]{
        let do1 = ToDo(title: "To-Do-One", isComplete: false, dueDate: Date(),notes: "Notes1")
        let do2 = ToDo(title: "To-Do-Two", isComplete: false, dueDate: Date(),notes: "Notes2")
        let do3 = ToDo(title: "To-Do-Three", isComplete: false, dueDate: Date(),notes: "Notes3")
        let do4 = ToDo(title: "To-Do-Four", isComplete: false, dueDate: Date(),notes: "Notes4")
        return [do1,do2,do3,do4]
    }
    static func loadToDos()->[ToDo]?{
        guard let codedToDos = try? Data(contentsOf: archiveURL) else{return nil}
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<ToDo>.self, from: codedToDos)
    }
    static func savedToDos(_ todos:[ToDo]){
        let propertyListEncoder = PropertyListEncoder()
        let codedToDos = try? propertyListEncoder.encode(todos)
        try? codedToDos?.write(to: archiveURL,options: .noFileProtection)
    }
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("toDos").appendingPathExtension("pList")
}
