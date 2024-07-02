//
//  MovieRow.swift
//  Presentation
//
//  Created by Mahmoud Abdelshafi on 01/07/2024.
//

import SwiftUI
import Domain

struct MovieRow: View {
    var movie: Movie
    
    var body: some View {
        NavigationLink(destination: MovieDetailsView.instantiate(id: movie.id ?? 0)) {
            HStack(spacing: 12) {
                // Poster Image
                AsyncCachedImage(url: movie.posterURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 120)
                        .cornerRadius(8)
                } placeholder: {
                    ProgressView()
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    // Movie Title
                    Text(movie.title ?? "Unknown Title")
                        .font(.headline)
                        .lineLimit(2)
                        .minimumScaleFactor(0.8)
                    
                    // Release Date
                    Text("Release Date: \(movie.releaseDate?.formattedDate ?? "")")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .padding(.vertical, 8)
        }
    }
}
