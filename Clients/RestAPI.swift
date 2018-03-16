//
//  RestAPI.swift
//  MDB Socials
//
//  Created by Mudabbir Khan on 3/14/18.
//  Copyright © 2018 MHK. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import PromiseKit

public enum ResourceNotFoundError: Error {
    case resourceNotFound
}

extension ResourceNotFoundError: LocalizedError {
    public var errorDescription: String? {
        return "The requested resource was not found in the database."
    }
}

public enum RequestTimedOutError: Error {
    case requestTimedOut
}

extension RequestTimedOutError: LocalizedError {
    public var errorDescription: String? {
        return "The network request timed out."
    }
}
class RestAPIClient {
//    static func getUser(id: String) -> Promise<Users> {
//        return Promise { fulfill, reject in
//            after(interval: 10).then { _ -> Void in
//                reject(RequestTimedOutError.requestTimedOut)
//            }
//            let endpoint = Constants.apiURL + "users?userId=\(id)"
//            Alamofire.request(endpoint).responseJSON().then { response -> Void in
//                let json = JSON(response)
//                log.info("Response: \(json.description)")
//                if let result = json["result"].dictionaryObject {
//                    if let user = Users(JSON: result) {
//                        fulfill(user)
//                    }
//                }
//                }.catch { error in
//                    log.error(error.localizedDescription)
//                    reject(error)
//            }
//        }
//    }
//
//    static func userExists(id: String) -> Promise<Bool> {
//        return Promise { fulfill, reject in
//            after(interval: 10).then { _ -> Void in
//                reject(RequestTimedOutError.requestTimedOut)
//            }
//            let endpoint = Constants.apiURL  + "users?userId=\(id)"
//            Alamofire.request(endpoint).responseJSON().then { response -> Void in
//                let json = JSON(response)
//
//                log.info("Response: \(json.description)")
//                if let result = json["result"].dictionaryObject {
//                    if let _ = Users(JSON: result) {
//                        fulfill(true)
//                    } else {
//                        fulfill(false)
//                    }
//                } else {
//                    fulfill(false)
//                }
//                }.catch { error in
//                    log.error(error.localizedDescription)
//                    fulfill(false)
//            }
//        }
//    }
//
//
//    static func createUser(userId: String, email: String, fullName: String, profPicUrl: String, fbId: String) -> Promise<Users> {
//        return Promise { fulfill, reject in
//            after(interval: 10).then { _ -> Void in
//                reject(RequestTimedOutError.requestTimedOut)
//            }
//            let endpoint = Constants.apiURL + "users"
//            let params: [String: Any] = ["userId": userId,
//                                         "email": email,
//                                         "fullName": fullName,
//                                         "profPicUrl": profPicUrl,
//                                         "fbId": fbId]
//            Alamofire.request(endpoint, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON().then { response -> Void in
//                let json = JSON(response)
//                log.info("Response: \(json.description)")
//                if let result = json["result"].dictionaryObject {
//                    if let user = Users(JSON: result) {
//                        fulfill(user)
//                    }
//                }
//                }.catch { error in
//                    log.error(error.localizedDescription)
//                    reject(error)
//            }
//        }
//    }
}
