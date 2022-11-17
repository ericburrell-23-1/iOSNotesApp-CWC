//
//  APIFunctions.swift
//  CWC Notes App
//
//  Created by Eric Burrell on 11/15/22.
//

import Foundation
import Alamofire

let networkIP = "10.0.0.111"

struct Note: Decodable, Hashable {
    var _id: String
    var title: String
    var note: String
    var date: String
}

protocol DataDelegate {
    mutating func updateArray(with: String)
}

class APIFunctions {
    var delegate: DataDelegate?
    static let functions = APIFunctions()
    
    func fetchNotes() {
        AF.request("http://\(networkIP):8081/fetch")
            .response { response in
                let data = String(data: response.data ?? Data([]), encoding: .utf8)
                print("Data is " + data!)
                self.delegate?.updateArray(with: data!)
            }
    }
}
