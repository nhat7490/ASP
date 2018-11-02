//
//  APIConnection.swift
//  Roommate
//
//  Created by TrinhHC on 10/9/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
class APIConnection: NSObject {
    static func isConnectedInternet()->Bool{
        return NetworkReachabilityManager()!.isReachable
    }
    static func requestArray<T:Mappable>(apiRouter:APIRouter,errorNetworkConnectedHander handler:(()->Void)?,returnType:T.Type,completion:@escaping (_ result:[T]?,_ error:ApiResponseErrorType?,_ statusCode:HTTPStatusCode?)->(Void)){
        //Network handler
        if !isConnectedInternet(){
            if let handler = handler{
                handler()
                return
            }
        }
        print(apiRouter)
        Alamofire.request(apiRouter).responseArray { (response:DataResponse<[T]>) in
            //Fail to connect to server
            if let _ = response.error{
                //Http response nil: Timeout or cannot connect
                if response.response == nil {
                    completion(nil,ApiResponseErrorType.SERVER_NOT_RESPONSE,nil)
                    //Error to convert json to object
                }else{
                    //Default code 404 when return from server
                    completion(nil, .PARSE_RESPONSE_FAIL, .NotFound)
                }
                //Success
            }else{
                guard let code = response.response?.statusCode,let httpStatusCode = HTTPStatusCode(rawValue: code) else{
                    return
                }
                //Default success code 200
                if httpStatusCode == .OK{
                    completion(response.result.value,nil,.OK)
                }else{
                    completion(nil,nil,httpStatusCode)
                }
            }
        }
    }
    static func requestObject<T:Mappable>(apiRouter:APIRouter,errorNetworkConnectedHander handler:(()->Void)?,returnType:T.Type,completion:@escaping (_ result:T?,_ error:ApiResponseErrorType?,_ statusCode:HTTPStatusCode?)->(Void)){
        //Network handler
        if !isConnectedInternet(){
            if let handler = handler{
                handler()
                return
            }
        }
        Alamofire.request(apiRouter).responseObject { (response:DataResponse<T>) in
            //Fail to connect to server
            if let _ = response.error{
                //Http response nil: Timeout or cannot connect
                if response.response == nil {
                    completion(nil,ApiResponseErrorType.SERVER_NOT_RESPONSE,nil)
                    //Error to convert json to object
                }else{
                    //Default code 404 when return from server
                    completion(nil, .PARSE_RESPONSE_FAIL,HTTPStatusCode(rawValue: (response.response?.statusCode)!) ?? .NotFound)
                }
                //Success
            }else{
                guard let code = response.response?.statusCode,let httpStatusCode = HTTPStatusCode(rawValue: code) else{
                    return
                }
                //Default success code 200
                if httpStatusCode == .OK{
                    completion(response.result.value,nil,.OK)
                }else{
                    completion(nil,nil,httpStatusCode)
                }
            }
            
        }
        
    }
    static func request(apiRouter:APIRouter,errorNetworkConnectedHander handler:(()->Void)?,completion:@escaping (_ error:ApiResponseErrorType?,_ statusCode:HTTPStatusCode?)->(Void)){
        //Network handler
        if !isConnectedInternet(){
            if let handler = handler{
                handler()
                return
            }
        }
        
        Alamofire.request(apiRouter).response { (response) in
            //Fail to connect to server
            if let _ = response.error{
                //Http response nil: Timeout or cannot connect
                if response.response == nil {
                    completion(ApiResponseErrorType.SERVER_NOT_RESPONSE,nil)
                    //Error to convert json to object
                }
                //Success
            }else{
                guard let code = response.response?.statusCode,let httpStatusCode = HTTPStatusCode(rawValue: code) else{
                    return
                }
                completion(nil,httpStatusCode)
            }
            
        }
        
    }
}
