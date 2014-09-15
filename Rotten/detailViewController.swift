//
//  detailViewController.swift
//  Rotten
//
//  Created by Deepak on 9/15/14.
//  Copyright (c) 2014 Deepak. All rights reserved.
//

import UIKit

class detailViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    var titleText = NSString()
    var detImgUrlString = NSString()
    var posterImgUrlString = NSString()
    var titleYear = NSString()
    var criticsScore = NSInteger()
    var audianceScore = NSInteger()
    var detDescString = NSString()
    
    @IBOutlet var detDescLabel: UILabel!
    @IBOutlet var detailImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do  any additional setup after loading the view
        titleLabel.text = titleText+" ("+titleYear+")"
        self.detailImageView.setImageWithURL(NSURL (string: self.posterImgUrlString))
        self.scoreLabel.text = "Critic's Score: "+String(criticsScore)+"\tAudiance score : "+String(audianceScore)
        self.detDescLabel.text = detDescString
        
        var request = NSURLRequest(URL: NSURL(string: detImgUrlString))
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            if(error == nil) {
                self.detailImageView.setImageWithURL(NSURL (string: self.detImgUrlString))
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
