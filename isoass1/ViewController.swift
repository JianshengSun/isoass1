//
//  ViewController.swift
//  isoass1
//
//  Created by Jason on 2020-01-16.
//  Copyright © 2020 centennialcollege. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var slotMachine: UIPickerView!
    
    struct slotComp {
        var image: UIImage!
        var item: String
    }
    
    var counter = 0
    var images = [slotComp]()
    var randRow: Int = 0
    var row1 = ""
    var row2 = ""
    var row3 = ""
    var timer = Timer()
    
    var nbbomb: Int = 0
    var nbgrapes: Int = 0
    var nbbananas: Int = 0
    var nboranges: Int = 0
    var nbcherries: Int = 0
    var nbbars: Int = 0
    var nbbells: Int = 0
    var nbseven: Int = 0
    
    var winnings: Int = 0
    var playerBet: Int = 500
    var playermoney: Int = 5000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let imggrapes = slotComp(image: UIImage(named: "grapes"), item: "grapes")
        let imgbananas = slotComp(image: UIImage(named: "bananas"), item: "bananas")
        let imgoranges = slotComp(image: UIImage(named: "oranges"), item: "oranges")
        let imgcherries = slotComp(image: UIImage(named: "cherries"), item: "cherries")
        let imgbars = slotComp(image: UIImage(named: "bars"), item: "bars")
        let imgbells = slotComp(image: UIImage(named: "bells"), item: "bells")
        let imgseven = slotComp(image: UIImage(named: "seven"), item: "seven")
        let imgbomb = slotComp(image: UIImage(named: "bomb"), item: "bomb")
        
        images = [imggrapes, imgbananas, imgoranges, imgcherries, imgbars, imgbells, imgseven, imgbomb, imggrapes, imgbananas, imgoranges, imgcherries, imgbars, imgbells, imgseven, imgbomb, imggrapes, imgbananas, imgoranges, imgcherries, imgbars, imgbells, imgseven, imgbomb]
        
        slotMachine.dataSource = self
        slotMachine.delegate = self
        
        srandom(UInt32(time(nil)))
        
    }

    @IBAction func button(_ sender: Any) {
        //timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: Selector("randomSpin"), userInfo: nil, repeats: true)
        row1 = ""
        row2 = ""
        row3 = ""
        counter = 0
        nbbomb = 0
        nbgrapes = 0
        nbbananas = 0
        nboranges = 0
        nbcherries = 0
        nbbars = 0
        nbbells = 0
        nbseven = 0
        winnings = 0
        playermoney = playermoney - playerBet
        
        randomSpin()
        randomSpin()
        randomSpin()
        countitem()
        determineWinnings()
        playermoney = playermoney + winnings
        print(playerBet)
        print(winnings)
        print(playermoney)
    }
    
    func countitem(){
        //count item
        switch row1 {
        case "grapes":
            nbgrapes = nbgrapes + 1
            break
        case "bananas":
            nbbananas = nbbananas + 1
            break
        case "oranges":
            nboranges = nboranges + 1
            break
        case "cherries":
            nbcherries = nbcherries + 1
            break
        case "bars":
            nbbars = nbbars + 1
            break
        case "bells":
            nbbells = nbbells + 1
            break
        case "seven":
            nbseven = nbseven + 1
            break
        case "bomb":
            nbbomb = nbbomb + 1
            break
        default:
            break
        }
        switch row2 {
        case "grapes":
            nbgrapes = nbgrapes + 1
            break
        case "bananas":
            nbbananas = nbbananas + 1
            break
        case "oranges":
            nboranges = nboranges + 1
            break
        case "cherries":
            nbcherries = nbcherries + 1
            break
        case "bars":
            nbbars = nbbars + 1
            break
        case "bells":
            nbbells = nbbells + 1
            break
        case "seven":
            nbseven = nbseven + 1
            break
        case "bomb":
            nbbomb = nbbomb + 1
            break
        default:
            break
        }
        switch row3 {
        case "grapes":
            nbgrapes = nbgrapes + 1
            break
        case "bananas":
            nbbananas = nbbananas + 1
            break
        case "oranges":
            nboranges = nboranges + 1
            break
        case "cherries":
            nbcherries = nbcherries + 1
            break
        case "bars":
            nbbars = nbbars + 1
            break
        case "bells":
            nbbells = nbbells + 1
            break
        case "seven":
            nbseven = nbseven + 1
            break
        case "bomb":
            nbbomb = nbbomb + 1
            break
        default:
            break
        }
    }
    
    func determineWinnings(){
        if (nbbomb == 0)
        {
            if (nbgrapes == 3) {
                winnings = playerBet * 10;
            }
            else if(nbbananas == 3) {
                winnings = playerBet * 20;
            }
            else if (nboranges == 3) {
                winnings = playerBet * 30;
            }
            else if (nbcherries == 3) {
                winnings = playerBet * 40;
            }
            else if (nbbars == 3) {
                winnings = playerBet * 50;
            }
            else if (nbbells == 3) {
                winnings = playerBet * 75;
            }
            else if (nbseven == 3) {
                winnings = playerBet * 100;
            }
            else if (nbgrapes == 2) {
                winnings = playerBet * 2;
            }
            else if (nbbananas == 2) {
                winnings = playerBet * 2;
            }
            else if (nboranges == 2) {
                winnings = playerBet * 3;
            }
            else if (nbcherries == 2) {
                winnings = playerBet * 4;
            }
            else if (nbbars == 2) {
                winnings = playerBet * 5;
            }
            else if (nbbars == 2) {
                winnings = playerBet * 10;
            }
            else if (nbseven == 2) {
                winnings = playerBet * 20;
            }
            else if (nbseven == 1) {
                winnings = playerBet * 5;
            }
            else {
                winnings = playerBet * 1;
            }
            //winNumber++;
            //showWinMessage();
        }
        else
        {
            //lossNumber++;
            //showLossMessage();
        }
    }
    
    func randomSpin(){
        //let randRow = arc4random()
        let rownumber = Int.random(in: 0..<65) + 1
        
        switch rownumber {
        //41.5% bomb
        case 1..<28:
            randRow = 7
        //15.4% grapes
        case 28..<38:
            randRow = 0
        //13.8% bananas
        case 38..<47:
            randRow = 1
        //12.3% oranges
        case 47..<55:
            randRow = 2
        //7.7% cherries
        case 55..<60:
            randRow = 3
        //4.6% bars
        case 60..<63:
            randRow = 4
        //3.1% bells
        case 63..<65:
            randRow = 5
        //1.5% seven
        case 65:
            randRow = 6
        default:
            randRow = 9
        }
        
        slotMachine.selectRow(Int(randRow), inComponent: counter, animated: true)
        self.pickerView(slotMachine, didSelectRow: Int(randRow), inComponent: counter)
        counter = counter + 1
        if counter == 3 {
            //timer.invalidate()
            counter = 0
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow: Int, inComponent: Int){
//    here win%
        switch inComponent {
        case 0:
            row1 = images[didSelectRow].item
            break
        case 1:
            row2 = images[didSelectRow].item
            break
        case 2:
            row3 = images[didSelectRow].item
            break
        default:
            break
        }
        
        

    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return images.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        return UIImageView(image: images[row].image)
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return images[0].image.size.height
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return images[0].image.size.width
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    
    
    
    
}

