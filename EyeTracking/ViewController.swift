//
//  ViewController.swift
//  EyeTracking
//
//  Created by 副島拓哉 on 2021/07/06.
//

import UIKit
import ARKit

class ViewController: UIViewController {
    let session = ARSession()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.session.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //ARSeeeion起動時にリセット
        reset()
    }
}

//MARK:- ARSession
extension ViewController: ARSessionDelegate {

    func reset() {
        guard ARFaceTrackingConfiguration.isSupported else { return }
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        self.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }

    //MARK:- ARSessionDelegate
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        frame.anchors.forEach { anchor in
            guard #available(iOS 12.0, *), let faceAnchor = anchor as? ARFaceAnchor else { return }

            // FaceAnchorから左、右目の位置や向きが取得可能。
            let left = faceAnchor.leftEyeTransform
            print("left:\(left)")
            let right = faceAnchor.rightEyeTransform
            print("right:\(right)")
        }
    }

    func session(_ session: ARSession, didFailWithError error: Error) {}
}

