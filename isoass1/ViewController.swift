//
//  ViewController.swift
//  isoass1
//
//  Created by Jason on 2020-01-16.
//  Copyright © 2020 centennialcollege. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var backlightgif: UIImageView!
    
    @IBOutlet weak var slotMachine: UIPickerView!
    @IBOutlet weak var row1gif: UIImageView!
    @IBOutlet weak var row2gif: UIImageView!
    @IBOutlet weak var row3gif: UIImageView!
    @IBOutlet weak var infoimg: UIImageView!
    
    struct slotComp {
        var image: UIImage!
        var item: String
    }
    @IBOutlet weak var slotBtn: UIButton!
    
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
    var playerBet: Int = 200
    var playermoney: Int = 3000
    var jackpot: Int = 10000
    
    var btnstate: Int = 0
    
    @IBOutlet weak var jackpotl: UILabel!
    @IBOutlet weak var playermoneyl: UILabel!
    @IBOutlet weak var playerbetl: UILabel!
    @IBOutlet weak var playerwinning: UILabel!
    
    @IBOutlet weak var cannotplay: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        infoimg.loadGif(name: "goodluck")
        backlightgif.loadGif(name: "backlightslow")
        row1gif.loadGif(name: "rolling")
        row2gif.loadGif(name: "rolling")
        row3gif.loadGif(name: "rolling")
        
        row1gif.isHidden = true
        row2gif.isHidden = true
        row3gif.isHidden = true
        cannotplay.isHidden = true
        
        jackpotl.text = String(jackpot)
        playermoneyl.text = String(playermoney)
        playerbetl.text = String(playerBet)
        playerwinning.text = String(winnings)
        // Do any additional setup after loading the view.
        
        let imggrapes = slotComp(image: UIImage(named: "grapes"), item: "grapes")
        let imgbananas = slotComp(image: UIImage(named: "bananas"), item: "bananas")
        let imgoranges = slotComp(image: UIImage(named: "oranges"), item: "oranges")
        let imgcherries = slotComp(image: UIImage(named: "cherries"), item: "cherries")
        let imgbars = slotComp(image: UIImage(named: "bars"), item: "bars")
        let imgbells = slotComp(image: UIImage(named: "bells"), item: "bells")
        let imgseven = slotComp(image: UIImage(named: "seven"), item: "seven")
        let imgbomb = slotComp(image: UIImage(named: "bomb"), item: "bomb")
        
        images = [imgbells, imgseven, imggrapes, imgbananas, imgoranges, imgcherries, imgbars, imgbells, imgseven, imgbomb, imggrapes, imgbananas, imgoranges, imgcherries, imgbars, imgbells, imgseven, imgbomb, imggrapes, imgbananas, imgoranges, imgcherries, imgbars, imgbells, imgseven, imgbomb]
        

        
        slotMachine.dataSource = self
        slotMachine.delegate = self
        
        slotMachine.selectRow(Int(1), inComponent: 0, animated: false)
        slotMachine.selectRow(Int(1), inComponent: 1, animated: false)
        slotMachine.selectRow(Int(1), inComponent: 2, animated: false)

        
        srandom(UInt32(time(nil)))
        
    }
    @IBAction func addten(_ sender: Any) {
        if (playerBet < 500) {
            playerBet = playerBet + 10
            playerbetl.text = String(playerBet)
        }
        if (playerBet > playermoney) {
            cannotplay.isHidden = false
        } else {
            cannotplay.isHidden = true
        }
    }
    @IBAction func subten(_ sender: Any) {
        if (playerBet > 10) {
            playerBet = playerBet - 10
            playerbetl.text = String(playerBet)
        }
        if (playerBet > playermoney) {
            cannotplay.isHidden = false
        } else {
            cannotplay.isHidden = true
        }
        
    }
    @IBAction func resetbtn(_ sender: Any) {
        slotMachine.selectRow(Int(1), inComponent: 0, animated: true)
        slotMachine.selectRow(Int(1), inComponent: 1, animated: true)
        slotMachine.selectRow(Int(1), inComponent: 2, animated: true)
        infoimg.loadGif(name: "goodluck")
        cannotplay.isHidden = true
        playerBet = 200
        playermoney = 3000
        winnings = 0
        playerbetl.text = String(playerBet)
        playermoneyl.text = String(playermoney)
        playerwinning.text = String(winnings)
    }
    
    @IBAction func button(_ sender: Any) {
        

        //timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: Selector("randomSpin"), userInfo: nil, repeats: true)
        if (playerBet > playermoney) {
            return
        }
        if (playermoney <= 0) {
            return
        }
        if (btnstate == 1){
            return
        }
        btnstate = 1
        infoimg.loadGif(name: "goodluck")
        backlightgif.loadGif(name: "backlightfast")
        
        slotBtn.setImage( UIImage.init(named: "1"), for: .normal)
        row1gif.isHidden = false
        row2gif.isHidden = false
        row3gif.isHidden = false
        
        slotMachine.selectRow(Int(1), inComponent: 0, animated: false)
        slotMachine.selectRow(Int(1), inComponent: 1, animated: false)
        slotMachine.selectRow(Int(1), inComponent: 2, animated: false)
        
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
        self.playermoneyl.text = String(self.playermoney)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.randomSpin()
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.48) {
            self.row1gif.isHidden = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.98) {
            self.randomSpin()
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.row2gif.isHidden = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.48) {
            self.randomSpin()
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
            self.row3gif.isHidden = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.countitem()
            self.determineWinnings()
            self.playermoney = self.playermoney + self.winnings
            self.jackpot = self.jackpot + self.playerBet
            
            if self.winnings == 0 {
                self.infoimg.loadGif(name: "youlose")
                self.jackpotl.text = String(self.jackpot)
            } else {
                self.infoimg.loadGif(name: "youwin")
                self.jackpot = self.jackpot - self.winnings
                self.jackpotl.text = String(self.jackpot)
            }
            
            self.playermoneyl.text = String(self.playermoney)
            self.playerbetl.text = String(self.playerBet)
            self.playerwinning.text = String(self.winnings)
            
            self.backlightgif.loadGif(name: "backlightslow")
            self.slotBtn.setImage( UIImage.init(named: "0"), for: .normal)
            self.btnstate = 0
            if (self.playerBet > self.playermoney) {
                self.cannotplay.isHidden = false
            } else {
                self.cannotplay.isHidden = true
            }
            if self.playermoney == 0 {
                self.infoimg.loadGif(name: "gameover")
            }
        }

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
            randRow = 7 + 2
        //15.4% grapes
        case 28..<38:
            randRow = 0 + 2
        //13.8% bananas
        case 38..<47:
            randRow = 1 + 2
        //12.3% oranges
        case 47..<55:
            randRow = 2 + 2
        //7.7% cherries
        case 55..<60:
            randRow = 3 + 2
        //4.6% bars
        case 60..<63:
            randRow = 4 + 2
        //3.1% bells
        case 63..<65:
            randRow = 5 + 2
        //1.5% seven
        case 65:
            randRow = 6 + 2
        default:
            //randRow = 9 + 2
            return
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

