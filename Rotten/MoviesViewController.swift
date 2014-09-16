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
    var refreshControl:UIRefreshControl!
    var rentalUrl = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=c9tx6uu8mgyav5gc54t4q933";
    var searchUrl = "http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey=c9tx6uu8mgyav5gc54t4q933&q="
    @IBOutlet var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        var hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.labelText = "loading .."
        hud.show(true)
        
        self.tableView.backgroundColor = UIColor.blackColor()
        self.tableView.tintColor = UIColor.whiteColor()
        self.tableView.separatorColor = UIColor.darkGrayColor()
        
        if(searchBar.text != nil) {
            var searchText = searchBar.text
            var newUrl = searchUrl+searchText
            println(newUrl);
        }
        var request = NSURLRequest(URL: NSURL(string: rentalUrl))
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var object = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
            self.Movies = object["movies"] as [NSDictionary]
            self.tableView.reloadData()
            MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
        }
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refersh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refresh(refreshControl : UIRefreshControl)
    {
        var hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.labelText = "loading .."
        hud.show(true)
        
        // Code to refresh table view
        var request = NSURLRequest(URL: NSURL(string: rentalUrl))
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var object = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
            self.Movies = object["movies"] as [NSDictionary]
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
        MBProgressHUD.hideAllHUDsForView(self.view, animated: true)

    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: (UIStoryboardSegue!), sender: AnyObject!) {
        self.view.endEditing(true)
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
            
            detVc.titleText = movieTitle
            detVc.detImgUrlString = detailImageUrl
            detVc.posterImgUrlString = posterUrl
            detVc.titleYear = String(movieYear)
            detVc.criticsScore = criticsScore
            detVc.audianceScore = audianceScore
            detVc.detDescString = synopsis
            detVc.navigationItem.title = movieTitle
        }
    }
    

}
