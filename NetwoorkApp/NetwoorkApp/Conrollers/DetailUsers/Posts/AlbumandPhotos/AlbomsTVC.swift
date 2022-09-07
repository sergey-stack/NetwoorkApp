//
//  AlbomsTVC.swift
//  NetwoorkApp
//
//  Created by сергей on 7.09.22.
//
    
    import UIKit
    import Alamofire
    import SwiftyJSON

    class AlbomsTVC: UITableViewController {

        var user: User!
        var alboms: [JSON] = []

        override func viewDidLoad() {
            getData()
        }

        private func getData() {

            guard let userId = user?.id else { return }//вытаскиваем айди юсера
            
            guard let url = URL(string: "\(ApiConstants.albumsPath)?userId=\(userId)") else { return }//делаем фильтрацию по юсер айди

            AF.request(url).responseJSON { response in
                switch response.result {
                case .success(let data):
                    self.alboms = JSON(data).arrayValue//декодируем в джейсон и преобразуем в эррейвелью
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }

        // MARK: - Table view data source

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return alboms.count
        }

        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "Cell")
            cell.textLabel?.text = (alboms[indexPath.row]["id"].int ?? 0).description//вытаскиваем по индексу один альбом,по ключику айди вытаскиваем инт
            cell.detailTextLabel?.text = alboms[indexPath.row]["title"].stringValue
            cell.detailTextLabel?.numberOfLines = 0
            return cell
        }

        // MARK: - Table view delegate
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let albom = alboms[indexPath.row]
            performSegue(withIdentifier: "showPhotos", sender: albom)
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showPhotos",
                let photosCollectionVC = segue.destination as? PhotosCVC,
                let album = sender as? JSON {//вытаскиваем из сендера джейсон
                photosCollectionVC.user = user
                photosCollectionVC.album = album
            }
        }

    }
