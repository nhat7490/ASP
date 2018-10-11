//
//  APIRouter.swift
//  Roommate
//
//  Created by TrinhHC on 10/5/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
enum ApiResponseErrorType{
    case HTTP_ERROR,API_ERROR,SERVER_NOT_RESPONSE,PARSE_RESPONSE_FAIL
    
}
enum APIRouter:URLRequestConvertible{
    case findById(id:Int)
    case login(username:String,password:String)

    var httpHeaders:HTTPHeaders{
        let headers = ["Accept":"application/json"]
        return headers
    }

    var httpMethod:HTTPMethod{
        switch self{
        case .findById:
            return .get
        case .login:
            return .post
        }
    }

    var path:String{
        switch self{
            case .findById(let id):
                return "findById/\(id)"
            case .login:
                return "user/login"
        }
    }

    var parameters:Parameters{
        switch self{
            case .findById:
                return [:]
            case .login(let username,let password):
                let dic = [
                    "username":username,
                    "password":password
                ]
                return dic
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = try! "http://localhost:8080/".asURL()

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))

        urlRequest.allHTTPHeaderFields = httpHeaders
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.timeoutInterval  = 5

        do{
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        }catch {
            print("Create Request error In APIRouter:\(error)")
        }

        return urlRequest
    }
}
