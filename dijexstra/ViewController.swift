//
//  ViewController.swift
//  dijexstra
//
//  Created by Ouri -Live Care on 8/30/19.
//  Copyright © 2019 Ouri Alkada. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var startSelect: UILabel!
    @IBOutlet weak var answer: UILabel!
    @IBOutlet weak var stopSelect: UILabel!
    
    let firstNode = MyNode(name: "firstNode")
    let secondNode = MyNode(name: "secondNode")
    let thirdNode = MyNode(name: "thirdNode")
    let fourthNode = MyNode(name: "fourthNode")
    let fifthNode = MyNode(name: "fifthNode")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add all nodes
       
        
        // add all connections
        firstNode.connections.append(Connection(to: secondNode, weight: 1))
        secondNode.connections.append(Connection(to: thirdNode, weight: 3))
        thirdNode.connections.append(Connection(to: fourthNode, weight: 1))
        secondNode.connections.append(Connection(to: fifthNode, weight: 1))
        fifthNode.connections.append(Connection(to: thirdNode, weight: 1))

        
    }
    func shortestPath(source: Node, destination: Node) -> Path? {
        var frontier: [Path] = [] {
            didSet { frontier.sort { return $0.cumulativeWeight < $1.cumulativeWeight } } // the frontier has to be always ordered
        }
        
        frontier.append(Path(to: source)) // the frontier is made by a path that starts nowhere and ends in the source
        
        while !frontier.isEmpty {
            let cheapestPathInFrontier = frontier.removeFirst() // getting the cheapest path available
            guard !cheapestPathInFrontier.node.visited else { continue } // making sure we haven't visited the node already
            
            if cheapestPathInFrontier.node === destination {
                return cheapestPathInFrontier // found the cheapest path 😎
            }
            
            cheapestPathInFrontier.node.visited = true
            
            for connection in cheapestPathInFrontier.node.connections where !connection.to.visited { // adding new paths to our frontier
                frontier.append(Path(to: connection.to, via: connection, previousPath: cheapestPathInFrontier))
            }
        } // end while
        return nil // we didn't find a path 😣
    }
    
    
    @IBAction func start(_ sender: UIButton) {
        startSelect.text = "Selected: " + sender.title(for: .normal)!
    }
    
    
    @IBAction func End(_ sender: UIButton) {
        stopSelect.text = "Selected: " + sender.title(for: .normal)!
    }
    
    
    @IBAction func Go(_ sender: Any) {
        var sourceNode = firstNode
        var destinationNode = fourthNode
        
        switch (startSelect.text)
        {
        case "firstNode":
            sourceNode = firstNode
            break;
        case "secondNode":
            sourceNode = secondNode
            break;
        case "thirdNode":
            sourceNode = thirdNode
            break;
        case "fourthNode":
            sourceNode = fourthNode
            break;
        case "fifthNode":
            sourceNode = fifthNode
            break;
            
        case .none:
            break
            
        case .some(_): break
            
        }
        
        switch (stopSelect.text)
        {
        case "firstNode":
            destinationNode = firstNode
            break;
        case "secondNode":
            destinationNode = secondNode
            break;
        case "thirdNode":
            destinationNode = thirdNode
            break;
        case "fourthNode":
            destinationNode = fourthNode
            break;
        case "fifthNode":
            destinationNode = fifthNode
            break;
            
        case .none:
            break;
            
        case .some(_): break
            
        }
        
        if startSelect.text == "Selected:"
        {
            let alert = UIAlertController(title: "Click a start node", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
          
        }
        else if stopSelect.text == "Selected:"
        {
            let alert = UIAlertController(title: "Click a end node", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            
        }
        
        else
        {
            var path = shortestPath(source: sourceNode, destination: destinationNode)
            
            
            if let succession: [String] = path?.array.reversed().flatMap({ $0 as? MyNode}).map({$0.name}) {
                print("🏁 Quickest path: \(succession)")
                answer.text = "Quickest path: \(succession)"
            } else {
                print("💥 No path between \(sourceNode.name) & \(destinationNode.name)")
                 answer.text = "No path between \(sourceNode.name) & \(destinationNode.name)"
            }
        }
      
        
    }
    
    
    
    


}

extension Path {
    var array: [Node] {
        var array: [Node] = [self.node]
        
        var iterativePath = self
        while let path = iterativePath.previousPath {
            array.append(path.node)
            
            iterativePath = path
        }
        
        return array
    }
}
