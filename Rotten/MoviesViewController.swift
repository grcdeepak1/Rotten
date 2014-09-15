//
//  MoviesViewController.swift
//  Rotten
//
//  Created by Deepak on 9/11/14.
//  Copyright (c) 2014 Deepak. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var Movies: [NSDictionary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        var url = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=c9tx6uu8mgyav5gc54t4q933";
        var request = NSURLRequest(URL: NSURL(string: url))
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var object = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
            self.Movies = object["movies"] as [NSDictionary]
            self.tableView.reloadData()
        }
        
        // Do any additional setup after loading the view.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Movies.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("MovieCell") as MovieCell
        var movie = Movies[indexPath.row]
        cell.movieTitleLabel.text = movie["title"] as? String
        cell.synopsisLabel.text = movie["synopsis"] as? String
        var posters = movie["posters"] as NSDictionary
        var posterUrl = posters["thumbnail"] as String
        cell.posterView.setImageWithURL(NSURL (string: posterUrl))
        return cell
    }
    //func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    //    let movieDetailViewController = detailViewController(nibName: nil, bundle: nil)
    //}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: (UIStoryboardSegue!), sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "detail") {
            let detVc = segue.destinationViewController as detailViewController
            // pass data to next view
            let indexPath = self.tableView.indexPathForSelectedRow()?.row
            var movie = Movies[indexPath!]
            var ratings = movie["ratings"] as NSDictionary
            var posters = movie["posters"] as NSDictionary
            
            var movieTitle = movie["title"] as NSString
            var movieYear  = movie["year"] as NSInteger
            var criticsScore = ratings["critics_score"] as NSInteger
            var audianceScore = ratings["audience_score"] as NSInteger
            var synopsis = movie["synopsis"] as String
            var posterUrl = posters["thumbnail"] as String
            var detailImageUrl = posterUrl.stringByReplacingOccurrencesOfString("tmb", withString: "ori")
            
            println("\(movieTitle) \(movieYear)")
            println(detailImageUrl)
            detVc.titleText = movieTitle
            detVc.detImgUrlString = detailImageUrl
            detVc.posterImgUrlString = posterUrl
            detVc.titleYear = String(movieYear)
            detVc.criticsScore = criticsScore
            detVc.audianceScore = audianceScore
            detVc.detDescString = synopsis
        
            //println(movie["synopsis"])
            
            
            
            
        }
    }
    

}
