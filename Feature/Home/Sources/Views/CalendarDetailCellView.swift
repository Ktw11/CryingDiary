//
//  CalendarDetailCellView.swift
//  Home
//
//  Created by 공태웅 on 12/28/24.
//

import SwiftUI
import SharedResource

struct CalendarDetailCellView: View {
    
    init(viewModel: CalendarDetailCellViewModel) {
        self.viewModel = viewModel
    }
    
    private let viewModel: CalendarDetailCellViewModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 18) {
            #warning("Image 반영 필요")
            Group {
                if let image = viewModel.image {
                    image
                } else {
                    Rectangle()
                        .foregroundStyle(SharedResourceAsset.Color.secondaryColor.swiftUIColor.opacity(0.2))
                        .overlay {
                            Text("new")
                                .font(.system(size: 12))
                                .foregroundStyle(SharedResourceAsset.Color.primaryColor.swiftUIColor)
                        }
                }
            }
            .cornerRadius(12)
            .frame(width: 75, height: 75)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(viewModel.dateText)
                    .font(.system(size: 12))
                    .foregroundStyle(SharedResourceAsset.Color.primaryColor.swiftUIColor)
                
                Text(viewModel.title)
                    .font(.system(size: 15))
                
                Text("Modify")
                    .font(.system(size: 10))
                    .foregroundStyle(.gray)
            }
        }
    }
}

#Preview {
    CalendarDetailCellView(
        viewModel: CalendarDetailCellViewModel(
            diary: .init(id: "", title: "title", content: "content", timestamp: 123)
        )
    )
}
