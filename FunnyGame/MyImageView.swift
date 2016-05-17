//
//  MyImageView.swift
//  FunnyGame
//
//  Created by 曾偉亮 on 2016/4/8.
//  Copyright © 2016年 TSENG. All rights reserved.
//

import UIKit
import AVFoundation

class MyImageView: UIImageView {
    
    var isTouch:Bool = false
    var soundAudio:AVAudioPlayer?

    func refreashWithFrame(imageViewFrame:CGRect) {
        
        self.frame = imageViewFrame
        self.backgroundColor = UIColor.blackColor()
        self.userInteractionEnabled = true
        
        do {
            soundAudio = try AVAudioPlayer(contentsOfURL: NSURL(string: NSBundle.mainBundle().pathForResource("sound", ofType: "wav")!)!)
            
        } catch {
            print("sound failed")
        }
        
    }

    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        soundAudio?.play()
        isTouch = true
        self.userInteractionEnabled = false
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
    }
    
}
