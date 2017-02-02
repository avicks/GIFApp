//
//  GIFViewController.swift
//  GIFApp
//
//  Created by Alex Vickers on 1/31/17.
//  Copyright © 2017 skciva. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Moya
import Moya_ObjectMapper
import NSObject_Rx

final class GIFViewController : UIViewController {
   
   //MARK: - Public properties
   var viewModel : GifCollectionViewModelProtocol!
   
   //MARK: - Private properties
   fileprivate let startLoadingOffset: CGFloat = 5.0
   fileprivate let disposeBag = DisposeBag()
   
   // defualt view to display when no GIFs are found
   @IBOutlet fileprivate weak var defaultView: UIView!
   
   @IBOutlet fileprivate weak var gifCollectionView: UICollectionView!
   
   @IBOutlet fileprivate weak var gifSearchBar: UISearchBar!
   
   //MARK: - View lifecycle
   override func viewDidLoad() {
      super.viewDidLoad()
      setupBindings()
   }
   
}

//MARK: - Setup
private extension GIFViewController {
   func setupBindings() {
      setupViewModel()
      setupKeyboard()
   }
   
   func setupViewModel() {
      
      let searchString = gifSearchBar.rx.text.orEmpty
         .throttle(0.3, scheduler: MainScheduler.instance)
         .distinctUntilChanged()
         .shareReplay(1)
      
      let pageTrigger = gifCollectionView.rx
      .contentOffset
         .filter {
            [weak self] offset in
            
            // https://github.com/apple/swift-evolution/blob/master/proposals/0079-upgrade-self-from-weak-to-strong.md
            guard let strongSelf = self else { return false }
            
            return ((strongSelf.gifCollectionView.contentOffset.y + strongSelf.gifCollectionView.frame.size.height) >=
               (strongSelf.gifCollectionView.contentSize.height - strongSelf.startLoadingOffset))
         }
         .flatMap { _ in return Observable.just() }
      
      guard let viewModel = viewModel else {
         print("uh oh")
         return
      }
      
      viewModel.setUpObservables(pageTrigger: pageTrigger, searchString: searchString)

      // Bind collection view to GIF results now that view model is set up
      setupCollectionView()
   }
   
   
   func setupCollectionView() {
      
      // bind our GIF set to individual collection cells
      viewModel.gifs
      .bindTo(gifCollectionView.rx.items(cellIdentifier: "gifCell", cellType: GIFCollectionViewCell.self),
              curriedArgument: configureCell)
      .addDisposableTo(disposeBag)
      
      // bind our GIF set being empty to displaying the default view
      viewModel.gifs
         .map { gifs in gifs.count != 0 }
      .bindTo(defaultView.rx.isHidden)
      .addDisposableTo(disposeBag)
   }
    
   
   func setupKeyboard() {
      gifCollectionView.rx.contentOffset.subscribe(onNext: { [weak self] _ in
         
         guard let strongSelf = self else { return }
         
         if(strongSelf.gifSearchBar.isFirstResponder) {
            strongSelf.gifSearchBar.resignFirstResponder()
         }
      })
      .addDisposableTo(disposeBag)
   }
   
   func configureCell(_ row: Int, viewModel: GifProtocol, cell: GIFCollectionViewCell) {
      cell.viewModel = viewModel
   }
}
