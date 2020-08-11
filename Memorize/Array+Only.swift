//
//  Array+Only.swift
//  Memorize
//
//  Created by Jeffrey Blagdon on 2020-08-11.
//  Copyright © 2020 polyergy. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? self.first : nil
    }
}
