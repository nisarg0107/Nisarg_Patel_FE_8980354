//
//  DetailNews.swift
//  Nisarg_Patel_FE_8980354
//
//  Created by user238292 on 4/13/24.
//

import UIKit

class DetailNews: UITableViewCell {
    
    @IBOutlet weak var lblAthr: UILabel!
    @IBOutlet weak var lblsrc: UILabel!
    @IBOutlet weak var lbltitl: UILabel!
    @IBOutlet weak var lblcntnt: UILabel!
    
    func setupUI(article: Article) {
        lblAthr.text = "Author: \(article.author ?? "Unknown")"
        lblsrc.text = "Source: \(article.source?.name ?? "")"
        lbltitl.text = "Title: \(article.title ?? "")"
        lblcntnt.text = "Content: \(article.description ?? "")"
    }
}
