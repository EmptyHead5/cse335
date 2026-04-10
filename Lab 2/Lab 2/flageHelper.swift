//
//  flageHelper.swift
//  Lab 2
//
//  Created by zenanchang on 2/3/26.
//

import SwiftUI

func flag(country:String) -> String
{
    let base : UInt32 = 127397
    var s = ""
    for v in country.unicodeScalars
    {
        s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
    }
    return String(s)
}
