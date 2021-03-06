//
//  MainViewController.swift
//  HapticCards
//
//  Created by Dheeraj Kumar Sharma on 27/06/20.
//  Copyright © 2020 Dheeraj Kumar Sharma. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let imageArr = ["img1", "img2", "img3"]
    
    let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    
    lazy var collectionView:UICollectionView = {
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        cv.setCollectionViewLayout(layout, animated: false)
        cv.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: "CardCollectionViewCell")
        cv.backgroundColor = .clear
        cv.delaysContentTouches = false
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout.scrollDirection = .vertical
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.9)
        view.addSubview(collectionView)
        setUpConstraints()
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

extension MainViewController:UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath) as! CardCollectionViewCell
        cell.CustomImage.image = UIImage(named: imageArr[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
            cell.CardView.transform = .init(scaleX: 0.95, y: 0.95)
            cell.CustomImage.transform = .init(scaleX: 1.2, y: 1.2)
            cell.OverLay.alpha = 1
        } ,completion:nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
            cell.CardView.transform = .identity
            cell.CustomImage.transform = .identity
            cell.OverLay.alpha = 0
        } ,completion:nil)
    }
    
}
