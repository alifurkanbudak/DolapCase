//
//  ProductSocials.swift
//  DolapCase
//
//  Created by Ali Furkan Budak on 7.04.2020.
//  Copyright © 2020 Ali Furkan Budak. All rights reserved.
//

import Foundation

// MARK: - ProductSocials
class ProductSocials: Codable {
    let likeCount: Int
    let commentCounts: CommentCounts

    init(likeCount: Int, commentCounts: CommentCounts) {
        self.likeCount = likeCount
        self.commentCounts = commentCounts
    }
}

// MARK: - CommentCounts
class CommentCounts: Codable {
    let averageRating: Double
    let anonymousCommentsCount, memberCommentsCount: Int

    init(averageRating: Double, anonymousCommentsCount: Int, memberCommentsCount: Int) {
        self.averageRating = averageRating
        self.anonymousCommentsCount = anonymousCommentsCount
        self.memberCommentsCount = memberCommentsCount
    }
}
