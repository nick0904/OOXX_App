//
//  DetailViewController.swift
//  FunnyGame
//
//  Created by 曾偉亮 on 2016/4/11.
//  Copyright © 2016年 TSENG. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var roundLabel:UILabel!
    var player_01Chooese:UILabel!
    var player_02Chooese:UILabel!
    var winnerLabel:UILabel!
    var ary_imageView = [UIImageView]()
    
    //間隔線及圖片大小相關設定
    let sideW:CGFloat = 30
    let lineSpace:CGFloat = 10
    var imgViewWidth:CGFloat!
    var sideH:CGFloat!
    
    var m_parentObj:AnyObject?
    
//MARK: - refreashWithFrame
//-------------------------
    func refreashWithFrame(frame:CGRect) {
        
        self.view.frame = frame
        self.view.backgroundColor = UIColor.blackColor()
        
        imgViewWidth = (self.view.frame.size.width - 4*lineSpace - 2*sideW)/3
        sideH  = (self.view.frame.size.height - 4*lineSpace - 3*imgViewWidth)/2

        //roundLabel
        roundLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height/10))
        roundLabel.center = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/20)
        roundLabel.textColor = UIColor.redColor()
        roundLabel.textAlignment = .Center
        roundLabel.font = UIFont.boldSystemFontOfSize(roundLabel.frame.size.height/3)
        roundLabel.adjustsFontSizeToFitWidth = true
        roundLabel.text = "第 ? 局"
        self.view.addSubview(roundLabel)
        
        //player1
        player_01Chooese = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width/3, height: self.view.frame.size.width/6))
        player_01Chooese.center = CGPoint(x: self.view.frame.size.width/3, y: self.view.frame.size.height/7)
        player_01Chooese.font = UIFont.boldSystemFontOfSize(player_01Chooese.frame.size.height/3)
        player_01Chooese.adjustsFontSizeToFitWidth = true
        player_01Chooese.textAlignment = .Center
        player_01Chooese.textColor = UIColor.whiteColor()
        player_01Chooese.text = "player 1"
        self.view.addSubview(player_01Chooese)
        
        //player2
        player_02Chooese = UILabel(frame: CGRect(x: 0, y: 0, width: player_01Chooese.frame.size.width, height: player_01Chooese.frame.size.height))
        player_02Chooese.center = CGPoint(x: self.view.frame.size.width/3*2, y: player_01Chooese.center.y)
        player_02Chooese.textAlignment = .Center
        player_02Chooese.font = UIFont.boldSystemFontOfSize(player_02Chooese.frame.size.height/3)
        player_02Chooese.adjustsFontSizeToFitWidth = true
        player_02Chooese.textColor = UIColor.whiteColor()
        player_02Chooese.text = "player 2"
        self.view.addSubview(player_02Chooese)
        
        //=====================  生成 圈圈叉叉 九宮格  ====================
        for row in 0...2 {
            
            for column in 0...2 {
                
                let imageView = UIImageView(frame: CGRect(x: sideW + lineSpace*CGFloat(column+1) + imgViewWidth*CGFloat(column), y: sideH + lineSpace*CGFloat(row+1) + imgViewWidth*CGFloat(row) , width: imgViewWidth, height: imgViewWidth))
                self.view.addSubview(imageView)
                ary_imageView.append(imageView)
            }
            
        }

        //=======================  畫間隔線  =======================
        for column in 0...3 {
            
            let lineColumn = UIView(frame: CGRect(x: sideW + (imgViewWidth+lineSpace)*CGFloat(column), y: sideH, width: lineSpace, height: self.view.frame.size.height - 2*sideH))
            lineColumn.backgroundColor = UIColor.lightGrayColor()
            self.view.addSubview(lineColumn)
        }
        
        for row in 0...3 {
            
            let lineRow = UIView(frame: CGRect(x: sideW, y: sideH + (lineSpace + imgViewWidth)*CGFloat(row), width: self.view.frame.size.width - 2*sideW, height: lineSpace))
            lineRow.backgroundColor = UIColor.lightGrayColor()
            self.view.addSubview(lineRow)
        }

    
        
        //winnerLabel
        winnerLabel = UILabel(frame: CGRect(x: 0, y: self.view.frame.size.height/4*3, width: self.view.frame.size.width, height: self.view.frame.size.height/10))
        winnerLabel.textAlignment = .Center
        winnerLabel.textColor = UIColor.cyanColor()
        winnerLabel.font = UIFont.boldSystemFontOfSize(winnerLabel.frame.size.height/3)
        winnerLabel.adjustsFontSizeToFitWidth = true
        winnerLabel.text = "who is the winner ?"
        self.view.addSubview(winnerLabel)
        
        //backBt
        let backBt = UIButton(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width/2, height: self.view.frame.size.height/10))
        backBt.center = CGPoint(x: self.view.frame.size.width/2, y: winnerLabel.center.y + self.view.frame.size.height/10)
        backBt.setTitle("返回", forState: .Normal)
        backBt.titleLabel?.font = UIFont.boldSystemFontOfSize(backBt.frame.size.height/3)
        backBt.addTarget(self, action: #selector(DetailViewController.backBtAction(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(backBt)

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//MARK: - backBtAction
//--------------------
    func backBtAction(sender:UIButton) {
        
        if m_parentObj != nil {
            
            m_parentObj?.dismissViewControllerAnimated(true, completion: nil)
        }
        
    }
    

}
