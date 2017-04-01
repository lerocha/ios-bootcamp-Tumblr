//
//  ViewController.swift
//  Tumblr
//
//  Created by Luis Rocha on 3/30/17.
//  Copyright © 2017 Luis Rocha. All rights reserved.
//

import UIKit
import AFNetworking

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts: [NSDictionary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // configure data source and delegate
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 240
        
        let apiKey = "Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV"
        let url = URL(string:"https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=\(apiKey)")
        let request = URLRequest(url: url!)
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        
        let task : URLSessionDataTask = session.dataTask(with: request,completionHandler: { (dataOrNil, response, error) in
            if let data = dataOrNil {
                if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options:[]) as? NSDictionary {
                    
                    let response = responseDictionary["response"] as! NSDictionary
                    self.posts = response["posts"] as! [NSDictionary]
                    NSLog("response: \(self.posts)")
                    
                    self.tableView.reloadData()
                }
            }
        });
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell") as! PhotoCell

        // parse the data
        let post = posts[indexPath.row] as NSDictionary
        let title = post["slug"] as! String
        
        if let photos = post.value(forKeyPath: "photos") as? [NSDictionary] {
            let imageUrlString = photos[0].value(forKeyPath: "original_size.url") as? String
            if let imageUrl = URL(string: imageUrlString!) {
                cell.photoImageView.setImageWith(imageUrl)
            }
        }
        
        // initialize the cell
        cell.blogNameLabel.text = title
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // get the index path of the sender
        let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
        // get the photo cell from indexPath
        let cell = tableView.cellForRow(at: indexPath!) as! PhotoCell
        
        // get the detail view controller
        let detailViewController = segue.destination as! PhotoDetailsViewController
        // set the image in the detail view controller from the cell image
        detailViewController.image = cell.photoImageView.image
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // get rid of the gray selection by deselecting the cell with animation
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

