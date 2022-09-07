//
//  NetwoorkService.swift
//  NetwoorkApp
//
//  Created by сергей on 6.09.22.
//

import Alamofire
import Foundation
import SwiftyJSON

class NetworkService {
    static func deletePost(postID: Int, callback: @escaping (_ result: JSON?, _ error: Error?) -> Void) {
        let url = ApiConstants.postsPath + "/" + "\(postID)"

        AF.request(url, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                var jsonValue: JSON?
                var err: Error?

                switch response.result {
                    case .success(let data):
                        jsonValue = JSON(data) // парсим джэйсон
                    case .failure(let error):
                        err = error
                }
                callback(jsonValue, err)
            }
    }
}
