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
    case placeDetail(id:String)
    case city()
    case district()
    case utility()
    case createRoom(model:RoomResponseModel)
    case postForAll(model:FilterArgumentModel)
    case postForBookmark(model:FilterArgumentModel)
    case createBookmark(model:BookmarkRequestModel)
    case removeBookmark(favoriteId:Int)
    case suggestBestMatch(model:FilterArgumentModel)
    case suggest(model:BaseSuggestRequestModel)
    case getRoomsByUserId(userId:Int,page:Int,size:Int)
    case getHistoryRoom(userId:Int,page:Int,size:Int)
    case getCurrentRoom(userId:Int)
    case getUserPost(model:FilterArgumentModel)
    case findUserByUsername(username:String)
    case editMember(roomMemberRequestModel:RoomMemberRequestModel)
    case removeRoom(roomId:Int)
    case updateRoom(model:RoomResponseModel)
    
    var httpHeaders:HTTPHeaders{
        switch self{
        case .search:
            return [:]
        default:
            return ["Accept":"application/json"]
        }
    }
    
    var httpMethod:HTTPMethod{
        switch self{ case .login,.createRoom,.postForAll,.postForBookmark,.createBookmark,.suggestBestMatch,.suggest,.editMember,.getUserPost:
            return .post
        case .removeBookmark,.removeRoom:
            return .delete
        case .updateRoom:
            return .put
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
        case .placeDetail:
            return "maps/api/place/details/json"
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
        case .removeBookmark(let favoriteId):
            return "favourite/remove/\(favoriteId)"
        case .suggestBestMatch:
            return "post/suggestBestMatch"
        case .suggest:
            return "post/suggest"
        case .getRoomsByUserId(let userId,_,_):
            return "room/user/\(userId)"
        case .findUserByUsername(let username):
            return "user/findByUsername/\(username)"
        case .editMember:
            return "room/editMember"
        case .removeRoom(let roomId):
            return "room/deleteRoom/\(roomId)"
        case .updateRoom:
            return "room/update";
        case .getCurrentRoom(let userId):
            return "room/user/currentRoom/\(userId)";
        case .getHistoryRoom(let userId,_,_):
            return "room/user/history/\(userId)";
        case .getUserPost:
            return "post/userPost"
            
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
                    "components":"country:VN",
                    "types":"address",
                    "key":Constants.GOOGLE_PLACE_API_KEY]
        case .placeDetail(let id):
            return ["language":"vi",
                    "placeid":id,
                    "fields":"formatted_address,geometry",
                    "key":Constants.GOOGLE_PLACE_API_KEY]
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
        case .suggest(let model):
            return Mapper().toJSON(model)
        case .getRoomsByUserId(_,let page,let size):
            return ["page":page,
                    "size":size]
        case .editMember(let model):
            return Mapper().toJSON(model)
        case .updateRoom(let model):
            return Mapper().toJSON(model)
        case .getUserPost(let model):
            return Mapper().toJSON(model)
        default:
            return [:]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url:URL
        switch self{
        case .search,.placeDetail:
            url = try! Constants.BASE_URL_GOOGLE_PLACE_API.asURL()
        default:
            url = try!  Constants.BASE_URL_API.asURL()
        }
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.allHTTPHeaderFields = httpHeaders
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.timeoutInterval  = 10
        
        do{
            switch self.httpMethod {
            case .post,.put:
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
