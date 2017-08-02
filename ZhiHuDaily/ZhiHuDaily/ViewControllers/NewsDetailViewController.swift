//
//  NewsDetailViewController.swift
//  ZhiHuDaily
//
//  Created by xiaoP on 2017/7/31.
//  Copyright © 2017年 Chicv. All rights reserved.
//

import UIKit
import WebKit
import SnapKit
import RxSwift

class NewsDetailViewController: BaseViewController {
    
    let news: News
    fileprivate let favoriteButton = UIButton(type: .custom)
    fileprivate let webView = WKWebView(frame: .zero)
    fileprivate let aiv = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    let bag = DisposeBag()

    
    init(news: News) {
        self.news = news
        super.init()
        favoriteButton.setTitle("♥︎", for: .normal)
        favoriteButton.setTitleColor(.gray, for: .normal)
        favoriteButton.setTitleColor(.red, for: .selected)
        favoriteButton.isSelected = news.isFavorited
        favoriteButton.sizeToFit()
        guard let url = URL(string: news.weburl) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        bind()
    }

    fileprivate func configUI() {
        title = "Detail"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: favoriteButton)
        
        view.addSubview(webView)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.snp.makeConstraints { (make: ConstraintMaker) in
            make.edges.equalToSuperview()
        }
        
        aiv.hidesWhenStopped = true
        view.addSubview(aiv)
        aiv.snp.makeConstraints { (make: ConstraintMaker) in
            make.center.equalToSuperview()
        }
    }
    
    fileprivate func bind() {
        favoriteButton.rx.tap
            .bind { [weak self] (_) in
                guard let `self` = self else { return }
                let action = LatestNewsAction.ChangeFavorite(news: self.news)
                appStore.dispatch(action)
            }
            .disposed(by: bag)
    }
    
}

extension NewsDetailViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        aiv.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        aiv.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        aiv.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        aiv.stopAnimating()
    }
    
}

extension NewsDetailViewController: WKUIDelegate {
    
    
    
}

