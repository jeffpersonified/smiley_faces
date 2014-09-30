//
//  CanvasViewController.swift
//  Canvas
//
//  Created by Jeff Smith on 9/29/14.
//  Copyright (c) 2014 Jeff Smith. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {
    
    @IBOutlet weak var trayView: UIView!
    @IBOutlet weak var trayArrowImageView: UIImageView!
    
    var trayImageCenter: CGPoint!
    
    
    @IBAction func panOnTray(panGestureRecognizer: UIPanGestureRecognizer) {
        var velocity = panGestureRecognizer.velocityInView(view)
        var translation = panGestureRecognizer.translationInView(view)
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            trayImageCenter = trayView.center

            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            println(trayView.frame.origin.y)

            if trayView.frame.origin.y <= self.view.frame.height - 30.0 && trayView.frame.origin.y >= self.view.frame.height - self.trayView.frame.height {
                
                trayView.center.y = translation.y + trayImageCenter.y
                self.calcArrowAngle()
                
            } else {
                
                trayView.center.y = (translation.y / 10) + trayImageCenter.y
                
            }
            


            
        } else if panGestureRecognizer.state ==  UIGestureRecognizerState.Ended {
            
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                if velocity.y > 0 {
                    self.trayView.frame.origin.y = self.view.frame.height - 30.0
                    self.calcArrowAngle()
                } else if velocity.y < 0 {
                    self.trayView.frame.origin.y = self.view.frame.height - self.trayView.frame.height
                    self.calcArrowAngle()
                }
            })
            
        }
        

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func calcArrowAngle() {
        var arrowAngle = convertValue(Float(trayView.frame.origin.y), 370, 535, 0, Float(M_PI))
        self.trayArrowImageView.transform = CGAffineTransformMakeRotation(CGFloat(arrowAngle))
    }
    
}

func convertValue(value: Float, r1Min: Float, r1Max: Float, r2Min: Float, r2Max: Float) -> Float {
    var ratio = (r2Max - r2Min) / (r1Max - r1Min)
    return value * ratio + r2Min - r1Min * ratio
}
