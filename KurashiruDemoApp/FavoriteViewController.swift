//
//  FavoriteViewController.swift
//  KurashiruDemoApp
//
//  Created by TakanoYuki on 2017/08/19.
//  Copyright © 2017年 TakanoYuki. All rights reserved.
//

import UIKit

class FavoriteViewController: AbstractViewController {
    let kWarnLabelTxt = "お気に入りデータがありません。"
    let warnLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        warnLabel.text = kWarnLabelTxt
        warnLabel.isHidden = true
        warnLabel.numberOfLines = 0
        self.view.addSubview(warnLabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showIndicator()
        fetchDB()
    }
    
    fileprivate func fetchDB() {
        collectionDatas = DishModelManager.shared.getDBDishModels()
        indicator.stopAnimating()
        collectionView.reloadData()
        if collectionDatas.count == 0 {
            warnLabel.center = self.view.center
            warnLabel.isHidden = false
        } else {
            warnLabel.isHidden = true
        }
    }
}

extension FavoriteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellName, for: indexPath) as! DishCell
        let dishModel = collectionDatas[indexPath.row]
        cell.setData(title: dishModel.title, url: dishModel.thumbnailUrl)
        
        return cell
    }
}

extension FavoriteViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dishModel = collectionDatas[indexPath.row]
        DishModelManager.shared.registerFavoriteItem(dishModel, flg: false)
        let title = "「" + dishModel.title + "」をお気に入りから削除しまいた"
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action: UIAlertAction) in
            self.fetchDB()
        }
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}

