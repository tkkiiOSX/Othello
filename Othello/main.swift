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
var turn = BLACK

//関数を定義する場所
func update() {
    var numBlack = 0
    var numWhite = 0

    for ix in 0 ..< 8 {
        print(String(format: "%02d ", ix), terminator: "")
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
        print(String(format: " %02d", iy * 10))
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
    else if (checkPass(color: BLACK) && (turn == BLACK)) {
        print("Oはパス")
        turn = WHITE
    }
    else if (checkPass(color: WHITE) && (turn == WHITE)) {
        print("Xはパス")
        turn = BLACK
    }
    else if (turn == BLACK) {
        print("Oのターン、Oを置いてください")
    }
    else if (turn == WHITE) {
        print("Xのターン、Xを置いてください")
    }
}

func checkOne(y: Int, x: Int, dy: Int, dx: Int, color: Int) -> Int {
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
            count += 1
        }
        tmpy += dy
        tmpx += dx
    }
    return 0
}

func flipOne(y: Int, x: Int, dy: Int, dx: Int, color: Int) -> Int {
    if checkOne(y: y, x: x, dy: dy, dx: dx, color: color) == 0 {
        return 0
    }
    
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
            board[tmpy][tmpx] = color
            count += 1
        }
        tmpy += dy
        tmpx += dx
    }
    return 0
}

func checkAll(y: Int, x: Int, color: Int) -> Int {
    if board[y][x] != 0 {
        return 0
    }
    
    var count = 0
    count += checkOne(y: y, x: x, dy: -1, dx: -1, color: color)
    count += checkOne(y: y, x: x, dy: -1, dx:  0, color: color)
    count += checkOne(y: y, x: x, dy: -1, dx:  1, color: color)
    count += checkOne(y: y, x: x, dy:  0, dx:  1, color: color)
    count += checkOne(y: y, x: x, dy:  1, dx:  1, color: color)
    count += checkOne(y: y, x: x, dy:  1, dx:  0, color: color)
    count += checkOne(y: y, x: x, dy:  1, dx: -1, color: color)
    count += checkOne(y: y, x: x, dy:  0, dx: -1, color: color)
    return count;
}

func flipAll(y: Int, x: Int, color: Int) -> Int {
    if board[y][x] != 0 {
        return 0
    }
    
    var count = 0
    count += flipOne(y: y, x: x, dy: -1, dx: -1, color: color)
    count += flipOne(y: y, x: x, dy: -1, dx:  0, color: color)
    count += flipOne(y: y, x: x, dy: -1, dx:  1, color: color)
    count += flipOne(y: y, x: x, dy:  0, dx:  1, color: color)
    count += flipOne(y: y, x: x, dy:  1, dx:  1, color: color)
    count += flipOne(y: y, x: x, dy:  1, dx:  0, color: color)
    count += flipOne(y: y, x: x, dy:  1, dx: -1, color: color)
    count += flipOne(y: y, x: x, dy:  0, dx: -1, color: color)
    if count > 0 {
        board[y][x] = color
    }
    return count;
}

func checkPass(color: Int) -> Bool {
    for iy in 0 ..< 8 {
        for ix in 0 ..< 8 {
            if (checkAll(y: iy, x: ix, color: color) > 0) {
                return false
            }
        }
    }
    return true
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
    
    if flipAll(y: num! / 10, x: num! % 10, color: turn) > 0 {
        turn = turn == BLACK ? WHITE : BLACK
    }
    else {
        print("***そこには置けません****")
    }
}

