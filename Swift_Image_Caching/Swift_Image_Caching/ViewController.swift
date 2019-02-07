//
//  ViewController.swift
//  Swift_Image_Caching
//
//  Created by George Leonidas on 06/09/2018.
//  Copyright © 2018 George Leonidas. All rights reserved.
//

import UIKit

let largeImageUrl = "http://s1.picswalls.com/wallpapers/2016/06/10/4k-high-definition-wallpaper_065229159_309.jpg"
let normalImageUrl = "http://photogrvphy.com/wp-content/uploads/2017/12/Mert_Acar-Placeholder-PhotogrVphy_Magazine_09-1024x614_c.jpg"

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var imageUrl = normalImageUrl
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: TestCell.nibName, bundle: nil), forCellReuseIdentifier: TestCell.cellIdentifier)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func reloadTapped(_ sender: Any) {
        tableView.reloadData()
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TestCell.cellIdentifier, for: indexPath) as? TestCell else { fatalError() }
        
        cell.mainImageView.setImage(withImageURL: imageUrl, placeholder: #imageLiteral(resourceName: "placeholder"), toBeCached: true)
        
        return cell
    }
}

