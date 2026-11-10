import SwiftUI

struct TotalSummaryView: View {
    let title: String
    let total: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Text("ჯამი: \(formatAmount(total))")
                .font(.title.bold())
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    TotalSummaryView(title: "ყველა ხარჯი", total: 57)
}
