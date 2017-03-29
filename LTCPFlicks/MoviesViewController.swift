//
//  MoviesViewController.swift
//  LTCPFlicks
//
//  Created by Tran, Leland on 3/29/17.
//  Copyright © 2017 Tran, Leland. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var movies: [NSDictionary]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        let apiKey = "ecb5b60bc1ad48abdf13d063348ee3e1"
        let url = NSURL(string:"https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        let request = NSURLRequest(url: url as URL!)
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate: nil,
            delegateQueue: OperationQueue.main
        )
        let task : URLSessionDataTask  =
            session
            .dataTask(with: request as URLRequest,
             completionHandler: { (dataOrNil, response, error) in
                                    if let data = dataOrNil {
                                        if let responseDictionary =
                                            try! JSONSerialization.jsonObject( with: data,
                                                                options:[]) as? NSDictionary {
                                                                    NSLog("response: \(responseDictionary)")
                                                                    self.movies = responseDictionary["results"] as? [NSDictionary]
                                                                    self.tableView.reloadData()
                                            
                                        }
                                    }
            });
                
                                    
        task.resume();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let movies = movies {
            return movies.count
        } else {
            return 0
        }
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)
        
        let movie = movies![indexPath.row]
        let title = movie["title"] as! String
        
        cell.textLabel!.text = title
        print("row \(indexPath.row)")
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}