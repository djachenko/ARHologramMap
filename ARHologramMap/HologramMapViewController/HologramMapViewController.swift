//
// Created by Harry Djachenko on 2019-12-02.
// Copyright (c) 2019 Igor Djachenko. All rights reserved.
//

import Foundation
import UIKit
import ARKit
import SceneKit

class HologramMapViewController: UIViewController {
    @IBOutlet private weak var arSceneView: ARSCNView!

    fileprivate let geometryCreator = TriangleCreator()

    override func viewDidLoad() {
        super.viewDidLoad()

        arSceneView.delegate = self
        arSceneView.showsStatistics = true
        arSceneView.autoenablesDefaultLighting = true

        arSceneView.scene = SCNScene()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let configuration = ARWorldTrackingConfiguration()

        configuration.planeDetection = .horizontal

        arSceneView.session.run(configuration)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        arSceneView.session.pause()
    }
}

extension HologramMapViewController: ARSCNViewDelegate {
    public func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else {
            return
        }

        print("anchor")

        let geometry = geometryCreator.createGeometry(anchor: planeAnchor)


        let planeNode = SCNNode(geometry: geometry)

        planeNode.simdPosition = planeAnchor.center
        planeNode.opacity = 0.5

        node.addChildNode(planeNode)
    }

    public func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor,
              let planeNode = node.childNodes.first else {
            return
        }

        geometryCreator.update(node: planeNode, anchor: planeAnchor)
    }
}
