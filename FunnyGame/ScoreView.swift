//
//  ScoreView.swift
//  FunnyGame
//
//  Created by 曾偉亮 on 2016/4/10.
//  Copyright © 2016年 TSENG. All rights reserved.
//

import UIKit

class ScoreView: UITableView ,UITableViewDataSource,UITableViewDelegate {

    var ary_round = [String]()
    var ary_score = [String]()
    
    var m_parentObj:ViewController?
    
    var m_detail:DetailViewController?
    
    var message = [ (round:String ,player1:String, player2:String, result:String, img_int:[Int]) ]()

    
//MARK: - refreashWithFrame
//-------------------------
    func refreashWithFrame(frame:CGRect) {
        
        self.backgroundColor = UIColor.blackColor()
        self.frame = frame
        self.dataSource = self
        self.delegate = self
    }
    
//MARK: - TableView DataSource & Delegate
//---------------------------------------
    override func numberOfRowsInSection(section: Int) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return message.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell_id:String = "CELL_ID"
        var cell = tableView.dequeueReusableCellWithIdentifier(cell_id) as! ScoreViewCell!
        
        if cell == nil {
            
            cell = ScoreViewCell()
            cell.refreashWithFrame(CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height/3))
            cell.accessoryType = .DisclosureIndicator
            cell.selectionStyle = .None
        }
        
        cell.roundLabel.text = "第 " + self.message[indexPath.row].round + " 局"
        cell.resultLabel.text = self.message[indexPath.row].result
                
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if m_detail == nil {
            
            m_detail = DetailViewController()
            m_detail?.refreashWithFrame(CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height))
        }
        
        m_detail?.m_parentObj = self.m_parentObj
        
        if m_parentObj != nil {
            
            m_detail?.modalTransitionStyle = .FlipHorizontal
            m_parentObj?.presentViewController(m_detail!, animated: true, completion: nil)
        }
        
        m_detail?.roundLabel.text = "第     " + message[indexPath.row].round + "     局"
        m_detail?.player_01Chooese.text = message[indexPath.row].player1
        m_detail?.player_02Chooese.text = message[indexPath.row].player2
        m_detail?.winnerLabel.text = message[indexPath.row].result
        
        for index in 0 ... 8 {
            
            if message[indexPath.row].img_int[index] == 1 {
            
                m_detail?.ary_imageView[index].image = UIImage(named: "game_1.png")
            }
            else if message[indexPath.row].img_int[index] == 2 {
                
                m_detail?.ary_imageView[index].image = UIImage(named: "game_2.png")
            }
            else {
                
                m_detail?.ary_imageView[index].image = UIImage(named: "game_0.png")
            }
        
        }

    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return self.frame.size.height/3
    }
    


}//end class


