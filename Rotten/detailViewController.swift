//
//  detailViewController.swift
//  Rotten
//
//  Created by Deepak on 9/15/14.
//  Copyright (c) 2014 Deepak. All rights reserved.
//

import UIKit

class detailViewController: UIViewController, UIGestureRecognizerDelegate {
    
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

    @IBOutlet var descScrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        titleLabel.text = titleText+" ("+titleYear+")"
        self.detailImageView.setImageWithURL(NSURL (string: self.posterImgUrlString))
        self.scoreLabel.text = "Critic's Score: "+String(criticsScore)+"\t\tAudiance score : "+String(audianceScore)
        self.detDescLabel.text = detDescString
        //var textSize = self.detDescLabel.sizeThatFits(CGSizeMake(320, 500))
        //detDescLabel.frame.size = textSize
        descScrollView.contentSize = CGSize(width: 320, height: 1000)
        var request = NSURLRequest(URL: NSURL(string: detImgUrlString))
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            if(error == nil) {
                self.detailImageView.setImageWithURL(NSURL (string: self.detImgUrlString))
            }
        }
        
    }


    override func viewDidAppear(animated: Bool) {

            
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func handleTap(recognizer: UITapGestureRecognizer) {
        println("Tap Recongnised")
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
