//
//  Utils.swift
//  AssignmentMV
//
//  Created by Mahendra Vishwakarma on 13/10/19.
//  Copyright © 2019 Mahendra Vishwakarma. All rights reserved.
//

import Foundation

class Utils{
    static func layoutValue(layout:PhotoLayouts) -> Int{
        switch layout{
        case .two:
            return 2
        case .three:
            return 3
        case .four:
            return 4
        }
    }
}
