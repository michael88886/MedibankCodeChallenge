//  Copyright © 2020 Michael.H. All rights reserved.

import UIKit

class SourceViewController: UIViewController {

    private enum Constant {
        static let rowHeight: CGFloat = 80
        static let cellId: String = "SourceCell"
    }
    
    // MARK: - IBOutlet
    /// The source table view
    @IBOutlet private var tableview: UITableView!
    
    /// The loading spinner
    @IBOutlet private var spinner: UIActivityIndicatorView!
    
    // MARK: - Properties
    /// The view model
    private var viewModel = SourceViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Observer for save selected sources
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(addRefreshObeserver),
                                               name: UIApplication.didEnterBackgroundNotification,
                                               object: nil)
        setupTableView()
        setupViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refreshData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        saveSource()
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
    
    func reloadRow(_ indexpath: IndexPath) {
        tableview.reloadRows(at: [indexpath], with: .none)
    }
    
    // MARK: - Private helper
    private func setupTableView() {
        tableview.delegate = self
        tableview.dataSource = self
        tableview.rowHeight = Constant.rowHeight
        tableview.register(UINib(nibName: "SourceCell", bundle: nil), forCellReuseIdentifier: Constant.cellId)
        tableview.allowsSelectionDuringEditing = true
        tableview.allowsMultipleSelectionDuringEditing = true
    }
    
    private func setupViewModel() {
        viewModel.isLoading = isLoading
        viewModel.fetchError = errorOccur
        viewModel.reloadData = reloadData
        viewModel.reloadRow = reloadRow
    }
    
    @objc private func saveSource() {
        viewModel.saveSource()
    }
    
    @objc private func addRefreshObeserver() {
        saveSource()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(removeRefreshObserver),
                                               name: UIApplication.didBecomeActiveNotification,
                                               object: nil)
    }
    
    @objc private func removeRefreshObserver() {
        refreshData()
        NotificationCenter.default.removeObserver(self,
                                                  name: UIApplication.didBecomeActiveNotification,
                                                  object: nil)
    }
    
    @objc private func refreshData() {
        viewModel.loadData()
    }
}

// MARK: - Tableview data source
extension SourceViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constant.cellId,
            for: indexPath) as? SourceCell else {
                return UITableViewCell()
        }
        
        let source = viewModel.sources[indexPath.row]
        cell.updateCell(data: source)
        return cell
    }
}

// MARK: - Tableview data delegate
extension SourceViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectSource(indexPath)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        viewModel.selectSource(indexPath)
    }
}
