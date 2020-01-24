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
    @IBOutlet private weak var addHologramButton: UIButton!

    fileprivate let geometryCreator = TriangleCreator()

    var activePlane: ARPlaneAnchor? {
        didSet {
            set(buttonEnabled: activePlane != nil)
        }
    }

    var hitTestTimer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()

        set(buttonEnabled: false)

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

        startTimer()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        stopTimer()

        arSceneView.session.pause()
    }

    private func set(buttonEnabled: Bool) {
        addHologramButton.isEnabled = buttonEnabled
        addHologramButton.isHidden = !buttonEnabled
    }

    private func stopTimer() {
        hitTestTimer?.invalidate()
        hitTestTimer = nil
    }

    private func startTimer() {
        print("start timer")



        hitTestTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            let hitTestResult = self.arSceneView.hitTest(self.arSceneView.frame.center, types: .existingPlaneUsingGeometry)

            print("found \(hitTestResult.count)")

            let nearestPlane = hitTestResult.first
            let planeAnchor = nearestPlane?.anchor as? ARPlaneAnchor

            self.activePlane = planeAnchor

            if planeAnchor == nil {
                print("plane not found")
            }
            else {
                print("plane found")
            }
        }
    }

    @IBAction private func tappedAddHologramButton() {
        guard let planeAnchor = activePlane else {
            fatalError()
        }

        guard let node = arSceneView.node(for: planeAnchor) else {
            return
        }

        let cube = SCNNode.cube(side: 0.25)

        node.addChildNode(cube)

        stopTimer()
        activePlane = nil
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

//        guard let plane = Plane(points: [SCNVector3](planeAnchor.geometry.vertices)) else {
//            return
//        }
//
//        print("Plane: " + plane.representation)
    }
}
