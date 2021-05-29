class ViewController:UIViewController{
      @IBOutlet weak var questionTextView: RichEditorView!

    lazy var toolbar: RichEditorToolbar = {
        let toolbar = RichEditorToolbar(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 44))
        toolbar.options = RichEditorDefaultOption.all
        return toolbar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupRichTxtViewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}

extension ViewController: RichEditorToolbarDelegate, RichEditorDelegate{
    fileprivate func setupRichTxtViewDidLoad(){
        questionTextView.delegate = self
        questionTextView.inputAccessoryView = toolbar
        questionTextView.placeholder = ""

        toolbar.delegate = self
        toolbar.editor = questionTextView

        // We will create a custom action that clears all the input text when it is pressed
        let item = RichEditorOptionItem(image: nil, title: "Clear") { toolbar in
            toolbar.editor?.html = ""
        }

        var options = toolbar.options
        options.append(item)
        toolbar.options = options

    }
    fileprivate func randomColor() -> UIColor {
        let colors: [UIColor] = [
            .red,
            .orange,
            .yellow,
            .green,
            .blue,
            .purple
        ]
        
        let color = colors[Int(arc4random_uniform(UInt32(colors.count)))]
        return color
    }

    func richEditorToolbarChangeTextColor(_ toolbar: RichEditorToolbar) {
        let color = randomColor()
        toolbar.editor?.setTextColor(color)
    }

    func richEditorToolbarChangeBackgroundColor(_ toolbar: RichEditorToolbar) {
        let color = randomColor()
        toolbar.editor?.setTextBackgroundColor(color)
    }

    func richEditorToolbarInsertImage(_ toolbar: RichEditorToolbar) {
        let pb: UIPasteboard = UIPasteboard.general;

        toolbar.editor?.insertImage(pb.string ?? "", alt: "Avatar")
    }

    func richEditorToolbarInsertLink(_ toolbar: RichEditorToolbar) {
        // Can only add links to selected text, so make sure there is a range selection first
        let pb: UIPasteboard = UIPasteboard.general;

        if toolbar.editor?.hasRangeSelection == true {
            toolbar.editor?.insertLink(pb.string ?? "", title: "Link")
        }
    }
}
