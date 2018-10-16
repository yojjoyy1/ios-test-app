//
//  GetGoogleSheetAPi.swift
//  test
//
//  Created by sinyilin on 2018/9/27.
//  Copyright © 2018年 sinyilin. All rights reserved.
//

import UIKit

class GetGoogleSheetAPi: NSObject
{

    func googleAPi(success:@escaping(Int,NSArray) -> Void)
    {
        var count:Int!
        var jsonArr:NSArray!
        let url = URL(string: "https://sheetsu.com/apis/v1.0su/7849fac019b2")
        let request : NSMutableURLRequest = NSMutableURLRequest()
        request.url = url
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { (data, res, err) in
//            print("data:\(data),res:\(res),err:\(err)")
//            let dataStr = String.init(data: data!, encoding: .utf8)
//            print("dataStr:\(dataStr)")
            do
            {
//                let jsonData = try JSONSerialization.data(withJSONObject: dataStr!, options: [])
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                jsonArr = json as! NSArray
                count = jsonArr.count
                success(count,jsonArr)
            }
            catch
            {
                print("err:\(error.localizedDescription)")
            }
        }
        task.resume()
        /*
        do
        {
            let data = try Data(contentsOf: url!)
            let dataStr = String.init(data: data, encoding: .utf8)
            print("dataStr:\(dataStr)")
        }
        catch
        {
            print("error:\(error.localizedDescription)")
        }
        */
    }
}
