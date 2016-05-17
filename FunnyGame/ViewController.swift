//
//  ViewController.swift
//  FunnyGame
//
//  Created by 曾偉亮 on 2016/4/8.
//  Copyright © 2016年 TSENG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var player_01Chooese:UILabel!
    var player_02Chooese:UILabel!
    
    var ary_imageViews = [MyImageView]()
    
    var startBt:UIButton!
    
    var roundCount:Int = 0
    var result:String!
    var scoreView:ScoreView?
    
    
    //間隔線及圖片大小相關設定
    let sideW:CGFloat = 30
    let lineSpace:CGFloat = 10
    var imgViewWidth:CGFloat!
    var sideH:CGFloat!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blackColor()
        
        imgViewWidth = (self.view.frame.size.width - 4*lineSpace - 2*sideW)/3
        sideH  = (self.view.frame.size.height - 4*lineSpace - 3*imgViewWidth)/2
        
        //=====================  顯示 players 的選擇  ====================
        player_01Chooese = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width/3, height: self.view.frame.size.width/6))
        player_01Chooese.center = CGPoint(x: self.view.frame.size.width/3, y: self.view.frame.size.height/8)
        player_01Chooese.textColor = UIColor.whiteColor()
        player_01Chooese.textAlignment = .Center
        player_01Chooese.alpha = 0.0
        player_01Chooese.font = UIFont.boldSystemFontOfSize(player_01Chooese.frame.size.height/3)
        player_01Chooese.adjustsFontSizeToFitWidth = true
        self.view.addSubview(player_01Chooese)
        
        
        player_02Chooese = UILabel(frame: CGRect(x: 0, y: 0, width: player_01Chooese.frame.size.width, height: player_01Chooese.frame.size.height))
        player_02Chooese.center = CGPoint(x: self.view.frame.size.width/3*2, y: player_01Chooese.center.y)
        player_02Chooese.textColor = UIColor.whiteColor()
        player_02Chooese.alpha = 0.0
        player_02Chooese.textAlignment = .Center
        player_02Chooese.font = UIFont.boldSystemFontOfSize(player_02Chooese.frame.size.height/3)
        player_02Chooese.adjustsFontSizeToFitWidth = true
        self.view.addSubview(player_02Chooese)
        
        //=======================  畫間隔線  =======================
        for column in 0...3 {
            
            let lineColumn = UIView(frame: CGRect(x: sideW + (imgViewWidth+lineSpace)*CGFloat(column), y: sideH, width: lineSpace, height: self.view.frame.size.height - 2*sideH))
            lineColumn.backgroundColor = UIColor.whiteColor()
            self.view.addSubview(lineColumn)
        }
        
        for row in 0...3 {
            
            let lineRow = UIView(frame: CGRect(x: sideW, y: sideH + (lineSpace + imgViewWidth)*CGFloat(row), width: self.view.frame.size.width - 2*sideW, height: lineSpace))
            lineRow.backgroundColor = UIColor.whiteColor()
            self.view.addSubview(lineRow)
        }

        
        //=====================  遊戲開始鍵 (遊戲結束變重新開始鍵)  ====================
        startBt = UIButton(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width/3, height: self.view.frame.size.width/6))
        startBt.center = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/7)
        startBt.layer.cornerRadius = startBt.frame.size.width/10
        startBt.backgroundColor = UIColor.redColor()
        startBt.setTitle("遊戲開始", forState: .Normal)
        startBt.titleLabel?.font = UIFont.boldSystemFontOfSize(startBt.frame.size.height/3)
        startBt.titleLabel?.adjustsFontSizeToFitWidth = true
        startBt.setTitleColor(UIColor.cyanColor(), forState: .Highlighted)
        startBt.addTarget(self, action: #selector(ViewController.onStartBtAction(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(startBt)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//MARK: -  createBoard (生成棋盤)
//------------------------------
    func createBoard() {
        
        roundCount += 1
        
        //=====================  生成 圈圈叉叉 九宮格  ====================
        for row in 0...2 {
            
            for column in 0...2 {
                
                let imageView = MyImageView()
                imageView.refreashWithFrame(CGRect(x: sideW + lineSpace*CGFloat(column+1) + imgViewWidth*CGFloat(column), y: sideH + lineSpace*CGFloat(row+1) + imgViewWidth*CGFloat(row) , width: imgViewWidth, height: imgViewWidth))
                imageView.alpha = 1.0
                self.view.addSubview(imageView)
                ary_imageViews.append(imageView)
            }
            
        }
        
    }
    
    
//MARK: - onStartBtAction
//------------------------
    
    var ary_respond = [String]()
    var m_timer:NSTimer!
    
    func onStartBtAction(sender:UIButton) {
        
        if sender.titleLabel!.text == "遊戲開始" {
            
            let alert = UIAlertController(title: "請選擇 O 或 X", message: nil, preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "O", style: .Default, handler: { (action) -> Void in
                
                self.player_01Chooese.text = "玩家 1:  O"
                self.player_02Chooese.text = "玩家 2:  X"
                self.player_01Chooese.alpha = 1.0
                self.player_02Chooese.alpha = 1.0
                self.startBt.enabled = false
                self.startBt.alpha = 0.0
                sender.setTitle("再一次", forState: .Normal)
                sender.backgroundColor = UIColor.blueColor()
                
                self.createBoard()
                
                //game_1.png O
                //game_2.png X
                for item in 1...9 {
                    
                    let str = item%2 == 1 ? "game_1.png" : "game_2.png"
                    self.ary_respond.append(str)
                }
                
                //check isTouch
                self.m_timer = NSTimer.scheduledTimerWithTimeInterval(1/10, target: self, selector: #selector(ViewController.checkTouchedCount(_:)), userInfo: nil, repeats: true)
            }))
            
            alert.addAction(UIAlertAction(title: "X", style: .Default, handler: { (action) -> Void in
                
                self.player_01Chooese.text = "玩家 1:  X"
                self.player_02Chooese.text = "玩家 2:  O"
                self.player_01Chooese.alpha = 1.0
                self.player_02Chooese.alpha = 1.0
                self.startBt.enabled = false
                self.startBt.alpha = 0.0
                sender.setTitle("再一次", forState: .Normal)
                sender.backgroundColor = UIColor.blueColor()
                
                self.createBoard()
                
                //game_1.png O
                //game_2.png X
                for item in 1...9 {
                    
                    let str = item%2 == 1 ? "game_2.png" : "game_1.png"
                    self.ary_respond.append(str)
                }
                
                //check isTouch
                self.m_timer = NSTimer.scheduledTimerWithTimeInterval(1/10, target: self, selector: #selector(ViewController.checkTouchedCount(_:)), userInfo: nil, repeats: true)
            }))
            
            alert.addAction(UIAlertAction(title: "取消", style: .Destructive, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)

            
        }
        else if sender.titleLabel!.text == "再一次" {
            
            sender.backgroundColor = UIColor.redColor()
            sender.setTitle("遊戲開始", forState: .Normal)
            self.player_01Chooese.alpha = 0.0
            self.player_02Chooese.alpha = 0.0
            self.startBt.alpha = 1.0
            
            
            UIView.beginAnimations("again", context: nil)
            UIView.setAnimationDuration(0.8)
            for i in 0...8 {
                
                self.ary_imageViews[i].transform = CGAffineTransformMakeScale(0.1, 0.1)
                self.ary_imageViews[i].alpha = 0.0
            }
            UIView.commitAnimations()
            
            self.ary_respond.removeAll()
            self.ary_imageViews.removeAll()
            
        
            self.ary_forCheck = [[3,4,5],[6,7,8],[9,10,11]]
            self.record_img_int.removeAll()
            self.touchcount = 0
            self.hasWinner = false
            
            self.blurView.removeFromSuperview()
            self.blurViewLabel.removeFromSuperview()
            self.blurBt.removeFromSuperview()
        }
        
    }
    
    
    var touchcount:Int = 0
    var ary_forCheck = [[3,4,5],[6,7,8],[9,10,11]]
    
//MARK: - checkTouchedCount
//-------------------------
    func checkTouchedCount(sender:NSTimer) {
    
        for check in 0...self.ary_imageViews.count - 1 {
            
            if self.ary_imageViews[check].isTouch {
                
                self.ary_imageViews[check].image = UIImage(named: self.ary_respond[touchcount])
                self.ary_imageViews[check].isTouch = false
                touchcount += 1
                
                //
                let num = check%3
                let imgInt = self.ary_imageViews[check].image == UIImage(named: "game_1.png") ? 1 : 2
                
                switch check {
                    
                case 0...2:
                    ary_forCheck[0][num] = imgInt
                case 3...5:
                    ary_forCheck[1][num] = imgInt
                case 6...8:
                    ary_forCheck[2][num] = imgInt
                default:
                    break
                    
                }
                
            }
            
        }
        
        //兩方至少要走到第五步才可能會有贏家出現,所以第五步才判斷
        if touchcount > 4 {
            
            self.determineTheWinner()
        }
    
    }
    
//MARK: -  determineTheWinner 判斷是否連成一條線(八種情形)
//---------------------------------------------------
    
    var hasWinner:Bool = false
    
    func determineTheWinner() {
        
        var m_count = 0
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            
            for row  in 0...2 {
                
                if self.ary_forCheck[row][0] == self.ary_forCheck[row][1] && self.ary_forCheck[row][1] == self.ary_forCheck[row][2] {
                    
                    //三種
                    self.hasWinner = true
                    self.whenGameOver()
                    break
                }
                else if self.ary_forCheck[0][row] == self.ary_forCheck[1][row] && self.ary_forCheck[1][row] == self.ary_forCheck[2][row] {
                    
                    //三種
                    self.hasWinner = true
                    self.whenGameOver()
                    break
                }
                else if row == 2 {
                    
                    if self.ary_forCheck[row-2][row-2] == self.ary_forCheck[row-1][row-1] && self.ary_forCheck[row-1][row-1] == self.ary_forCheck[row][row] {
                        
                        self.hasWinner = true
                        self.whenGameOver()
                        break
                    }
                    else if self.ary_forCheck[row-2][row] == self.ary_forCheck[row-1][row-1] && self.ary_forCheck[row-1][row-1] == self.ary_forCheck[row][row-2] {
                        
                        self.hasWinner = true
                        self.whenGameOver()
                        break
                    }
                    
                }
                
                //平手
                for column in 0...2 {
                    
                    if (self.ary_forCheck[row][column] == 1 || self.ary_forCheck[row][column] == 2) && self.hasWinner == false {
                        
                        m_count += 1
                        
                        if m_count == 9 {
                            
                            self.hasWinner = false
                            self.whenGameOver()
                            break
                        }
                    
                    }
                
                }
                
            }
            
        })
        
    }
    
    
//MARK: - whenGameOver
//--------------------
    
    var record_img_int = [Int]()
    
    func whenGameOver() {
        
        self.m_timer.invalidate()
        self.player_01Chooese.alpha = 0.0
        self.player_02Chooese.alpha = 0.0
        self.startBt.alpha = 1.0
        self.startBt.enabled = true
        
        if touchcount == 9 {
            
            if hasWinner == false {
                
                self.result = "平 手"
            }
            else {
                
                self.result = self.touchcount%2 == 1 ? "玩家 1 獲勝" : "玩家 2 獲勝"
            }
        }
        else {
            
            self.result = self.touchcount%2 == 1 ? "玩家 1 獲勝" : "玩家 2 獲勝"
        }
        
        
        if scoreView == nil {
            
            scoreView = ScoreView()
            scoreView?.refreashWithFrame(CGRect(x: 0, y: self.view.frame.size.height/4*3, width: self.view.frame.size.width, height: self.view.frame.size.height/4))
            self.view.addSubview(scoreView!)
        }
        scoreView?.m_parentObj = self
        
        for row in 0 ... 2 {
            
            for column in 0 ... 2 {
                
                if ary_forCheck[row][column] >= 3 {
                    
                    ary_forCheck[row][column] = 0
                }
                
                record_img_int.append(ary_forCheck[row][column])
            }
           
        }
        
        let tuples = (String(roundCount),self.player_01Chooese.text!,self.player_02Chooese.text!,self.result!,record_img_int)
        
        scoreView?.message.append(tuples)

        self.scoreView!.reloadData()
        
        
        //碰觸聲音失效
        for i in 0...8 {
            
            ary_imageViews[i].userInteractionEnabled = false
        }
        
        
        //產生模糊畫面
        UIView.beginAnimations("showWinner", context: nil)
        UIView.setAnimationDuration(0.8)
        self.blurEffectAction()
        UIView.commitAnimations()
    }
    

//MARK: - blurEffectAction 產生模糊畫面
//------------------------------
    var blurView:UIVisualEffectView! //產生模糊畫面
    var blurViewLabel:UILabel!
    var blurBt:UIButton!
    
    func blurEffectAction(){
        
        
        //生成一個模糊效果 , 有 ExtraLight  Light  Dark 可選
        let blurEffect:UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
                
        //生成一個可呈現(掛載)某些視覺效果的 UIVisualEffectview
        blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.view.frame
        blurView.center = self.view.center
        
        //將UIVisualEffectView 加到 self.view
        self.view.addSubview(blurView!)
        
        //blurViewLabel
        blurViewLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width*0.8, height: self.view.frame.size.height/5))
        blurViewLabel?.center = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2)
        blurViewLabel.textAlignment = .Center
        blurViewLabel.textColor = UIColor.whiteColor()
        blurViewLabel.font = UIFont.boldSystemFontOfSize(blurViewLabel!.frame.size.height/3)
        blurViewLabel.adjustsFontSizeToFitWidth = true
        blurViewLabel.text = result
        self.view.addSubview(blurViewLabel)
        
        //blurBt
        blurBt = UIButton(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width/3, height: self.view.frame.size.width/3))
        blurBt.center = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/4*3)
        blurBt.setTitle("確 定", forState: .Normal)
        blurBt.addTarget(self, action: #selector(ViewController.blurViewDisappear(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(blurBt)
    }
    
    func blurViewDisappear(sender:UIButton) {
        
        UIView.beginAnimations("disappearWinner", context: nil)
        UIView.setAnimationDuration(0.8)
        blurViewLabel.frame.origin = CGPoint(x: self.view.frame.size.width, y: self.view.frame.size.height)
        blurView.frame.origin = CGPoint(x: self.view.frame.size.width, y: self.view.frame.size.height)
        blurBt.frame.origin = CGPoint(x: self.view.frame.size.width, y: self.view.frame.size.height)
        UIView.commitAnimations()
    }

    
    
    
}//end class




