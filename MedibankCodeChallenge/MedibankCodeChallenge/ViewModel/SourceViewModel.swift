//  Copyright © 2020 Michael.H. All rights reserved.

import Foundation
import RxSwift

class SourceViewModel {

    // MARK: - Properties
    /// The source service
    private let sourceService = SourceService()
    
    /// Current sources
    private(set) var sources = [SourceItem]()
    
    /// Selected sources
    private(set) var selectedIndexes = [IndexPath]()
    
    /// The dispose bag
    private let disposeBag = DisposeBag()
    
    // MARK: - Closures
    var isLoading: ((Bool) -> Void)?
    var fetchError: ((String) -> Void)?
    var reloadData: (() -> Void)?
    var reloadRow: ((IndexPath) -> Void)?
    
    // MARK: - Functions
    func loadSource() {
        isLoading?(true)
        
        // Load sources from web service
        sourceService.loadSource()
            .observeOn(MainScheduler.instance)
            .subscribe(
                onSuccess: { [weak self] sourceModel in
                    if let errorMessage = sourceModel.errorMessage {
                        self?.handleFetchError(errorMessage)
                        return
                    }
                    
                    self?.sources = sourceModel.sources
                    self?.fetchSavedSources()
                },
                onError: { [weak self] error in
                    if let serviceError = error as? AppError {
                        let message = serviceError.message()
                        self?.handleFetchError(message)
                    }
                })
            .disposed(by: disposeBag)
    }
    
    func selectSource(_ indexpath: IndexPath) {
        if let index = selectedIndexes.firstIndex(where: { $0 == indexpath }) {
            // Switch flags
            selectedIndexes.remove(at: index)
        }
        else {
            selectedIndexes.append(indexpath)
        }
        sources[indexpath.row].selected = !sources[indexpath.row].selected
        reloadRow?(indexpath)
    }
    
    // Save selected sources to core data
    func saveSource() {
        // Get selected item
        let selectedItems = selectedIndexes.map { sources[$0.row] }
        sourceService.saveToCoreData(items: selectedItems)
    }
    
    // MARK: - Private helper
    private func fetchSavedSources() {
        
        sourceService.fetchSelectedSources()
            .observeOn(MainScheduler.instance)
            .subscribe(
                onSuccess: { [weak self] sourceIds in
                    self?.checkSelectedResult(sourceIds)
                },
                onError: { [weak self] error in
                    if let serviceError = error as? AppError {
                        let message = serviceError.message()
                        self?.handleFetchError(message)
                    }
                })
            .disposed(by: disposeBag)
    }
    
    // Update data with saved source
    private func checkSelectedResult(_ savedSourceIds: [String]) {
        // Reset selected indexes
        self.selectedIndexes.removeAll()
        
        guard savedSourceIds.count > 0 else {
            finishLoading()
            return
        }
        
        for id in savedSourceIds {
            if let index = sources.firstIndex(where: { $0.id == id }) {
                sources[index].selected = true
                selectedIndexes.append(IndexPath(row: index, section: 0))
            }
        }
        finishLoading()
    }
    
    private func handleFetchError(_ message: String) {
        isLoading?(false)
        fetchError?(message)
    }
    
    private func finishLoading() {
        self.isLoading?(false)
        self.reloadData?()
    }
}
