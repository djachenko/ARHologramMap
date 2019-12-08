//
//  ViewController.swift
//  ARHologram
//
//  Created by Igor Djachenko on 15/11/2017.
//  Copyright © 2017 Igor Djachenko. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var floorsSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        sceneView.autoenablesDefaultLighting = true
        
        // Create a new scene
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene

        floorsSlider.transform = CGAffineTransform(rotationAngle: -(.pi / 2))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        configuration.planeDetection = .horizontal

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    // MARK: - ARSCNViewDelegate
    
    var sceneNode: SCNNode?

    let hologram = ARHologram()

    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        print("got anchor")

        guard anchor is ARPlaneAnchor else {
            return nil
        }

        if sceneNode == nil {
            sceneNode = SCNNode()

            sceneNode?.addChildNode(hologram)

            print("hologram created")

            return sceneNode
        }

        return nil
    }

    @IBAction func collapseHandler(switchState: UISwitch) {
        if switchState.isOn {
            print("The Switch is On")
        }
        else {
            print("The Switch is Off")
        }

        hologram.collapsed = !switchState.isOn
    }

    @IBAction func floorChangeHandler(slider: UISlider) {
        let value = round(slider.value)

        slider.value = value

        hologram.currentFloor = Int(value)
    }

    var lastScale: Float = 1

    @IBAction func handlePinch(recognizer: UIPinchGestureRecognizer) {
        if recognizer.state == .began {
            lastScale = 1
        }

        let scale = Float(recognizer.scale) / lastScale

        hologram.scale(ratio: scale)

        lastScale = Float(recognizer.scale)
    }

    var lastTranslationX: CGFloat = 0

    @IBAction func handlePan(recognizer: UIPanGestureRecognizer) {
        if recognizer.state == .began {
            lastTranslationX = 0
        }

        let translation = recognizer.translation(in: view)

        let angle = 2.0 * .pi * (translation.x - lastTranslationX) / view.bounds.size.width

        print("angle \(angle)")

        hologram.rotate(angle: Float(angle))

        lastTranslationX = translation.x
    }
}
