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
        
        for bTag in buttonTag.allValues {
            let x = CGFloat(42*bTag.rawValue)
            let btn = UIButton(frame: CGRectMake(x, self.view.bounds.height*9/10 , 40, 40))
            btn.backgroundColor = UIColor.redColor()
            btn.tag = bTag.rawValue
            btn.setTitle(bTag.toStr(), forState: .Normal)
            btn.addTarget(self, action: "pushedButton:", forControlEvents: .TouchUpInside)
            self.view.addSubview(btn)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    enum buttonTag: Int { //列挙型
        case Zero = 1, One, Two, Three, Four, Five
        static let allValues = [Zero, One, Two, Three, Four, Five]
        
        func toStr() -> String { // クラス内にStringに変換して取得できるメソッドを追加
            return String(self.rawValue - 1)
        }
    }
    
    func pushedButton(sender: UIButton) {
        let btag = buttonTag(rawValue: sender.tag)!

        switch btag {
            
        case .Zero:
            // バネのような動き
            UIView.animateWithDuration(2.0, // アニメーションの時間を2秒に設定
                delay: 0.0, // 遅延時間
                usingSpringWithDamping: 0.1, // ばねの弾性力, 小さいほど弾性力が大きい
                initialSpringVelocity: 1.5, // 初速度
                options: UIViewAnimationOptions.CurveLinear, // 一定の速度
                animations: { () -> Void in
                    self.imageHere.layer.position = CGPointMake(self.view.frame.width/2, self.view.frame.height*3/4)
                    // アニメーション完了時の処理
                }) { (Bool) -> Void in
            }

        case .One: //X, Y方向にそれぞれ反転するアニメーション.
            UIView.animateWithDuration(1.0,// アニメーションの時間を2秒に設定
                animations: { () -> Void in // アニメーション中の処理
                    self.imageHere.transform = CGAffineTransformScale(self.imageHere.transform, -1.0, 1.0) // X方向に反転用のアフィン行列作成
                    // 連続したアニメーション処理.
                }) { (Bool) -> Void in
                    UIView.animateWithDuration(1.0,
                        animations: { () -> Void in // アニメーション中の処理
                            self.imageHere.transform = CGAffineTransformScale(self.imageHere.transform, 1.0, -1.0) // Y方向に反転用のアフィン行列作成
                            // アニメーション完了時の処理
                        }) { (Bool) -> Void in
                    }
                }
            
        case .Two: //回転アニメーション
            let angle:CGFloat = CGFloat(M_PI_2) // radianで回転角度を指定
        
            UIView.animateWithDuration(1.0,
                animations: { () -> Void in
                self.imageHere.transform = CGAffineTransformMakeRotation(angle)// 回転用のアフィン行列を生成
                }, completion: {(Bool) -> Void in
            })
            
        case .Three: // 拡縮アニメーション
            UIView.animateWithDuration(1.0, animations: { () -> Void in
                self.imageHere.transform = CGAffineTransformMakeScale(1.5, 1.5) // 拡大用アフィン
            }) { (Bool) -> Void in
                UIView.animateWithDuration(0.8, animations: { () -> Void in
                    self.imageHere.transform = CGAffineTransformMakeScale(0.5, 0.5) //縮小用
                }) { (Bool) -> Void in
                    UIView.animateWithDuration(0.2, animations: { () -> Void in
                        self.imageHere.transform = CGAffineTransformMakeScale(0.6, 0.6)
                    })
                }
            }
            
        case .Four: // 移動アニメーション
            UIView.animateWithDuration(NSTimeInterval(CGFloat(0.5)), animations: { () -> Void in
                self.imageHere.center = CGPoint(x: self.view.frame.width/4, y: self.view.frame.height/4)
                }) { (Bool) -> Void in
                    UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.imageHere.center = CGPoint(x: self.view.frame.width*3/4, y: self.view.frame.height/4)
                    })
            }
            
        case .Five: //初期化
            UIView.animateWithDuration(1.0, animations: { () -> Void in
                self.imageHere.center = self.view.center //位置
                self.imageHere.transform = CGAffineTransformMakeScale(1, 1) //大きさ
                self.imageHere.transform = CGAffineTransformMakeRotation(0) // 回転
            })
        }

    
    }
    

}

