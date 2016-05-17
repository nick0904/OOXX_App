//
//  ScoreViewCell.swift
//  FunnyGame
//
//  Created by 曾偉亮 on 2016/4/10.
//  Copyright © 2016年 TSENG. All rights reserved.
//

import UIKit

class ScoreViewCell: UITableViewCell {
    
    var roundLabel:UILabel!
    var resultLabel:UILabel!
    
    
    func refreashWithFrame(frame:CGRect) {
        
        self.frame = frame
        self.backgroundColor = UIColor.blackColor()
    
        //roundLabel
        roundLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.size.width/2, height: self.frame.size.height))
        roundLabel.textAlignment = .Center
        roundLabel.textColor = UIColor.whiteColor()
        self.addSubview(roundLabel)
        
        //resultLabel
        resultLabel = UILabel(frame: CGRect(x: roundLabel.frame.size.width, y: 0, width: roundLabel.frame.size.width, height: roundLabel.frame.size.height))
        resultLabel.textAlignment = .Center
        resultLabel.textColor = UIColor.cyanColor()
        self.addSubview(resultLabel)
        
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
