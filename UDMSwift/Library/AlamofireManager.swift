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
    
    static let shareInstance = AlamofireManager()
    
    func requestUrlByPOST(withURL url: String, paramater: [String: AnyObject], Completion completion: ((data: [String: AnyObject], success: Bool) ->Void)?) {
        
        var result: [String: AnyObject]? = [:]
        
        var jsontext = ""
        
        do {
            
            let jsonData = try NSJSONSerialization.dataWithJSONObject(paramater, options: NSJSONWritingOptions.PrettyPrinted)
            jsontext = String(data: jsonData, encoding: NSASCIIStringEncoding)!
        } catch let error as NSError {
            println(error)
        }
        
        jsontext = "data="+jsontext
        
        Alamofire.request(.POST, url, parameters: [:], encoding: .Custom({
            (convertible, params) in
            let mutableRequest = convertible.URLRequest.copy() as! NSMutableURLRequest
            let data = jsontext.dataUsingEncoding(NSUTF8StringEncoding)
            mutableRequest.HTTPBody = data
            return (mutableRequest, nil)
        }))
            .responseJSON { response in
                
                println("Url request: \(response.request)")
                
                println("-----> Data from server: \(String(data: response.data!, encoding:NSUTF8StringEncoding)!)")
                
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
                    println("Data from Server = \(result)")
                    completion(data: ["message":"Data get from server nil"],success: false)
                    return
                }
                
                let isSuccess = rs["status"] as! String == "SUCCESS" ? true : false
                
                completion(data: rs, success: isSuccess)
        }
    }

    func requestUrlByPOST(withURL url: String, paramater: [String: String], encode: ParameterEncoding, Completion completion: ((data: [String: AnyObject], success: Bool) ->Void)?) {
        
        var result: [String: AnyObject]? = [:]
        
        Alamofire.request(.POST, url, parameters: paramater, encoding: encode)
            .responseJSON { response in
                
                print("---> URL: \(response.request)")
                
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
