//
//  GameClockView.swift
//  RugStats
//
//  Created by 井坂航 on 2024/10/04.
//

import SwiftUI

struct GameClockView: View {
    @Binding var gameClock: TimeInterval
    @Binding var timer: Timer?
    @Binding var isRunning: Bool
    
    // ゲームタイムをフォーマットする関数
    private func formatTimeInterval(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    var body: some View {
        // ストップウォッチの表示(仮)
        VStack{
            Text(formatTimeInterval(gameClock)).font(.title)
            
            // スタート/ストップボタン
            HStack {
                Button(action: {
                    if (isRunning){
                        stopTimer()
                    }else{
                        startTimer()
                    }
                }){
                    Image(systemName: isRunning ? "pause.fill" : "play.fill")
                }.font(.title)
            }
            .padding()
        }.onAppear {
            // 初期設定でタイマーを作動しないように
            resetTimer()
        }
    }
    
    // ストップウォッチ用のタイマー処理
    func startTimer() {
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            gameClock += 1.0 // 毎秒加算
        }
    }
    
    func stopTimer() {
        isRunning = false
        timer?.invalidate()
        timer = nil
    }
    
    func resetTimer() {
        gameClock = 0.0
        stopTimer()
    }
}

#Preview {
    GameClockView(gameClock: .constant(TimeInterval(10)), timer: .constant(Timer()), isRunning: .constant(true))
}
