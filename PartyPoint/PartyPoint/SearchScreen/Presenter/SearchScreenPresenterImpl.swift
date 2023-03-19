//
//  SearchScreenPresenterImpl.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 24.02.2023.
//  
//

import Foundation

final class SearchScreenPresenterImpl {
    private weak var view: SearchScreenView?
    private var timer: Timer?
    private let contentLoader: SearchContentLoader
    
    init(contentLoader: SearchContentLoader) {
        self.contentLoader = contentLoader
    }
}

// MARK: Private methods
private extension SearchScreenPresenterImpl {

}

// MARK: Public methods
extension SearchScreenPresenterImpl {
    func setView(_ view: SearchScreenView) {
        self.view = view
    }
}

// MARK: SearchScreenPresenter
extension SearchScreenPresenterImpl: SearchScreenPresenter {
    func willPresentSearch() {
        view?.setVisibilityOfResultsView(isHidden: false)
        view?.setVisibilityOfDefaultView(isHidden: true)
    }
    
    func willDismissSearch() {
        view?.setVisibilityOfResultsView(isHidden: true)
        view?.setVisibilityOfEmptyView(isHidden: true)
        view?.setVisibilityOfDefaultView(isHidden: false)
        contentLoader.clearSearch()
    }
    
    func searchStarted(searchString str: String?) {
        timer?.invalidate()
        
        if let str = str, !str.isEmpty {
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] timer in
                guard let `self` = self else { return }
                self.view?.setVisibilityOfEmptyView(isHidden: true)
                self.view?.setVisibilityOfResultsView(isHidden: true)
                self.view?.needsShowLoader(isLoading: true)

                Task {
                    let events = await self.contentLoader.loadInitialContentContent(lexeme: str)
                    await runOnMainThread {
                        self.view?.needsShowLoader(isLoading: false)
                        if events.isEmpty {
                            self.view?.setVisibilityOfResultsView(isHidden: true)
                            self.view?.setVisibilityOfEmptyView(isHidden: false)
                        } else {
                            self.view?.updateViewWithInitialSearchContent(info: events)
                            self.view?.setVisibilityOfResultsView(isHidden: false)
                            self.view?.setVisibilityOfEmptyView(isHidden: true)
                        }
                    }
                }
            })
        } else {
            self.contentLoader.clearSearch()
        }
    }
    
    func loadNextPageWithWithCurrentLexeme(page: Int) {
        Task {
            let events = await contentLoader.loadMoreContentByLexeme(page: page)
            await runOnMainThread {
                view?.updateViewWithNewPageOfEvents(info: events)
            }
        }
    }
    
    func openEvent(withIndex index: Int) {
        let event = contentLoader.getEvent(byIndex: index)
        view?.openEventScreen(withEvent: event)
    }
}

