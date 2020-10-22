//
//  ViewController.swift
//  740-InteriorAndExteriorAR3D
//
//  Created by Rachel Saunders on 22/10/2020.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // detect the plane horizontal
        configuration.planeDetection = .horizontal

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // called when a plane is detected (in my case horizontal from the code above)
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        if anchor is ARPlaneAnchor {
            
            let planeAnchor = anchor as! ARPlaneAnchor
            
            // plane geometry with the help of dimentions I got using plane anchor.
            // sets width of shape the same width of the plane
            let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
            
            // node aka the position
            let planeNode = SCNNode()
            
            // set position of the plane geometry to the position using plane anchor
            planeNode.position = SCNVector3(x: planeAnchor.center.x, y: 0, z: planeAnchor.center.z)
            
            // when plane is created it is made by xy plane instead of xz plane, so it rotates on the x axis
            planeNode.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)
            
            // create material object
            let gridMaterial = SCNMaterial()
            
            // set material as an image
            gridMaterial.diffuse.contents = UIImage(named: "art.scnassets/grid.png")
            
            // assigns material to the plane
            plane.materials = [gridMaterial]
            
            // assigning position to the plane
            planeNode.geometry = plane
            
            // adding plane node into the scene yay
            node.addChildNode(planeNode)
            
        } else {
            return
        }
        
    }
}
