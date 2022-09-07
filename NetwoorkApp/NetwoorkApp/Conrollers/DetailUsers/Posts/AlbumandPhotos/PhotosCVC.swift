//
//  PhotosCVC.swift
//  NetwoorkApp
//
//  Created by сергей on 7.09.22.
//

import Alamofire
import AlamofireImage
import SwiftyJSON
import UIKit

class PhotosCVC: UICollectionViewController {
    var user: User!
    var album: JSON!
    var photos: [JSON] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = album["title"].string // вызываем тайтл из альбома
        getData()
    }

    override func viewWillAppear(_ animated: Bool) {
        let layout = UICollectionViewFlowLayout()
        let sizeWH = UIScreen.main.bounds.width / 2 - 5
        layout.itemSize = CGSize(width: sizeWH, height: sizeWH)
        collectionView.collectionViewLayout = layout
    }

    func getData() {
        if let album = album, // извлекаем альбом
           let albumId = album["id"].int, // из альбома забираем айди
           let url = URL(string: "https://jsonplaceholder.typicode.com/photos?albumId=\(albumId)")
        { // лезем в фото и устанавливаем пармер альбомайди==альбом айди
            AF.request(url).responseJSON { response in
                switch response.result {
                case .success(let data):
                    self.photos = JSON(data).arrayValue // вытаскиваем фотограыфии
                    self.collectionView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }

    // MARK: - UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        cell.photo = photos[indexPath.row] // вытаскиваем одну фотографию
        cell.configureCell()
        cell.getThumbnail() // вызываем метод который запустит в другом потоке показ картинки
        return cell
    }

    // MARK: - UICollectionViewDelegate

//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "showPhoto", sender: photos[indexPath.row])
//    }
//
//    // MARK: - Navigation
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let imageVC = segue.destination as? ImageVC,
//           let photo = sender as? JSON {
//            imageVC.photo = photo
//        }
//    }
}
