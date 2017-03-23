//
//  CanvasViewController.swift
//  Canvas
//
//  Created by Bconsatnt on 3/23/17.
//  Copyright © 2017 Bconsatnt. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {

    @IBOutlet weak var trayView: UIView!
    var trayOriginalCenter: CGPoint!
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceOriginalCenter: CGPoint!
    var faceOriginalCenter: CGPoint!
    @IBOutlet weak var downArrow: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trayDownOffset = 220
        trayUp = trayView.center
        trayDown = CGPoint(x: trayView.center.x ,y: trayView.center.y + trayDownOffset)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view)
        
        if sender.state == .began {
            trayOriginalCenter = trayView.center
        } else if sender.state == .changed {
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
        } else if sender.state == .ended {
            UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5,initialSpringVelocity: 1, options:[] , animations: { () -> Void in
                if velocity.y > 0 {
                    self.trayView.center = self.trayDown
                    self.downArrow.transform = self.downArrow.transform.rotated(by: CGFloat(M_PI))
                } else {
                    self.trayView.center = self.trayUp
                    self.downArrow.transform = self.downArrow.transform.rotated(by: CGFloat(M_PI    ))
                }
            }, completion: nil)
            
        }
    }

    @IBAction func didPanFace(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan(sender: )))
        
        if sender.state == .began {
            let imageView = sender.view as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            newlyCreatedFace.isUserInteractionEnabled = true
            newlyCreatedFace.addGestureRecognizer(panGestureRecognizer)
        } else if sender.state == .changed {
            UIView.animate(withDuration:0.1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] , animations: { () -> Void in
                    self.newlyCreatedFace.center = CGPoint(x: self.newlyCreatedFaceOriginalCenter.x + translation.x, y: self.newlyCreatedFaceOriginalCenter.y + translation.y)
                    self.newlyCreatedFace.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
            }, completion: nil)
            
        } else if sender.state == .ended {
            UIView.animate(withDuration:0.1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] , animations: { () -> Void in
                self.newlyCreatedFace.transform = self.newlyCreatedFace.transform.scaledBy(x: 0.8, y: 0.8)
                }, completion: nil)
        }
    }
    
    func didPan(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        let imageView = sender.view as! UIImageView
        
        if sender.state == .began {
            faceOriginalCenter = imageView.center
        } else if sender.state == .changed {
            UIView.animate(withDuration:0.1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] , animations: { () -> Void in
                imageView.center = CGPoint(x: self.faceOriginalCenter.x + translation.x, y: self.faceOriginalCenter.y + translation.y)
                imageView.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
                }, completion: nil)
            
        } else if sender.state == .ended {
            UIView.animate(withDuration:0.1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] , animations: { () -> Void in
                imageView.transform = imageView.transform.scaledBy(x: 0.8, y: 0.8)
                }, completion: nil)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
