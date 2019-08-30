//
//  Path.swift
//  dijexstra
//
//  Created by Ouri -Live Care on 8/30/19.
//  Copyright © 2019 Ouri Alkada. All rights reserved.
//

import Foundation

class Path {
    public let cumulativeWeight: Int
    public let node: Node
    public let previousPath: Path?
    
    init(to node: Node, via connection: Connection? = nil, previousPath path: Path? = nil) {
        if
            let previousPath = path,
            let viaConnection = connection {
            self.cumulativeWeight = viaConnection.weight + previousPath.cumulativeWeight
        } else {
            self.cumulativeWeight = 0
        }
        
        self.node = node
        self.previousPath = path
    }
}


