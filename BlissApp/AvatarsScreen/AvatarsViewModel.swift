//
//  AvatarsViewModel.swift
//  BlissApp
//
//  Created by Diogo on 8/16/25.
//

class AvatarsViewModel {
    
    private let _avatarRepository: AvatarsRepository = AvatarsDataRepository()
    private var avatars: [Avatars] = []
    
    func fetchAvatars(completionHandler: @escaping ([Avatars]) -> Void) {
        avatars = _avatarRepository.getAll()
        completionHandler(avatars)
    }
    
    func numberOfItems() -> Int {
        return avatars.count
    }
    
    func getAvatars() -> [Avatars] {
        return avatars
    }
    
    func getAvatar(username: String) -> Avatars? {
        return _avatarRepository.getAvatar(username: username)
    }
    
    func deleteAvatars(avatar: Avatars, index: Int) -> Bool {
        guard index < avatars.count else { return false }
        avatars.remove(at: index)
        return _avatarRepository.delete(record: avatar)
    }
}
