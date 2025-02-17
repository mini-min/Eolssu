import SwiftUI

struct CreatingView: View {
    @StateObject private var viewModel: CreatingViewModel
    private let rhythms = RhythmType.allCases
    
    init() {
        _viewModel = StateObject(wrappedValue: CreatingViewModel())
    }
    
    var body: some View {
        HStack {
            RhythmListView(rhythms: rhythms)
            
            VStack(spacing: 20) {
                JungGanBoView(
                    rhythmList: $viewModel.droppedRhythms,
                    jangdanBeat: .constant(4),
                    jangdanSobak: .constant(3),
                    isPlaying: $viewModel.isPlaying,
                    currentBeatIndex: $viewModel.currentBeatIndex
                )
                .frame(height: 80)
                .padding()
                
                VStack(alignment: .center) {
                    VStack(spacing: 0) {
                        ForEach(0..<2, id: \.self) { outIndex in
                            HStack() {
                                ForEach(0..<2, id: \.self) { innerIndex in
                                    let beatIndex = outIndex * 2 + innerIndex
                                    
                                    BeatView(
                                        beatIndex: beatIndex, 
                                        droppedRhythms: $viewModel.droppedRhythms
                                    )
                                    .padding(30)
                                }
                            }
                        }
                    }
                    
                    CreatingControlView(
                        bpm: $viewModel.bpm,
                        droppedRhythms: $viewModel.droppedRhythms
                    )
                    .padding(20)
                }
                .background(Color.eolssuBackground)
                .cornerRadius(20)
                .padding()
            }
        }
        .padding(.horizontal, 20)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: viewModel.repeatButtonTapped) {
                    Image(systemName: viewModel.isRepeating ? "repeat" : "repeat.1")
                        .font(.myFont(size: 20))
                        .foregroundColor(.white)
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: viewModel.jangdanPlayButtonTapped) {
                    Image(systemName: viewModel.isPlaying ? "stop.fill" : "play.fill")
                        .font(.myFont(size: 20))
                        .foregroundColor(.white)
                        .padding()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .padding(.top, 15)
    }
}

#Preview {
    CreatingView()
}
