import Foundation

final class ExploreViewModel {
    
    private let networkManager = ApiManager()
    var topics: [Topic] = []
    var allphotosBySlug: [TopicPhoto] = []
    var onRandomPhotoUpdated:(() -> Void)?
    var onTopicUpdated:(([TopicForCollectionView])-> Void)?
    
    //MARK: Have to comment func loadTopics() due to 50 request per 1 hour
//    func loadTopics() {
//        networkManager.getResponseTopic { [weak self] topic, error in
//            guard let topic = topic else { return }
//            DispatchQueue.main.async {
//                self?.topics = topic
//                self?.fetchPhotos(topics: topic)
//            }
//        }
//    }
//    
//    func fetchPhotos(topics: [Topic]) {
//        var newTopics: [TopicForCollectionView] = []
//        for topic in topics {
//            
//            networkManager.getResponsePhotoBySlug(slug: topic.slug) { photos, error in
//                guard let firstPhoto = photos?.first,
//                      let smallPhoto = firstPhoto.urls?.small else {
//                    return
//                }
//                let newTopic = TopicForCollectionView(title: topic.title, imageUrl: smallPhoto)
//                newTopics.append(newTopic)
//                
//                DispatchQueue.main.async {
//                    self.onTopicUpdated?(newTopics)
//                }
//            }
//        }
//    }
    
}
