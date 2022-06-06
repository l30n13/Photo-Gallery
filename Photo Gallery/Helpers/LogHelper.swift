//
//  LogHelper.swift
//  Photo Gallery
//
//  Created by Mahbubur Rashid Leon on 1/6/22.
//

import Foundation

func DLog<T>(_ object: T, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
    #if DEBUG
    let fileString = file as NSString
    let fileLastPathComponent = fileString.lastPathComponent as NSString
    let filename = fileLastPathComponent.deletingPathExtension
    print("\(filename).\(function)[\(line)]: \(object)\n", terminator: "")
    #endif
}
