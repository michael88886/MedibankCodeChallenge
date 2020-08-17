//  Copyright © 2020 Michael.H. All rights reserved.

import UIKit

class HeadlineViewController: UIViewController {

    private enum Constant {
        static let rowHeight: CGFloat = 240
        static let cellId: String = "HeadlineCell"
    }
    
    // MARK: - IBOutlet
    /// The headline table view
    @IBOutlet private var tableview: UITableView!
    
    /// The loading spinner
    @IBOutlet private var spinner: UIActivityIndicatorView!
    
    // MARK: - Properties
    /// The view model
    private var viewModel = HeadlineViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupViewModel()
        viewModel.loadHeadlines()
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
    
    func errorOccur(_ message: String) {
        tableview.isHidden = true
        let alert = Utility.errorAlert(with: "Fetch Error", message: message)
        self.present(alert, animated: true, completion: nil)
    }
    
    func reloadData() {
        tableview.reloadData()
    }
    
    func openlink(_ urlString: String) {
        let url = URL(string: urlString)!
        let webViewController = WebViewController(url: url)
        self.present(webViewController, animated: true, completion: nil)
    }
    
    
    // MARK: - Private helper
    private func setupTableView() {
        tableview.delegate = self
        tableview.dataSource = self
//        tableview.prefetchDataSource = self
        tableview.rowHeight = Constant.rowHeight
        tableview.register(UINib(nibName: "HeadlineCell", bundle: nil), forCellReuseIdentifier: Constant.cellId)
    }
    
    private func setupViewModel() {
        viewModel.isLoading = isLoading
        viewModel.fetchError = errorOccur
        viewModel.reloadData = reloadData
        viewModel.openlink = openlink
    }
}

// MARK: - Tableview data source
extension HeadlineViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.headlineList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constant.cellId,
            for: indexPath) as? HeadlineCell else {
                return UITableViewCell()
        }
        
        let article = viewModel.headlineList[indexPath.row]
        cell.updateCell(data: article)
        return cell
    }
}

// MARK: - Tableview delegate
extension HeadlineViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.openItem(indexPath)
    }
}
