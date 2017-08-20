//
//  GridViewController.swift
//  KurashiruDemoApp
//
//  Created by TakanoYuki on 2017/08/19.
//  Copyright © 2017年 TakanoYuki. All rights reserved.
//

import UIKit

class GridViewController: AbstractViewController {
    let kWarnTxt = "データが取得できませんでした。ネットワーク環境に接続している事をご確認下さい。"
    let kFavoriteFurtherNote = "お気に入り画面で画像をタップするとお気に入り解除出来ます。"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showIndicator()
        fetchAPI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func fetchAPI() {
        dispatch_async_global({
            DishModelManager.shared.getServerDishModels(loadComplete: { (dishModels: [DishModel]) -> Void in
                self.indicator.stopAnimating()
                if dishModels.count > 0 {
                    self.collectionDatas = dishModels
                    self.collectionView.reloadData()
                } else {
                    let alertController = UIAlertController(title: self.kWarnTxt, message: nil, preferredStyle: .alert)
                    let action = UIAlertAction(title: "再試行", style: .default) { (action: UIAlertAction) in
                        self.fetchAPI()
                    }
                    alertController.addAction(action)
                    self.present(alertController, animated: true, completion: nil)
                    self.indicator.startAnimating()
                }
            })
        })
    }
}

extension GridViewController: UICollectionViewDataSource {
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

extension GridViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dishModel = collectionDatas[indexPath.row]
        DishModelManager.shared.registerFavoriteItem(dishModel, flg: true)
        let title = "「" + dishModel.title + "」をお気に入りに追加しまいた"
        let alertController = UIAlertController(title: title, message: kFavoriteFurtherNote, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}
