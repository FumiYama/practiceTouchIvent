//
//  ViewController.swift
//  practiceTouchIvent
//
//  Created by Fumiya Yamanaka on 2015/11/16.
//  Copyright © 2015年 Fumiya Yamanaka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var imageHere: UIImageView!
    var startPoint: CGPoint?
    var imageHerePoint: CGPoint?
    var isImageInside: Bool?
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //タッチし始めた座標獲得
        let touch: UITouch = touches.first!
        startPoint = touch.locationInView(self.view)
        
        // タッチしはじめのイメージ座標
        imageHerePoint = self.imageHere.frame.origin
        
        // イメージの範囲
        let MinX = imageHerePoint!.x
        let MaxX = imageHerePoint!.x + self.imageHere!.frame.width
        let MinY = imageHerePoint!.y
        let MaxY = imageHerePoint!.y + self.imageHere!.frame.height
        
        // イマージの範囲内でタッチした時のみisImageInsideをtrueにする
        if (MinX <= startPoint!.x && startPoint!.x <= MaxX) && (MinY <= startPoint!.y && startPoint!.y <= MaxY) {
            isImageInside = true
        } else {
            isImageInside = false
        }
        
        UIView.animateWithDuration(0.06,
            animations: { () -> Void in
                self.imageHere.transform = CGAffineTransformMakeScale(0.9, 0.9)
            })
            { (Bool) -> Void in
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if isImageInside! {
        // if isImageInside == true {
            let touch: UITouch = touches.first!
            let location: CGPoint = touch.locationInView(self.view)
            
            // 移動量計算
            let deltaX: CGFloat = CGFloat(location.x - startPoint!.x)
            let deltaY: CGFloat = CGFloat(location.y - startPoint!.y)
            
            self.imageHere.frame.origin.x = imageHerePoint!.x + deltaX
            self.imageHere.frame.origin.y = imageHerePoint!.y + deltaY
        } else {
            
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        UIView.animateWithDuration(0.1,
            animations: { () -> Void in
                // 拡大用アフィン行列を作成する.
                self.imageHere.transform = CGAffineTransformMakeScale(0.4, 0.4)
                // 縮小用アフィン行列を作成する.
                self.imageHere.transform = CGAffineTransformMakeScale(1.0, 1.0)
            })
            { (Bool) -> Void in
        }
    }







    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    


}

