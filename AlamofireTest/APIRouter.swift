//
//  APIRouter.swift
//  AlamofireTest
//
//  Created by zmjios on 16/3/30.
//  Copyright © 2016年 zmjios. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

enum APIRouter: URLRequestConvertible
{
    static let BASE_URL = "" //base url
    static let API_KEY = "" //api key, consumer secret for OAuth, etc
    
    case User(Int)
    case ProfilePicture(Int, Int)
    case Likes(Int, Int)
    
    var URLRequest: NSMutableURLRequest
    {
        let result:(path: String, parameters:[String: AnyObject]?) =
        {
            switch self
            {
            case .User (let page):
                let params = ["test":NSNumber.init(integer: page)]
                return ("/user/\(page)",params)
            case .ProfilePicture(let id, let size):
                var params = []
                return ("/profilepictures/\(id)", nil)
            case .Likes(let id, let commentsPage):
                var params = []
                return ("/likes/\(id)/user", nil)
            }
            
        }()
        let URL = NSURL(string: APIRouter.BASE_URL)
        let URLRequest = NSURLRequest(URL:URL!.URLByAppendingPathComponent(result.path))
        let encoding = Alamofire.ParameterEncoding.URL
        let (encoded, _) = encoding.encode(URLRequest, parameters: result.parameters)
        
        
        return encoded
    }
}


enum Router: URLRequestConvertible
{
    static let baseURLString = "http://jsonplaceholder.typicode.com/"

    
    case Get(Int)
    case Create([String: AnyObject])
    case Delete(Int)
    
    var URLRequest: NSMutableURLRequest
    {
        var method: Alamofire.Method
        {
            switch self
            {
            case .Get:
                return .GET
            case .Create:
                return .POST
            case .Delete:
                return .DELETE
            }
        }
        
        // constant result that returns a tuple.  you can pic result.path or result.parameters
        let result: (path: String, parameters: [String: AnyObject]?) = {
            switch self {
            case .Get(let postNumber):
                return ("posts/\(postNumber)", nil)
            case .Create(let newPost):
                return ("posts", newPost)
            case .Delete(let postNumber):
                return ("posts/\(postNumber)", nil)
            }
        }()
        
        let URL = NSURL(string: Router.baseURLString)!
        let URLRequest = NSURLRequest(URL: URL.URLByAppendingPathComponent(result.path))
        
        let encoding = Alamofire.ParameterEncoding.JSON
        let (encoded, _) = encoding.encode(URLRequest, parameters: result.parameters)
        
        encoded.HTTPMethod = method.rawValue
        
        return encoded
    }
}

