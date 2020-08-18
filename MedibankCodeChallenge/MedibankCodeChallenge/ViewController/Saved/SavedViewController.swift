//  Copyright © 2020 Michael.H. All rights reserved.

import UIKit

class SavedViewController: UIViewController {

    // MARK: - IBOutlet
    /// The headline table view
    @IBOutlet private var tableview: UITableView!
    
    /// The loading spinner
    @IBOutlet private var spinner: UIActivityIndicatorView!
    
    // MARK: - Properties
    /// The view model
    private var viewModel = SavedViewModel()
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.loadData()
    }
    
    // MARK: - Closure functions
    func isLoading(_ loading: Bool) {
        if loading {
            spinner.startAnimating()
        }
        else {
            spinner.stopAnimating()
        }
        spinner.isHidden = !loading
        tableview.isHidden = loading
    }
    
    func reloadData() {
        tableview.reloadData()
    }
    
    func openlink(_ article: ArticleItem) {
        let webViewController = WebViewController(article: article)
        self.present(webViewController, animated: true, completion: nil)
    }
    
    // MARK: - Private helper
    private func setupTableView() {
        tableview.delegate = self
        tableview.dataSource = self
        tableview.prefetchDataSource = self
        tableview.rowHeight = HeadlineViewController.Constant.rowHeight
        tableview.register(UINib(nibName: "HeadlineCell", bundle: nil), forCellReuseIdentifier: HeadlineViewController.Constant.cellId)
    }
    
    private func setupViewModel() {
        viewModel.isLoading = isLoading
        viewModel.reloadData = reloadData
        viewModel.openlink = openlink
    }
}

// MARK: - UITabview data source
extension SavedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: HeadlineViewController.Constant.cellId,
            for: indexPath) as? HeadlineCell else {
                return UITableViewCell()
        }
        
        let article = viewModel.articleList[indexPath.row]
        cell.updateCell(data: article)
        viewModel.imageForCell(indexPath) { image in
            DispatchQueue.main.async {
                cell.updateThumbnail(image)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteItem(indexPath)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

// MARK: - UITableview delegate
extension SavedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.openItem(indexPath)
    }
}

// MARK: - UITableview prefetch data source
extension SavedViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        viewModel.prefetchImage(indexPaths)
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        viewModel.cancelprefetchImage(indexPaths)
    }
}
