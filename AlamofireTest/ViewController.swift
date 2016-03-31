//
//  ViewController.swift
//  AlamofireTest
//
//  Created by zmjios on 16/3/28.
//  Copyright © 2016年 zmjios. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        testLogin()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func testRequest1() -> Void {
        
        Alamofire.request(.GET, "https://httpbin.org/get", parameters: ["foo": "bar"])
            .responseJSON { response in
                
                print(response.request)  // 请求对象
                print(response.response) // 响应对象
                print(response.data)     // 服务端返回的数据
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
                
        }
    }
    
    
    func testRequest2() -> Void {
       
        
        let BaiduURL = "http://apis.haoservice.com/lifeservice/cook/query?"
        
        let parameters = [
            "menu": "土豆",
            "pn":  1,
            "rn": "10",
            "key": "2ba215a3f83b4b898d0f6fdca4e16c7c",
            ]
        
        Alamofire.request(.GET, BaiduURL, parameters: parameters).responseJSON{
            response in
            
            //尾随闭包
            
            switch response.result{
            case .Success:
                
                print(response.result.value)
                
                
                //把得到的JSON数据转为字典
                if let json = response.result.value as? NSDictionary{
                    //获取字典里面的key为数组
                    let Items = json.valueForKey("result")as! NSArray
                    //便利数组得到每一个字典模型
                    for dict in Items{
                        
                        print(dict)
                    }
                    
                }
            case .Failure(let error):
                print(error)
            }
            
        }
    }
    
    
    func testLogin() -> Void {
        let baseUrl = "http://120.26.99.0:9999/service/user/auth/userLogin?"
        let pwd = "123456"
        let despwd = pwd.stringFromMD5()
        let parameters = ["account":"zgp",
                          "despassword":despwd]
        
        Alamofire.request(.POST, baseUrl, parameters: parameters).responseSwiftyJSON{
            (_,_,JSON,error) in
            
            print(JSON)
        }
        
//        Alamofire.request(.GET, baseUrl, parameters: parameters).responseJSON{
//            response in
//            
//            
//            
//            
//        }
    }


}


//class X{
//    var value : Int? = 0
//    func value(number:Int) -> X
//    {
//        self.value! += 1
//        return self
//    }
//}
//
//
//extension X{
//    
//    func getValueNumber(number:Int) -> X {
//        return value(number)
//    }
//}

