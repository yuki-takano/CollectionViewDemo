//
//  AbstractViewController.swift
//  KurashiruDemoApp
//
//  Created by TakanoYuki on 2017/08/19.
//  Copyright © 2017年 TakanoYuki. All rights reserved.
//

import UIKit

class AbstractViewController: UIViewController {
    
    /*  
    画面遷移がないため本来不要だが、CollectionViewがUINavigationBarに
    ぶつからないよう8xマージンを開けるという仕様があるため、追加した。
    */
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let indicator = UIActivityIndicatorView()
    var collectionDatas = [DishModel]()
    
    let kCellName = "DishCell"
    let kGridNum = 2
    let kGridSpace: CGFloat = 1.0
    let kEdgeInsetValue: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: kCellName, bundle: nil),
                                forCellWithReuseIdentifier: kCellName)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.layoutIfNeeded()
        let inset = UIEdgeInsets(top: kEdgeInsetValue, left: kEdgeInsetValue, bottom: kEdgeInsetValue, right: kEdgeInsetValue)
        collectionView.adaptGrid(kGridNum, gridLineSpace: kGridSpace, sectionInset: inset)
    }
    
    func showIndicator() {
        indicator.activityIndicatorViewStyle = .gray
        indicator.center = view.center
        indicator.color = UIColor.gray
        indicator.hidesWhenStopped = true
        self.view.addSubview(indicator)
        indicator.startAnimating()
    }
    
}

extension AbstractViewController {
    func dispatch_async_main(_ block: @escaping () -> ()) {
        DispatchQueue.main.async(execute: block)
    }
    
    func dispatch_async_global(_ block: @escaping () -> ()) {
        DispatchQueue.global(qos: .`default`).async(execute: block)
    }
}
