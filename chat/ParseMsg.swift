//
//  ParseMsg.swift
//  chat
//
//  Created by Shawn Zhu on 9/9/15.
//  Copyright (c) 2015 Shawn Zhu. All rights reserved.
//

import Foundation
import Parse

class ParseMsg {
    var text : String?
    var user : String?
    
    init(obj: PFObject) {
        text = obj["text"] as? String
    }
}