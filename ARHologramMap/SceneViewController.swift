//
// Created by Igor Djachenko on 31/01/2020.
// Copyright (c) 2020 justin. All rights reserved.
//


import Foundation
import UIKit
import SceneKit

class SceneViewController: UIViewController {
    @IBOutlet private weak var sceneView: SCNView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let scene = SCNScene()

        sceneView.scene = scene
        scene.background.contents =  UIColor.gray



        let cube = SCNNode.cube(side: 0.1)
        cube.geometry?.firstMaterial?.diffuse.contents = UIColor.blue

        let data = DataService.readJson()!

        let building = try! JSONDecoder().decode(Building.self, from: data)
        let buildingGeometry = BuildingGeometry.build(from: building)
        buildingGeometry.firstMaterial!.diffuse.contents = UIColor.red
        let buildingNode = SCNNode(geometry: buildingGeometry)

        let node = scene.rootNode

        node.addChildNode(buildingNode)
//        node.addChildNode(cube)
        node.addChildNode(SCNNode.axesNode(quiverLength: 0.5, quiverThickness: 0.1))

        print("added")
    }
}

