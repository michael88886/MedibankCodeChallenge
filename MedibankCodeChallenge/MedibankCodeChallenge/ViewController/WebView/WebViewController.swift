//  Copyright © 2020 Michael.H. All rights reserved.

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {

    // MARK: - Properties
    /// The navigation bar
    private var navigationBar: UINavigationBar!
    
    /// The progress bar
    private var progressBar: UIProgressView!
    
    /// The web view
    private var webView: WKWebView!
    
    private var webUrl: URL
    
    // MARK: - Lifecycle
    init(url: URL) {
        self.webUrl = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        super.loadView()
        // Navigation bar
        navigationBar = UINavigationBar(frame: .zero)
        view.addSubview(navigationBar)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        let navItem = UINavigationItem(title: "")
        let backBtn = UIBarButtonItem(
            image: UIImage(systemName: "xmark")!.withRenderingMode(.alwaysTemplate),
            style: .plain,
            target: self,
            action: #selector(dismissController))
        backBtn.tintColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        navItem.leftBarButtonItem = backBtn
        navigationBar.setItems([navItem], animated: false)
        
        // Progress bar
        progressBar = UIProgressView(progressViewStyle: .default)
        progressBar.trackTintColor = .white
        progressBar.progressTintColor = .orange
        view.addSubview(progressBar)
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressBar.topAnchor.constraint(equalTo: navigationBar.bottomAnchor).isActive = true
        progressBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        progressBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        // Web view
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: progressBar.bottomAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.title), options: .new, context: nil)
        
//        let myURL = URL(string: "https://www.apple.com")
        let myRequest = URLRequest(url: webUrl)
        webView.load(myRequest)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressBar.progress = Float(webView.estimatedProgress)
        }
        
        if keyPath == "title" {
            navigationBar.topItem?.title = webView.title
        }
    }
    
    // MARK: - Private helper
    @objc private func dismissController() {
        self.dismiss(animated: true, completion: nil)
    }
}
