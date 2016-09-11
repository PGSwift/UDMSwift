//
//  AlamofireManager.swift
//  UDMSwift
//
//  Created by OSXVN on 9/10/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import Foundation
import Alamofire

final class AlamofireManager {
    
    static func requestUrlByPOST(withURL url: String, paramater: [String: AnyObject], Completion completion: ((data: [String: AnyObject], success: Bool) ->Void)?) {
        
        var result: [String: AnyObject]? = [:]
        
        let paramaterx: [String: AnyObject] = ["data":
                            ["fullName":"CCCCCC"
                            ,"sex":"1"]
                            ]
        
        Alamofire.request(.POST, url, parameters: paramaterx)
            .responseJSON { response in
                
                print(response.request)
                
                println("-->\(String(data: response.data!, encoding:NSUTF8StringEncoding)!)")
                if response.result.isSuccess {
                    
                    guard let resultQ = UDMHelpers.convertStringToDictionary(String(data: response.data!, encoding:NSUTF8StringEncoding)!) else {
                        println("Do not convert data to dictionary at data get from Server")
                        return
                    }
                    result = resultQ
                } else {
                    result = nil
                }
                
                guard let completion = completion else {
                    println("Not found clouse completion")
                    return
                }
                
                guard let rs = result else {
                    println("Data from Server = nil")
                    completion(data: ["message":"Data get from server nil"],success: false)
                    return
                }
                
                let isSuccess = rs["status"] as! String == "SUCCESS" ? true : false
                
                completion(data: rs, success: isSuccess)
        }
    }
    
    static func requestUrlByPOST(withURL url: String, paramater: [String: String], encode: ParameterEncoding, Completion completion: ((data: [String: AnyObject], success: Bool) ->Void)?) {
        
        var result: [String: AnyObject]? = [:]
        
        Alamofire.request(.POST, url, parameters: paramater, encoding: encode)
            .responseJSON { response in
                
                print(response.request)
                
                if response.result.isSuccess {
                    guard let resultQ = UDMHelpers.convertStringToDictionary(String(data: response.data!, encoding:NSUTF8StringEncoding)!) else {
                        println("Do not convert data to dictionary at data get from Server")
                        return
                    }
                    result = resultQ
                } else {
                    result = nil
                }
                
                guard let completion = completion else {
                    println("Not found clouse completion")
                    return
                }
                
                guard let rs = result else {
                    println("Data from Server = nil")
                    completion(data: ["message":"Data get from server nil"],success: false)
                    return
                }
                
                let isSuccess = rs["status"] as! String == "SUCCESS" ? true : false
                
                completion(data: rs, success: isSuccess)
        }
    }
    
}
