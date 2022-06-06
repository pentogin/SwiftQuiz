
import UIKit
class TopViewController: UIViewController {
    // 選択した種類の問題を一旦入れる箱
    var selectTag = 0
    @IBOutlet private var selectButton1: UIButton!
    @IBOutlet private var selectButton2: UIButton!
    @IBOutlet private var selectButton3: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // swiftlint:disable force_cast
        let quizVC = segue.destination as! QuizViewController
        quizVC.selectKinds = selectTag
    }
    @IBAction func selectButton(sender: UIButton) {
        print(sender.tag)
        selectTag = sender.tag
        performSegue(withIdentifier: "toQuizVC", sender: nil)
    }
}
