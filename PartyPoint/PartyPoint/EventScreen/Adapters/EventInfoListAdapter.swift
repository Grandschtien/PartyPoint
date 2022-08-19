//
//  EventInfoListAdapter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 19.08.2022.
//

import UIKit

final class EventInfoListAdapter: NSObject {
    typealias DataSource = UITableViewDiffableDataSource<Section<Event>, Event>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section<Event>, Event>
    
    private var sections: [Section<Event>]
    //Weak refereces
    private weak var tableView: UITableView?
    
    private lazy var dataSource: DataSource = setupDataSource()

    
    init(_ tableView: UITableView) {
        self.tableView = tableView
        sections = []
        super.init()
        tableView.delegate = self
    }
    
    /// This function must be envoked after initialize, because it configurates adapter
    /// - Parameter sections: Array of sections you want to have
    func configure(_ sections: [Section<Event>]) {
        self.sections.append(contentsOf: sections)
        applySnapshot()
    }
}
//MARK: - DataSource
private extension EventInfoListAdapter {
    private func setupDataSource() -> DataSource {
        guard let tableView = tableView else {
            fatalError("no table view")
        }
        
        let dataSource = DataSource(tableView: tableView) { tableView, indexPath, item in
            switch indexPath.row {
            case 0:
                let locationCell = tableView.dequeue(cellType: LocationCell.self, for: indexPath)
                return locationCell
            case 1:
                let descriptionCell = tableView.dequeue(cellType: DescriptionCell.self, for: indexPath)
                return descriptionCell
            case 2:
                let payCell = tableView.dequeue(cellType: EventWithButtonCell.self, for: indexPath)
                return payCell
            case 3:
                let peopleCell = tableView.dequeue(cellType: EventWithButtonCell.self, for: indexPath)
                return peopleCell
            case 4:
                let mapCell = tableView.dequeue(cellType: MapCell.self, for: indexPath)
                return mapCell
            default:
                return UITableViewCell()
            }
        }
        return dataSource
    }
    
    private func applySnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections(sections)
        for section in sections {
            snapshot.appendItems(section.items, toSection: section)
        }
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension EventInfoListAdapter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = sections[section].header
        let view = tableView.dequeueSupplementaryView(ofType: EventHeader.self)
        return view
    }
}
