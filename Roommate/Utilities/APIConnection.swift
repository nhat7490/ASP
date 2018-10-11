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
    static func request<T:Mappable>(apiRouter:APIRouter,errorNetworkConnectedHander handler:(()->Void)?,returnType:T.Type,completion:@escaping (_ result:[T]?,_ error:ApiResponseErrorType?,_ statusCode:HTTPStatusCode?)->(Void)){
        //Network handler
        if !isConnectedInternet(){
            guard let handler = handler else{
                return
            }
            handler()
            return
        }
        
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
    static func request<T:Mappable>(apiRouter:APIRouter,errorNetworkConnectedHander handler:(()->Void)?,returnType:T.Type,completion:@escaping (_ result:T?,_ error:ApiResponseErrorType?,_ statusCode:HTTPStatusCode?)->(Void)){
        //Network handler
        if !isConnectedInternet(){
            guard let handler = handler else{
                return
            }
            handler()
            return
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
//            if response.response == nil{
//                print("FAILURE:\(response.result.value)")
//                completion(nil,ApiResponseErrorType.SEVER_NOT_RESPONSE,nil)
//            }else{
//                //Success connected with response
//                //Success mapping response to usermodel
//                let statusCode:HTTPStatusCode = HTTPStatusCode(rawValue: response.response!.statusCode)!
//                if response.result.isSuccess{
//                    if statusCode == .OK{
//                        completion(response.result.value,nil,statusCode)
//                    }else {
//                        completion(nil,nil,statusCode)
//                    }
//                    //Fail to convert response to Usermodel
//                }else if response.result.isFailure{
//                    //error when parse response
//                    if statusCode == 404{
//                        completion(nil,ApiResponseErrorType.API_ERROR,response)
//                    }
//                }
//            }
//            switch response.result{
//            case .success:
//                let statusCode = HTTPStatusCode(rawValue: (response.response?.statusCode)!)!
//                switch statusCode{
//                    case .OK:
//                        let t:T = response.result.value!
//                        completion(t,nil,statusCode)
//                    case .Created:
//                        completion(nil,nil,statusCode)
////                    case .NotFound:
////                        completion(nil,ApiResponseErrorType.INPUT_ERROR,statusCode)
//                    case .InternalServerError:
//                        completion(nil,ApiResponseErrorType.API_ERROR,statusCode)
//                    default:
//                        completion(nil,ApiResponseErrorType.HTTP_ERROR,statusCode)
//                }
//            case .failure:
//                completion(nil,ApiResponseErrorType.HTTP_ERROR,nil)
//
//            }
         }

    }
}
