//
//  ApiConstans.swift
//  NetwoorkApp
//
//  Created by сергей on 4.09.22.
//

import Foundation
class ApiConstants {
    
    // Local server
    static let serverPath = "http://localhost:3000/"
    
    // posts
    static let postsPath = serverPath + "posts"
    static let postsPathURL = URL(string: postsPath)
    
    // comments
    static let commentsPath = serverPath + "comments"
    static let commentsPathURL = URL(string: commentsPath)
}
