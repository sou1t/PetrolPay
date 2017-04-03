//
//  Networking.swift
//  Concier
//
//  Created by NikoGenn on 06.10.16.
//  Copyright © 2016 nmaidanov. All rights reserved.
//

import Foundation

enum Networking {
    
    typealias JSON = [String:Any]
    typealias RequestCallback<T:Networkable> = ([T]) -> ()
    typealias JSONCallback = ([JSON])->()
    
    enum RequestType:String {
        case GET
        case POST
    }
    
    static private func request<T:Networkable>(with type:RequestType, url:URL, parameters:JSON, callback:@escaping RequestCallback<T>) {
        let requestURL = type == .GET ? try! url+parameters : url
        var request = URLRequest(url: requestURL)
        request.httpMethod = type.rawValue
        //    TODO: POST params
        URLSession.shared.dataTask(with: request) {data, _, _ in
            let json = try? JSONSerialization.jsonObject(with: data!, options: [])
            guard let jsonDicts = json as? [JSON] else {callback([["value":json as! [Any]]].flatMap(T.parse)); return }
            callback(jsonDicts.flatMap(T.parse))
            }.resume()
    }
    
    static private func request(with type:RequestType, url:URL, parameters:JSON, callback:@escaping JSONCallback) {
        let requestURL = type == .GET ? try! url+parameters : url
        var request = URLRequest(url: requestURL)
        request.httpMethod = type.rawValue
        //    TODO: POST params
        URLSession.shared.dataTask(with: request) {data, _, _ in
            let json = try? JSONSerialization.jsonObject(with: data!, options: [])
            guard let jsonDicts = json as? [JSON] else { callback([]); return }
            callback(jsonDicts)
            }.resume()
    }
    
    static public func GET<T:Networkable>(url:URL, parameters:JSON? = nil, model:T.Type? = nil, callback:@escaping RequestCallback<T>) {
        request(with: .GET, url: url, parameters: parameters ?? JSON(), callback:callback)
    }
    static public func GET(url:URL, parameters:JSON? = nil, callback:@escaping JSONCallback) {
        request(with: .GET, url: url, parameters: parameters ?? JSON(), callback:callback)
    }
    static public func POST<T:Networkable>(url:URL, parameters:JSON? = nil, model:T.Type? = nil, callback:@escaping RequestCallback<T>) {
        request(with: .POST, url: url, parameters: parameters ?? JSON(), callback:callback)
    }
    
}

protocol Networkable {
    static func parse(json: Networking.JSON) -> Self?
}

enum ParseError: Error {
    case InvalidParameter
    case InvalidURL
}

infix operator =>
func => <T>(left: Networking.JSON, right: String) throws -> T {
    guard let item = left[right], let res = item as? T else { throw ParseError.InvalidParameter }
    return res
}
infix operator ~>
func ~> <T:Networkable>(left: Networking.JSON, right: String) -> T? {
    guard let item = left[right], let json = item as? Networking.JSON, let res = T.parse(json: json) else { return nil }
    return res
}

infix operator =?>
func =?> <T>(left: Networking.JSON, right: String) throws -> T? {
    let item = left[right]
    guard let res = item as? T else { return nil }
    return res
}

extension URL {
    
    static let basicURLString = "https://www.onlinetours.ru/api/v2/mobile_api/"
    static let basicURL = URL(string: URL.basicURLString)!
    
    static let allOffices = URL(string: URL.basicURLString+"offices")!
    static let feed = URL(string: URL.basicURLString+"feed")!
    static let countries = URL(string: URL.basicURLString+"countries")!
    static let departCities = URL(string: URL.basicURLString+"depart_cities")!
    static let tags = URL(string: URL.basicURLString+"region_tags")!
    static let durations = URL(string: URL.basicURLString+"durations")!
    
    static func + (left: URL, right: Networking.JSON) throws -> URL {
        guard !right.isEmpty else { return left }
        let paramsString = (right.flatMap({ (key, value) -> String in
            return "\(key)=\(value)"
        }) as Array).joined(separator: "&")
        guard let url = URL(string:left.absoluteString+"?"+paramsString) else { throw ParseError.InvalidURL }
        return url
    }
}
