//
//  EventsCellBuilder.swift
//  Coordinator
//
//  Created by Tradesocio on 19/05/22.
//

import Foundation

struct EventCellBuilder {
    
    func makeTitleSubtitleCellViewModel(_ type:TitleSubtitleCellViewModel.CellType,onupdate: (() -> Void)? = nil
    ) -> TitleSubtitleCellViewModel {
        switch type {
        case .text:
            return TitleSubtitleCellViewModel(
                title: "Name",
                subtitle: "",
                placeHolder: "Add name",
                type: .text,
                onUpdate:onupdate
            )
        case .date:
            return TitleSubtitleCellViewModel(
                title: "Date",
                subtitle: "",
                placeHolder: "Select a Date",
                type: .date,
                onUpdate:onupdate
            )
        case .image:
            return TitleSubtitleCellViewModel(
                title: "Background",
                subtitle: "",
                placeHolder: "",
                type: .image,
                onUpdate: onupdate
            )
        }
    }
}
