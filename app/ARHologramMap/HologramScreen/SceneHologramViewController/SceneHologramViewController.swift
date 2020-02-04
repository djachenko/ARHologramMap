//
// Created by Igor Djachenko on 31/01/2020.
// Copyright (c) 2020 justin. All rights reserved.
//


import Foundation
import UIKit
import SceneKit

class SceneHologramViewController: UIViewController, Hologrammable {
    @IBOutlet private weak var sceneView: SCNView!

    private var hologram: Hologram?

    func set(hologram: Building) {
        self.hologram = hologram
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "SceneView hologram"

        let scene = SCNScene()

        let node = scene.rootNode

        sceneView.scene = scene
        scene.background.contents =  UIColor.gray


        let cube = SCNNode.cube(side: 0.1)
        cube.geometry?.firstMaterial?.diffuse.contents = UIColor.blue

        if let hologram = hologram {
            let buildingGeometry = BuildingGeometry.build(from: hologram)
            buildingGeometry.firstMaterial!.diffuse.contents = UIColor.red
            let buildingNode = SCNNode(geometry: buildingGeometry)


            node.addChildNode(buildingNode)
        }

//        node.addChildNode(cube)
        node.addChildNode(SCNNode.axesNode(quiverLength: 0.5, quiverThickness: 0.1))

        print("added")
    }
}

