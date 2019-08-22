//
//  GuideViewController.swift
//  DanBee_iOS
//
//  Created by 남수김 on 22/08/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxOptional

class GuideViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    let imageSet = ["1","2","3","4","5"]
    
    let indexObservable: BehaviorSubject<Int> = BehaviorSubject(value: 0)
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        bindInput()
       
    }
}

extension GuideViewController {
    
    func bindInput(){
    

    
    }
    
    func bindOutput(){
        
    }
}



extension GuideViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageSet.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: GuideCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "guide", for: indexPath) as? GuideCollectionViewCell else{fatalError()}
        return cell
    }
    
    //아이템 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width - 10
        let height = self.view.frame.height - 96
        
        return CGSize(width: width, height: height)
    }
    
    //아이템간 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 5, bottom: 0, right: 5)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let current = self.collectionView.contentOffset.x
        let width = self.collectionView.frame.size.width
        let index = width / current
        print(index)
    }

}
