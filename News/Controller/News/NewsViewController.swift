//
//  NewsViewController.swift
//  NewsViewController
//
//  Created by Nguyễn Trí on 17/09/2021.
//

import UIKit
import SafariServices

class NewsViewController: BaseViewController {
        
    var viewModel = NewsViewModel()
    
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupUI() {
        
        // Navigation Bar
        title = "News"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Table
        tableView.delegate = self
        tableView.dataSource = self
        
        // Nib Cell
        let nib = UINib(nibName: "NewsCell", bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        
        // News
        listNews()
    }
            
    override func setupData() {
    }

    func updateUI() {
        tableView.reloadData()
    }
    
    func listNews() {
        viewModel.loadAPI { (done, msg) in
            if done {
                self.updateUI()
            } else {
                print("API error: \(msg) msg")
            }
        }
    }

}

    // MARK: - UITableView
extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsCell
        let item = viewModel.news[indexPath.row]
        
        cell.titleLabel.text = item.title
        cell.timeLabel.text = item.publishedAt
        
        if item.thumbnailImage != nil {
            cell.thumbnail.image = item.thumbnailImage
        } else {
            cell.thumbnail.image = nil
            
            Networking.shared().dowloadImage(url: item.urlToImage ?? "") { (image) in
                if let image = image {
                    cell.thumbnail.image = image
                    item.thumbnailImage = image
                } else {
                    cell.thumbnail.image = nil
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let news = viewModel.news[indexPath.row]
        guard let url = URL(string: news.url ?? "") else { return }
        
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        let vc = SFSafariViewController(url: url, configuration: config)
        vc.delegate = self
        
        present(vc, animated: true)
    }
}

    // MARK: - Safari
extension NewsViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true)
    }
}

