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

    var minHeight: CGFloat = 0.2
    var maxHeight: CGFloat = 0.5
    var minDispersal: CGFloat = -4
    var maxDispersal: CGFloat = 4

    func generateRandomVector() -> SCNVector3 {
        return SCNVector3(CGFloat.random(in: minDispersal ... maxDispersal),
                          CGFloat.random(in: minDispersal ... maxDispersal),
                          CGFloat.random(in: minDispersal ... maxDispersal))
    }

    func generateRandomColor() -> UIColor {
        return UIColor(red: CGFloat.random(in: 0 ... 1),
                       green: CGFloat.random(in: 0 ... 1),
                       blue: CGFloat.random(in: 0 ... 1),
                       alpha: CGFloat.random(in: 0.5 ... 1 ))
    }

    func generateRandomSize() -> CGFloat {
        return CGFloat.random(in: minHeight ... maxHeight)
    }

    func generateCube () {
        let size = generateRandomSize()
        let cube = SCNBox(width: size, height: size, length: size, chamferRadius: 0.03)
        cube.materials.first?.diffuse.contents = generateRandomColor()

        let cubeNode = SCNNode(geometry: cube)
        cubeNode.position = generateRandomVector()
        let rotateActioin = SCNAction.rotateBy(x: 0, y: 2 * .pi, z: 0, duration: 3)
        let repeatAction = SCNAction.repeatForever(rotateActioin)
        cubeNode.runAction(repeatAction)

        sceneView.scene.rootNode.addChildNode(cubeNode)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        sceneView.debugOptions = [.showFeaturePoints, .showWorldOrigin]
        sceneView.delegate = self
        sceneView.autoenablesDefaultLighting = true

//        let cube  = SCNBox(width: 0.3, height: 0.3, length: 0.3, chamferRadius: 0.0)
//        let material = SCNMaterial()
//        material.diffuse.contents = UIColor.green
//        cube.materials = [material]
//
//        let cubeNode = SCNNode()
//        cubeNode.geometry = cube
//        cubeNode.position = SCNVector3(0.0, 0.0, -0.5)
//
//        let rotation = SCNAction.rotateBy(x: 0, y: 2 * .pi, z: 0, duration: 2)
//        let repeatRotatioin = SCNAction.repeatForever(rotation)
//        cubeNode.runAction(repeatRotatioin)
//        sceneView.scene.rootNode.addChildNode(cubeNode)


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

    @IBAction func addCubeTapped(_ sender: Any) {
        generateCube()
    }
}
