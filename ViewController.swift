//
//  ViewController.swift
//  FirstARProject
//
//  Created by Arvydas Klimavicius on 2020-04-22.
//  Copyright © 2020 Arvydas Klimavicius. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.debugOptions = [.showFeaturePoints, .showWorldOrigin]
        sceneView.delegate = self
        sceneView.autoenablesDefaultLighting = true

        let cube  = SCNBox(width: 0.3, height: 0.3, length: 0.3, chamferRadius: 0.0)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.green
        cube.materials = [material]

        let cubeNode = SCNNode()
        cubeNode.geometry = cube
        cubeNode.position = SCNVector3(0.0, 0.0, -0.5)

        let rotation = SCNAction.rotateBy(x: 0, y: 2 * .pi, z: 0, duration: 2)
        let repeatRotatioin = SCNAction.repeatForever(rotation)
        cubeNode.runAction(repeatRotatioin)
        sceneView.scene.rootNode.addChildNode(cubeNode)


    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

}
