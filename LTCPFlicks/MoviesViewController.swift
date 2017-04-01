//
//  MoviesViewController.swift
//  LTCPFlicks
//
//  Created by Tran, Leland on 3/29/17.
//  Copyright © 2017 Tran, Leland. All rights reserved.
//

import UIKit
import AFNetworking
import ALLoadingView

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var errorView: UIView!

    @IBOutlet weak var tableView: UITableView!
    
    var movies: [NSDictionary]?
    var endpoint: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:#selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        let apiKey = "ecb5b60bc1ad48abdf13d063348ee3e1"
        let reqUrl = NSURL(string:"https://api.themoviedb.org/3/movie/"+endpoint+"?api_key=\(apiKey)")!
        let request = NSURLRequest(url: reqUrl as URL)
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate: nil,
            delegateQueue: OperationQueue.main
        )
        
        let task : URLSessionDataTask  =
            session
            .dataTask(with: request as URLRequest,
             completionHandler: { (dataOrNil, response, error) in
                if error != nil {
                    self.errorView.alpha = 1
                }
                else {
                    self.errorView.alpha = 0
                    if let data = dataOrNil {
                        if let responseDictionary =
                            try! JSONSerialization
                                .jsonObject(with: data, options:[]) as? NSDictionary {
                                    NSLog("response: \(responseDictionary)")
                                    self.movies = responseDictionary["results"] as? [NSDictionary]
                                    self.tableView.reloadData()
                                            
                                }
                    }
                }
            
            });
        
                                    
        task.resume();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func refreshControlAction(_ refreshControl: UIRefreshControl){
        let apiKey = "ecb5b60bc1ad48abdf13d063348ee3e1"
        let reqUrl = NSURL(string:"https://api.themoviedb.org/3/movie/"+endpoint+"?api_key=\(apiKey)")!
        let request = NSURLRequest(url: reqUrl as URL)
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate: nil,
            delegateQueue: OperationQueue.main
        )
        
        let task : URLSessionDataTask  =
            session
                .dataTask(with: request as URLRequest,
                          completionHandler: { (dataOrNil, response, error) in
                            if error != nil {
                                self.errorView.alpha = 1
                            } else {
                                self.errorView.alpha = 0
                                if let data = dataOrNil {
                                    if let responseDictionary =
                                        try! JSONSerialization.jsonObject( with: data,
                                                                           options:[]) as? NSDictionary {
                                        NSLog("response: \(responseDictionary)")
                                        self.movies = responseDictionary["results"] as? [NSDictionary]
                                        
                                    }
                                }

                            }
                            self.tableView.reloadData()
                            refreshControl.endRefreshing()
                });
        
        
        task.resume();
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let movies = movies {
            return movies.count
        } else {
            return 0
        }
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        let movie = movies![indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        
        if let posterPath = movie["poster_path"] as? String {
            let posterBaseUrl = "http://image.tmdb.org/t/p/w500"
            let posterUrl = URL(string: posterBaseUrl + posterPath)
            cell.posterView.setImageWith(posterUrl!)
        }
        else {
            cell.posterView = nil
        }
        
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)
        let movie = movies![indexPath!.row]
        
        let detailViewController = segue.destination as! DetailViewController
        detailViewController.movie = movie
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
