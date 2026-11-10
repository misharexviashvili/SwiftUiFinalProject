import SwiftUI

struct CategoryFilterBar: View {
    @Binding var selectedCategory: ExpenseCategory?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                CategoryFilterChip(title: "ყველა", isSelected: selectedCategory == nil) {
                    selectedCategory = nil
                }
                ForEach(ExpenseCategory.allCases) { category in
                    CategoryFilterChip(title: category.rawValue, isSelected: selectedCategory == category) {
                        selectedCategory = category
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    @Previewable @State var selectedCategory: ExpenseCategory?
    CategoryFilterBar(selectedCategory: $selectedCategory)
}
