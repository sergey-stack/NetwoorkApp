//
//  PhotoCollectionViewCell.swift
//  NetwoorkApp
//
//  Created by сергей on 7.09.22.
//

import Alamofire
import AlamofireImage
import SwiftyJSON
import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var photoImage: UIImageView!

    var photo: JSON! // при создании ячейки передаём фото

    func configureCell() {
        photoImage.image = #imageLiteral(resourceName: "default-image")
    }

    func getThumbnail() {
        if let thumbnailURL = photo["thumbnailUrl"].string {
            if let image = CacheManager.shared.imageCache.image(withIdentifier: thumbnailURL) {
                activityIndicator.stopAnimating()
                photoImage.image = image
            } else {
                AF.request(thumbnailURL).responseImage { [weak self] response in // обращаемся к аф вкидываем юрл
                    if case .success(let image) = response.result {
                        self?.activityIndicator.stopAnimating()
                        self?.photoImage.image = image // вставляем картинку в photoImage
                        CacheManager.shared.imageCache.add(image, withIdentifier: thumbnailURL)
                    }
                }
            }
        }
    }
}
