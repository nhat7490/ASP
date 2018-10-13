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
    case search(input:String)

    var httpHeaders:HTTPHeaders{
        switch self{
        case .search:
            return [:]
        default:
            return ["Accept":"application/json"]
        }
    }

    var httpMethod:HTTPMethod{
        switch self{
        case .findById:
            return .get
        case .login:
            return .post
        case .search:
            return .get
        }
    }

    var path:String{
        switch self{
            case .findById(let id):
                return "findById/\(id)"
            case .login:
                return "user/login"
            case .search:
                return "maps/api/place/autocomplete/json"
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
        case .search(let input):
            return ["language":"vi",
                    "input":input,
                    "components":"country:vi",
                    "key":"AIzaSyCOgT-ZG2h-mTHElFEiv_3EJXFTppNgIAk"]
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url:URL
        switch self{
            case .search:
                url = try! Constants.BASE_URL_GOOGLE_PLACE_API.asURL()
            default:
                url = try!  Constants.BASE_URL_API.asURL()
        }
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.allHTTPHeaderFields = httpHeaders
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.timeoutInterval  = 5

        do{
            switch self.httpMethod {
            case .post:
                urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
            default:
                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
            }
        }catch {
            print("Create Request error In APIRouter:\(error)")
        }

        return urlRequest
    }
}
