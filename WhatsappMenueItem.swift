extension ViewController:UITableViewDelegate{
     func tableView(
      _ tableView: UITableView,
      contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint)
        -> UIContextMenuConfiguration? {
      // 1
      let index = indexPath.row
        let model = models[index]
      
      // 2
      let identifier = "\(index)" as NSString
      
      return UIContextMenuConfiguration(
        identifier: identifier,
        previewProvider: nil) { _ in
          // 3
          let mapAction = UIAction(
            title: "View map",
            image: UIImage(systemName: "map")) { _ in
		//add your action code here 
//              self.showMap(model: model)
          }
          
          // 4
          let shareAction = UIAction(
            title: "Share",
            image: UIImage(systemName: "square.and.arrow.up")) { _ in
		//add your action code here 
//              VacationSharer.share(vacationSpot: vacationSpot, in: self)
          }
          
          // 5
          return UIMenu(title: "", image: nil, children: [mapAction, shareAction])
      }
    }
}
