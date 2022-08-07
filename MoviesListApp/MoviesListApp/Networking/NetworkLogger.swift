//
//  NetworkLogger.swift
//  MoviesListApp
//
//  Created by Manish Dabhi on 05/08/22.
//

import Foundation

struct NetworkLogger {
    static func log(request: URLRequest) {
        print("\n - - - - - - - - - - Request Start - - - - - - - - - - \n")
        defer { print("\n - - - - - - - - - - Request End - - - - - - - - - - \n") }
        
        let urlAsString = request.url?.absoluteString ?? ""
        let method = request.httpMethod != nil ? "\(request.httpMethod ?? "")" : ""
        
        var logOutput = """
                        Request Method :-> \(method)
                        Request URL :-> \(urlAsString) \n\n
                        """
        for (key,value) in request.allHTTPHeaderFields ?? [:] {
            logOutput += "\(key): \(value) \n"
        }
        if let body = request.httpBody {
            logOutput += "\n \(NSString(data: body, encoding: String.Encoding.utf8.rawValue) ?? "")"
        }
        
        print(logOutput)
    }
    
    static func log(response: Data) {
        print("\n - - - - - - - - - - Response Start - - - - - - - - - - \n")
        defer { print("\n - - - - - - - - - - Response End - - - - - - - - - - \n") }
        guard let object = try? JSONSerialization.jsonObject(with: response, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = String(data: data, encoding:.utf8) else { return }
        print(prettyPrintedString)
    }
}
