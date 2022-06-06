
import UIKit

class QuizViewController: UIViewController {

    @IBOutlet private var quizNumberLabel: UILabel!
    @IBOutlet private var  quizTextView: UITextView!
    @IBOutlet private var  answerButton: UIButton!
    @IBOutlet private var  answerButton2: UIButton!
    @IBOutlet private var  judgeImageView: UIImageView!

    // 問題文を入れる箱
    var csvArray: [String] = []
    var quizArray: [String] = []
    // 問題数を入れる箱
    var quizCount = 0
    // 正解した数を入れる箱
    var correctCount = 0
    // どの種類の問題を選択したかを受け取る箱
    var selectKinds = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        print("選択したのは種類\(selectKinds)")

        csvArray = loadCSV(fileName: "quiz\(selectKinds)")
        csvArray.shuffle()
        print(csvArray)

        quizArray = csvArray[quizCount].components(separatedBy: ",")
        quizNumberLabel.text = "第\(quizCount + 1)問"
        quizTextView.text = quizArray[0]
        answerButton.setTitle(quizArray[2], for: .normal)
        answerButton2.setTitle(quizArray[3], for: .normal)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // swiftlint:disable force_cast
        let scoreVC = segue.destination as! ScoreViewController
        scoreVC.correct = correctCount
    }

    // ボタンを押した時
    @IBAction   func buttonAction(sender: UIButton) {
        if sender.tag == Int(quizArray[1]) {
            correctCount += 1
            print("正解")
            judgeImageView.image = UIImage(named: "correct")
        } else {
            print("不正解")
            judgeImageView.image = UIImage(named: "incorrect")
        }
        print("スコア：\(correctCount)")
        judgeImageView.isHidden = false
        answerButton.isHidden = false
        answerButton2.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.judgeImageView.isHidden = true
            self.answerButton.isEnabled = true
            self.answerButton2.isEnabled = true
            self.nextQuiz()
        }
    }
    // 次の問題へ
    func nextQuiz() {
        quizCount += 1
        if quizCount < csvArray.count {
            quizArray = csvArray[quizCount].components(separatedBy: ",")
            quizNumberLabel.text = "第\(quizCount + 1)問"
            quizTextView.text = quizArray[0]
            answerButton.setTitle(quizArray[2], for: .normal)
            answerButton2.setTitle(quizArray[3], for: .normal)
        } else {
            performSegue(withIdentifier: "toScoreVC", sender: nil)
        }
    }

    func loadCSV(fileName: String) -> [String] {
        let csvBundle = Bundle.main.path(forResource: fileName, ofType: "csv")!
        do{
            let csvData = try String(contentsOfFile: csvBundle,encoding: String.Encoding.utf8)
            let lineChange = csvData.replacingOccurrences(of: "\r", with: "\n")
            csvArray = lineChange.components(separatedBy: "\n")
            csvArray.removeLast()
        } catch {
            print("エラー")
        }
        return csvArray
    }
}
