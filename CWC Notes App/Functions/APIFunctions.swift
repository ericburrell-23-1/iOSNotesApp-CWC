//
//  APIFunctions.swift
//  CWC Notes App
//
//  Created by Eric Burrell on 11/15/22.
//

import Foundation
import Alamofire

let networkIP = "10.0.0.111"
let customAllowedSet =  NSCharacterSet(charactersIn:"\"”“„’‘…–—•₩€₽%<>\\^`{|}\n").inverted

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
    
    func fetchNotes(completionHandler: (() -> Void)? = {}) {
        AF.request("http://\(networkIP):8081/fetch")
            .response { response in
                let data = String(data: response.data ?? Data([]), encoding: .utf8)
                // print("Data is " + data!)
                self.delegate?.updateArray(with: data!)
            }
        completionHandler!()
    }
    
    func addNote(date: String, title: String, note: String) {
        let escapedNote = note.addingPercentEncoding(withAllowedCharacters: customAllowedSet)
        let escapedTitle = title.addingPercentEncoding(withAllowedCharacters: customAllowedSet)
        let headers: HTTPHeaders = [
            "title" : escapedTitle!,
            "date" : date,
            "note" : escapedNote!
        ]
        AF.request("http://\(networkIP):8081/create", method: .post, encoding: URLEncoding.httpBody, headers: headers)
            .resume()
    }
    
    func updateNote(date: String, title: String, note: String, id: String) {
//        for scalar in note.unicodeScalars {
//            print("\(scalar.value) ", terminator: "")
//        } //DEBUGGING
        let escapedNote = note.addingPercentEncoding(withAllowedCharacters: customAllowedSet)
        let escapedTitle = title.addingPercentEncoding(withAllowedCharacters: customAllowedSet)
        let headers: HTTPHeaders = [
            "title" : escapedTitle!,
            "date" : date,
            "note" : escapedNote!,
            "id" : id
        ]
        // print(headers)
        AF.request("http://\(networkIP):8081/update", method: .post, encoding: URLEncoding.httpBody, headers: (headers))
            .resume()
    }
    
    func deleteNote(id: String) {
        let header: HTTPHeaders = ["id" : id]
        AF.request("http://\(networkIP):8081/delete", method: .post, encoding: URLEncoding.httpBody, headers: header)
            .resume()
    }
}
