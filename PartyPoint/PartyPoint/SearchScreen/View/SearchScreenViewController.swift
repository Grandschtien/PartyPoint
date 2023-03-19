//
//  SearchScreenViewController.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 24.02.2023.
//  
//

import SnapKit

private let SEARCH_BAR_HORIZAONTAL_INSETS: CGFloat = 16
private let SEARCH_BAR_HEIGHT: CGFloat = 35.scale()

final class SearchScreenViewController: UIViewController {
    
    // MARK: Private propeties
    private let presenter: SearchScreenPresenter
    private lazy var resultView = SearchResultsView()
    private lazy var defaultSearchView = DefaultSearchView()
    private lazy var searchEmptyView = SearchEmptyView()
    private lazy var emptySearchView = UIView()
    private lazy var searchController = PPSearchController(searchResultsController: nil)
    
    // MARK: Init
    init(presenter: SearchScreenPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        defaultSearchView.startAnimation()
        searchEmptyView.startAnimation()
    }
}

// MARK: Private methods
private extension SearchScreenViewController {
    func setupUI() {
        self.view.backgroundColor = Colors.mainColor()
        title = Localizable.search()
        
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        self.navigationItem.searchController = searchController
        
        view.addSubview(defaultSearchView)
        view.addSubview(searchEmptyView)
        view.addSubview(resultView)
        
        defaultSearchView.configure(with: .default)
        searchEmptyView.configure(with: .empty)
        
        resultView.isHidden = true
        searchEmptyView.isHidden = true
        
        setupActions()
        setupConstaints()
    }
    
    func setupConstaints() {
        resultView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.right.bottom.equalToSuperview()
        }
        
        defaultSearchView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        searchEmptyView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setupActions() {
        resultView.setLikeAction { index in
            
        }
        
        resultView.setUnlikeAction { index in
            
        }
        
        resultView.setOnButtonTapped { [weak self] index in
            self?.presenter.openEvent(withIndex: index)
        }
        
        resultView.setLoadNextPage { [weak self] page in
            self?.presenter.loadNextPageWithWithCurrentLexeme(page: page)
        }
    }
}

// MARK: SearchScreenView
extension SearchScreenViewController: SearchScreenView {
    func setVisibilityOfResultsView(isHidden: Bool) {
        resultView.isHidden = isHidden
    }
    
    func setVisibilityOfEmptyView(isHidden: Bool) {
        searchEmptyView.isHidden = isHidden
    }
    
    func setVisibilityOfDefaultView(isHidden: Bool) {
        defaultSearchView.isHidden = isHidden
    }
    
    func updateViewWithInitialSearchContent(info: [EventInfo]) {
        resultView.setInitialContent(items: info)
    }
    
    func needsShowLoader(isLoading: Bool) {
        self.showLoaderIfNeeded(isLoading: isLoading)
    }
    
    func updateViewWithNewPageOfEvents(info: [EventInfo]) {
        resultView.update(withItems: info)
    }
    
    func openEventScreen(withEvent event: EventInfo) {
        let context = EventContext(eventId: event.id, placeId: event.placeId)
        let assembly = EventContainer.assemble(with: context)
        self.navigationController?.pushViewController(assembly.viewController, animated: true)
    }
}

extension SearchScreenViewController: UISearchControllerDelegate {
    func willPresentSearchController(_ searchController: UISearchController) {
        UIView.animate(withDuration: 0.3) { [self] in
            presenter.willPresentSearch()
        }
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        UIView.animate(withDuration: 0.3) { [self] in
            presenter.willDismissSearch()
            resultView.clearDataSource()
        }
    }
}

extension SearchScreenViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        presenter.searchStarted(searchString: searchController.searchBar.text)
    }
}
