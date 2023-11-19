import SwiftUI

struct MissionView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: MissionViewModel

    init(viewModel: MissionViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(spacing: 8) {
            ForEach(viewModel.missionList, id: \.id) { mission in
                missionProgressCell(mission: mission)
            }

            Spacer()
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(Color.GrayScale.Background.background)
        .setBackButton(title: "과제") {
            dismiss()
        }
        .onAppear(perform: viewModel.onAppear)
    }

    @ViewBuilder
    func missionProgressCell(mission: MissionEntity) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 8) {
                Text(mission.name)
                    .onuiFont(.title(.small), color: .GrayScale.Surface.onSurface)

                Text(mission.goal)
                    .onuiFont(.body(.medium), color: .GrayScale.Surface.onSurfaceVariant)

                if mission.isFinished {
                    Text("완료!")
                        .onuiFont(.label, color: .Primary.primary)
                }
            }

            RoundedRectangle(cornerRadius: 8)
                .fill(mission.isFinished ? Color.Primary.onPrimaryContainer: .Primary.primaryContainer)
                .frame(maxWidth: .infinity, maxHeight: 8)

            Text(mission.message)
                .onuiFont(.body(.medium), color: .GrayScale.Surface.onSurfaceVariant)
                .multilineTextAlignment(.leading)

            Button {
                viewModel.completeMission(id: mission.id)
            } label: {
                Text(mission.isFinished ? "완료됨": "완료하기")
                    .onuiFont(.body(.medium), color: mission.isFinished ? .Primary.primary :.Primary.onPrimaryContainer)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background(mission.isFinished ? .clear: Color.Primary.primaryContainer)
                    .cornerRadius(12)
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.Primary.primary, lineWidth: 1)
                            .opacity(mission.isFinished ? 1: 0)
                    }
            }
            .disabled(mission.isFinished)
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(16)
        .background(Color.GrayScale.Surface.surface)
        .cornerRadius(24)
    }
}
