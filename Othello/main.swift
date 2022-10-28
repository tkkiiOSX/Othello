import Foundation

//変数を定義する場所
let BLACK = 1
let WHITE = 2
var board = [
    [0, 0, 0, 0,  0, 0, 0, 0],
    [0, 0, 0, 0,  0, 0, 0, 0],
    [0, 0, 0, 0,  0, 0, 0, 0],
    [0, 0, 0, 1,  2, 0, 0, 0],
    
    [0, 0, 0, 2,  1, 0, 0, 0],
    [0, 0, 0, 0,  0, 0, 0, 0],
    [0, 0, 0, 0,  0, 0, 0, 0],
    [0, 0, 0, 0,  0, 0, 0, 0]
]
var turnBlack = true

//関数を定義する場所
func update() {
    var numBlack = 0
    var numWhite = 0

    for ix in 0 ..< 8 {
        print(String(format: "%02d ", ix * 10), terminator: "")
    }
    print()

    for iy in 0 ..< 8 {
        for ix in 0 ..< 8 {
            switch board[iy][ix] {
            case BLACK:
                numBlack += 1
                print(" O ", terminator: "")
            case WHITE:
                numWhite += 1
                print(" X ", terminator: "")
            default:
                print(" . ", terminator: "")
            }
        }
        print(String(format: " %02d", iy))
    }
    print("O:\(numBlack)枚 X:\(numWhite)枚")
    
    if ((numBlack + numWhite == 64) || (checkPass(color: BLACK) && checkPass(color: WHITE))) {
        print("ゲーム終了しました")
        if (numBlack > numWhite) {
            print("Oの勝ちです")
        }
        else if (numBlack < numWhite) {
            print("Xの勝ちです")
        }
        else {
            print("ひきわけです")
        }
    }
    else if (checkPass(color: BLACK) && turnBlack) {
        print("Oはパス")
        turnBlack = false
    }
    else if (checkPass(color: WHITE) && !turnBlack) {
        print("Xはパス")
        turnBlack = true
    }
    else if (turnBlack) {
        print("Oのターン、Oを置いてください")
    }
    else if (!turnBlack) {
        print("Xのターン、Xを置いてください")
    }
}

func chekOne(y: Int, x: Int, dy: Int, dx: Int, color: Int) -> Int {
    var tmpy = y + dy
    var tmpx = x + dx
    var count = 0
    
    while (tmpy >= 0 && tmpy < 8 && tmpx >= 0 && tmpx < 8) {
        if (board[tmpy][tmpx] == 0) {
            break
        }
        if (board[tmpy][tmpx] == color) {
            return count
        }
        else {
            
        }
        tmpy += dy
        tmpx += dx
    }
    return 0;
}

func checkAll(y: Int, x: Int, color: Int) -> Int {
    return 0;
}

func checkPass(color: Int) -> Bool {
    for iy in 0 ..< 8 {
        for ix in 0 ..< 8 {
            if (checkAll(y: iy, x: ix, color: color) > 0) {
                return true
            }
        }
    }
    return false
}

//プログラム実行開始の場所
while true {
    update()
      
    var num: Int? = nil
    while (num == nil) {
        print("99を入力すると最初からやり直しできます")
        print("番号入力? ", terminator: "")
        num = Int(readLine()!)
    }
}
