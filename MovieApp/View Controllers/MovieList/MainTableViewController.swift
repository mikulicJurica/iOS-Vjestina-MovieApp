import UIKit
import SnapKit

class MainTableViewController: UIViewController {
    
    private var mainTableView: UITableView!
    
    private var mainTableViewCellName = "MovieTableViewCell"
    
    private var movieGroups = MovieGroups.allCases

    override func viewDidLoad() {
        super.viewDidLoad()

        buildViews()
        buildConstraints()
    }
    
    private func buildViews() {
        mainTableView = UITableView()
        mainTableView.register(MainTableViewCell.self, forCellReuseIdentifier: mainTableViewCellName)
        mainTableView.rowHeight = StyleConstants.MainTableViewCellLengths.movieCellHeight
        mainTableView.separatorColor = .clear
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        view.addSubview(mainTableView)
    }
    
    private func buildConstraints() {
        mainTableView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
    }
}

extension MainTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: mainTableViewCellName) as! MainTableViewCell
        cell.contentView.isUserInteractionEnabled = false //not interactable
        cell.selectionStyle = .none
        cell.set(inputGroup: movieGroups[indexPath.row])
        return cell
    }
}

extension MainTableViewController: UITableViewDelegate {
}
