//
//  GIFCollectionViewCell.swift
//  GIFApp
//
//  Created by Alex Vickers on 1/31/17.
//  Copyright © 2017 skciva. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher
import SnapKit

final class GIFCollectionViewCell : UICollectionViewCell {
   
   //MARK: - Public properties
   var viewModel : GifProtocol? {
      didSet {
         gifImageView.kf.setImage(with: viewModel?.gifURL)
      }
   }
   
   //MARK: - Private properties
   fileprivate lazy var gifImageView : AnimatedImageView = {
      let animatedImageView = AnimatedImageView()
      animatedImageView.contentMode = .scaleAspectFit
      return animatedImageView
   }()
   
   //MARK: - View lifecycle
   override func awakeFromNib() {
      super.awakeFromNib()
      gifImageView.kf.indicatorType = .activity
      contentView.addSubview(gifImageView)
      
      /*
      box.snp.makeConstraints { (make) -> Void in
         make.width.height.equalTo(50)
         make.center.equalTo(self.view)
      }
      */
      
      gifImageView.snp.makeConstraints { (make) -> Void in
         make.height.equalTo(contentView.snp.height)
         make.centerY.equalTo(contentView.snp.centerY)
         make.trailing.equalTo(contentView.snp.trailingMargin)
         make.leading.equalTo(contentView.snp.leadingMargin)
         
      }
      
   }
   
   override func prepareForReuse() {
      
      // does nothing, but recommended to call anyway..
      super.prepareForReuse()
      gifImageView.image = nil
   }
}
