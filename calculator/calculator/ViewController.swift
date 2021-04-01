import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var holder : UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var firstNumber=0
    var resultNumber=0
    var currentOperations : Operation?
    
    enum Operation{
        case sign,percent,plus,minus,multiply,divide,equalsTo
    }
    
    private var resultLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "0"
        label.textAlignment = .right
        label.font = UIFont(name: "Arial", size: 100)
        return label
    }()
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupNuberPad()
    }
    
    private func setupNuberPad(){
        let buttonSize : CGFloat = holder.frame.size.width / 4
        let zeroButton = UIButton(frame: CGRect(x: 0, y: holder.frame.size.height - buttonSize, width: buttonSize*3, height: buttonSize))
        zeroButton.setTitleColor(.white, for: .normal)
        zeroButton.backgroundColor = .gray
        zeroButton.titleLabel?.font =  UIFont(name: "Arial", size: 30)
        zeroButton.setTitle("0",for: .normal)
        zeroButton.tag = 1
        zeroButton.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
        holder.addSubview(zeroButton)
        
        for x in 0..<3{
            let Button1 = UIButton(frame: CGRect(x: buttonSize*CGFloat(x), y: holder.frame.size.height - (buttonSize*2), width: buttonSize, height: buttonSize))
            Button1.setTitleColor(.white, for: .normal)
            Button1.backgroundColor = .gray
            Button1.titleLabel?.font =  UIFont(name: "Arial", size: 30)
            Button1.setTitle("\(x+1)",for: .normal)
            Button1.tag = x+2
            Button1.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
            holder.addSubview(Button1)
        }
        
        for x in 0..<3{
            let Button4 = UIButton(frame: CGRect(x: buttonSize*CGFloat(x), y: holder.frame.size.height - (buttonSize*3), width: buttonSize, height: buttonSize))
            Button4.setTitleColor(.white, for: .normal)
            Button4.backgroundColor = .gray
            Button4.titleLabel?.font =  UIFont(name: "Arial", size: 30)
            Button4.setTitle("\(x+4)",for: .normal)
            Button4.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
            Button4.tag = x+5
            holder.addSubview(Button4)
        }
        
        for x in 0..<3{
            let Button5 = UIButton(frame: CGRect(x: buttonSize*CGFloat(x), y: holder.frame.size.height - (buttonSize*4), width: buttonSize, height: buttonSize))
            Button5.setTitleColor(.white, for: .normal)
            Button5.backgroundColor = .gray
            Button5.titleLabel?.font =  UIFont(name: "Arial", size: 25)
            Button5.setTitle("\(x+7)",for: .normal)
            Button5.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
            Button5.tag = x+8
            holder.addSubview(Button5)
        }
        
        //All clear button
        let clearButton = UIButton(frame: CGRect(x:0,y: holder.frame.size.height - (buttonSize*5),width: buttonSize,height: buttonSize))
        clearButton.setTitleColor(.black, for: .normal)
        clearButton.backgroundColor = .gray
        clearButton.titleLabel?.font =  UIFont(name: "Arial", size: 30)
        clearButton.setTitle("AC",for: .normal)
        clearButton.addTarget(self, action: #selector(clearResult), for: .touchUpInside)
        holder.addSubview(clearButton)
        
        //+/-
        let plusMinusButton = UIButton(frame: CGRect(x:buttonSize,y: holder.frame.size.height - (buttonSize*5),width: buttonSize,height: buttonSize))
        plusMinusButton.setTitleColor(.black, for: .normal)
        plusMinusButton.backgroundColor = .gray
        plusMinusButton.titleLabel?.font =  UIFont(name: "Arial", size: 30)
        plusMinusButton.setTitle("+/-",for: .normal)
        plusMinusButton.tag = 1
        plusMinusButton.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
        holder.addSubview(plusMinusButton)
        
        //%
        let percenButton = UIButton(frame: CGRect(x:buttonSize*2,y: holder.frame.size.height - (buttonSize*5),width: buttonSize,height: buttonSize))
        percenButton.setTitleColor(.black, for: .normal)
        percenButton.backgroundColor = .gray
        percenButton.titleLabel?.font =  UIFont(name: "Arial", size: 30)
        percenButton.setTitle("%",for: .normal)
        percenButton.tag = 2
        percenButton.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
        
        holder.addSubview(percenButton)
        
        //plus
        let plusButton = UIButton(frame: CGRect(x:buttonSize*3,y: holder.frame.size.height - (buttonSize*5),width: buttonSize,height: buttonSize))
        plusButton.setTitleColor(.white, for: .normal)
        plusButton.backgroundColor = .orange
        plusButton.titleLabel?.font =  UIFont(name: "Arial", size: 30)
        plusButton.setTitle("+",for: .normal)
        plusButton.tag = 3
        plusButton.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
        holder.addSubview(plusButton)
        
        //minus
        let minusButton = UIButton(frame: CGRect(x:buttonSize*3,y: holder.frame.size.height - (buttonSize*4),width: buttonSize,height: buttonSize))
        minusButton.setTitleColor(.white, for: .normal)
        minusButton.backgroundColor = .orange
        minusButton.titleLabel?.font =  UIFont(name: "Arial", size: 30)
        minusButton.setTitle("-",for: .normal)
        minusButton.tag = 4
        minusButton.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
        holder.addSubview(minusButton)
        
        //multiply
        let multiplyButton = UIButton(frame: CGRect(x:buttonSize*3,y: holder.frame.size.height - (buttonSize*3),width: buttonSize,height: buttonSize))
        multiplyButton.setTitleColor(.white, for: .normal)
        multiplyButton.backgroundColor = .orange
        multiplyButton.titleLabel?.font =  UIFont(name: "Arial", size: 30)
        multiplyButton.setTitle("x",for: .normal)
        multiplyButton.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
        multiplyButton.tag = 5
        
        holder.addSubview(multiplyButton)
        
        //divide
        
        let divideButton = UIButton(frame: CGRect(x:buttonSize*3,y: holder.frame.size.height - (buttonSize*2),width: buttonSize,height: buttonSize))
        divideButton.setTitleColor(.white, for: .normal)
        divideButton.backgroundColor = .orange
        divideButton.titleLabel?.font =  UIFont(name: "Arial", size: 30)
        divideButton.setTitle("/",for: .normal)
        divideButton.tag = 6
        divideButton.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
        holder.addSubview(divideButton)
        
        //equalsto
        let equalsToButton = UIButton(frame: CGRect(x:buttonSize*3,y: holder.frame.size.height - buttonSize,width: buttonSize,height: buttonSize))
        equalsToButton.setTitleColor(.white, for: .normal)
        equalsToButton.backgroundColor = .orange
        equalsToButton.titleLabel?.font =  UIFont(name: "Arial", size: 30)
        equalsToButton.setTitle("=",for: .normal)
        equalsToButton.tag = 7
        
        equalsToButton.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
        holder.addSubview(equalsToButton)
        
        
        resultLabel.frame = CGRect(x:-10,y: Int(holder.frame.size.height - (buttonSize*6))-10, width:Int(holder.frame.size.width),height:100)
        
        holder.addSubview(resultLabel)
        
    }
    
    @objc func clearResult(){
        resultLabel.text = "0"
        currentOperations = nil
        firstNumber = 0
        resultNumber = 0
        
    }
    
    @objc func numberPressed(_ sender: UIButton){
        let tag = sender.tag-1
        
        if(resultLabel.text == "0"){
            resultLabel.text = "\(tag)"
        }
        else if let text = resultLabel.text{
            resultLabel.text = "\(text)\(tag)"
        }
        
    }
    
    @objc func operationPressed(_ sender: UIButton){
        let tag = sender.tag
        
        if let text = resultLabel.text ,let value = Int(text),firstNumber == 0{
            firstNumber = value
            resultLabel.text = "0"
        }
        
        if tag == 1{
            currentOperations = .sign
        }
        
        else if tag == 2{
            currentOperations = .percent
        }
        
        else if tag == 3{
            currentOperations = .plus
        }
        
        else if tag == 4{
            currentOperations = .minus
        }
        
        else if tag == 5{
            currentOperations = .multiply
        }
        
        else if tag == 6{
            currentOperations = .divide
        }
        
        else if tag == 7{
            if let operation = currentOperations{
                var secondNumber = 0
                if let text = resultLabel.text ,let value = Int(text){
                    secondNumber = value
                }
                
                switch operation {
                case .sign:
                    let result = firstNumber
                    resultLabel.text = "\(-result)"
                    currentOperations = nil
                    firstNumber = 0
                    break;
                case .percent:
                    let result = firstNumber/100
                    resultLabel.text = "\(result)"
                    currentOperations = nil
                    firstNumber = 0
                    break;
                case .plus:
                    let result = firstNumber + secondNumber
                    resultLabel.text = "\(result)"
                    currentOperations = nil
                    firstNumber = 0
                    break;
                case .minus:
                    let result = firstNumber - secondNumber
                    resultLabel.text = "\(result)"
                    currentOperations = nil
                    firstNumber = 0
                    break;
                case .multiply:
                    let result = firstNumber * secondNumber
                    resultLabel.text = "\(result)"
                    currentOperations = nil
                    firstNumber = 0
                    break;
                case .divide:
                    if secondNumber == 0{
                    resultLabel.text = "error"
                    }
                    else
                    {
                        let result = firstNumber / secondNumber
                        resultLabel.text = "\(result)"
                        currentOperations = nil
                        firstNumber = 0
                    }
                    break;
                default:
                    break;
                }
            }
        }
        
    }
    
}

