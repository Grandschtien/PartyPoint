//
//  MoreEventsPresenterImpl.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 25.02.2023.
//  
//

import Foundation

final class MoreEventsPresenterImpl {
    private weak var view: MoreEventsView?
    private let loader: MoreContentLoader
    private let contentProvider: MoreContentProvider
    private let likeManager: LikeManager
    
    init(loader: MoreContentLoader, contentProvider: MoreContentProvider, likeManager: LikeManager) {
        self.loader = loader
        self.contentProvider = contentProvider
        self.likeManager = likeManager
    }
}

// MARK: Private methods
private extension MoreEventsPresenterImpl {
}

// MARK: Public methods
extension MoreEventsPresenterImpl {
    func setView(_ view: MoreEventsView) {
        self.view = view
    }
}

// MARK: MoreEventsPresenter
extension MoreEventsPresenterImpl: MoreEventsPresenter {
    func likeEvent(index: Int) {
        Task {
            let eventId = contentProvider.getEvent(withIndex: index).id
            contentProvider.setLikeEvent(isLiked: true, withIndex: index)
            await likeManager.likeEvent(withId: eventId)
            await runOnMainThread {
                view?.updateViewWithLike(isLiked: true, index: index)
            }
        }
    }
    
    func unlikeEvent(index: Int) {
        Task {
            let eventId = contentProvider.getEvent(withIndex: index).id
            contentProvider.setLikeEvent(isLiked: false, withIndex: index)
            await likeManager.unlikeEvent(withId: eventId)
            await runOnMainThread {
                view?.updateViewWithLike(isLiked: false, index: index)
            }
        }
    }
    
    func onViewDidLoad() {
        view?.setTitle(contentProvider.title)
        view?.setLoaderVisiability(isLoading: true)
        Task {
            do {
                let initialEvents = try await loader.loadContent(page: 1)
                let eventsInfo = EventsConverter.getEventsInfo(events: initialEvents)
                contentProvider.appendEvents(eventsInfo)
                await runOnMainThread {
                    view?.setLoaderVisiability(isLoading: false)
                    view?.update(withEvents: eventsInfo)
                }
            } catch MoreLoaderError.errorWithLoadingData {
                
            } catch MoreLoaderError.noCoordinates {
                
            } catch {
                
            }
        }
    }
    
    func loadNextPage(page: Int) {
        Task {
            do {
                let initialEvents = try await loader.loadContent(page: page)
                let eventsInfo = EventsConverter.getEventsInfo(events: initialEvents)
                contentProvider.appendEvents(eventsInfo)
                await runOnMainThread {
                    view?.setLoaderVisiability(isLoading: false)
                    view?.update(withEvents: eventsInfo)
                }
            } catch MoreLoaderError.errorWithLoadingData {
                print("error errorWithLoadingData")
            } catch MoreLoaderError.noCoordinates {
                print("Error noCoordinates")
            } catch {
                print("Undefined error")
            }
        }
    }
    
    func tappedOnEvent(index: Int) {
        let event = contentProvider.getEvent(withIndex: index)
        let eventID = event.id
        let placeId = event.placeId
        view?.openEvenScreen(eventId: eventID, placeId: placeId)
    }
}

