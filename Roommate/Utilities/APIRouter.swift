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
    case city()
    case district()
    case utility()
    case createRoom(model:RoomRequestModel)
    case postForAll(model:FilterArgumentModel)
    case postForBookmark(model:FilterArgumentModel)
    case createBookmark(model:BookmarkRequestModel)
    case removeBookmark(id:Int)
    case suggestBestMatch(model:FilterArgumentModel)
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
        case .login,.createRoom,.postForAll,.postForBookmark,.createBookmark,.suggestBestMatch:
            return .post
        case .removeBookmark:
            return .delete
        default:
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
        case .city:
            return "city"
        case .district:
            return "district"
        case .createRoom:
            return "room/create"
        case .utility:
            return "utilities/getAll"
        case .postForAll:
            return "post/filter"
        case .postForBookmark:
            return "post/favouriteFilter"
        case .createBookmark:
            return "favourites/createFavourite"
        case .removeBookmark(let id):
            return "favourite/remove/\(id)"
        case .suggestBestMatch:
            return "post/suggestBestMatch"
        }
    }
    
    var parameters:Parameters{
        switch self{
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
        case .createRoom(let model):
            return Mapper().toJSON(model)
        case .postForAll(let model):
            return Mapper().toJSON(model)
        case .postForBookmark(let model):
            return Mapper().toJSON(model)
        case .createBookmark(let model):
            return Mapper().toJSON(model)
        case .suggestBestMatch(let model):
            return Mapper().toJSON(model)
        default:
            return [:]
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
        urlRequest.timeoutInterval  = 40
        
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
