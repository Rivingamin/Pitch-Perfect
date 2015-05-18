//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Riving on 7/5/2015.
//  Copyright (c) 2015 Riving Amin. All rights reserved.


import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    init(_ url: NSURL, name: String) {
        filePathUrl = url
        title = name
    }
}
