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
import MaterialCard

class GuideViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    let imageSet = ["guide1","guide2","guide3","guide4","guide5"]
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        bind()
       
    }
}

extension GuideViewController {
    //인덱스변화에따른 페이지컨트롤 변화
    func bind(){
         self.collectionView.rx.didEndDragging.delay(RxTimeInterval.milliseconds(300), scheduler: MainScheduler.instance)
            .subscribe(onNext: { b in
                guard let indexPath = self.collectionView.indexPathsForVisibleItems.first else {return}
                self.pageControl.currentPage = indexPath.item
            })
        .disposed(by: disposeBag)
    
    }
  
}



extension GuideViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageSet.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: GuideCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "guide", for: indexPath) as? GuideCollectionViewCell else{fatalError()}
        let img = UIImage(named: imageSet[indexPath.item])
        cell.guideImg.image = img
        cell.cardView.backgroundColor = UIColor.danbeeColor1
        
        return cell
    }
    
    //아이템 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width - 10
        let height = self.view.frame.height - 286
        
        return CGSize(width: width, height: height)
    }
    
    //아이템간 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 5, bottom: 0, right: 5)
    }
    
}
