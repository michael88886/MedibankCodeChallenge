//  Copyright © 2020 Michael.H. All rights reserved.

import UIKit

class SourceViewController: UIViewController {

    // MARK: - Properties
    /// The view model
    private var viewModel = SourceViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

// MARK: - Tableview data source
extension SourceViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
