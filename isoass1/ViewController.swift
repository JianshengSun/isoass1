//
//  ViewController.swift
//  isoass1
//
//  Created by Jason on 2020-01-16. Student ID: 300997240
//  Copyright © 2020 centennialcollege. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,AVAudioPlayerDelegate {
    var player:AVAudioPlayer = AVAudioPlayer()
   
    //imageview
    @IBOutlet weak var backlightgif: UIImageView!
    @IBOutlet weak var slotMachine: UIPickerView!
    @IBOutlet weak var row1gif: UIImageView!
    @IBOutlet weak var row2gif: UIImageView!
    @IBOutlet weak var row3gif: UIImageView!
    @IBOutlet weak var infoimg: UIImageView!
    
    //slotimage
    struct slotComp {
        var image: UIImage!
        var item: String
    }
    
    //slot button
    @IBOutlet weak var slotBtn: UIButton!
    
    var counter = 0
    var images = [slotComp]()
    var randRow: Int = 0
    var row1 = ""
    var row2 = ""
    var row3 = ""
    var timer = Timer()
    
    // item counter
    var nbbomb: Int = 0
    var nbgrapes: Int = 0
    var nbbananas: Int = 0
    var nboranges: Int = 0
    var nbcherries: Int = 0
    var nbbars: Int = 0
    var nbbells: Int = 0
    var nbseven: Int = 0
    
    //information numbers
    var winnings: Int = 0
    var playerBet: Int = 200
    var playermoney: Int = 3000
    var jackpot: Int = 10000
    
    //state checker
    var btnstate: Int = 0
    var quitstate: Int = 0
    
    //information numbers label
    @IBOutlet weak var jackpotl: UILabel!
    @IBOutlet weak var playermoneyl: UILabel!
    @IBOutlet weak var playerbetl: UILabel!
    @IBOutlet weak var playerwinning: UILabel!
    
    //if have not enough money show image on the slot button, means cannot play
    @IBOutlet weak var cannotplay: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load gif image
        infoimg.loadGif(name: "goodluck")
        backlightgif.loadGif(name: "backlightslow")
        row1gif.loadGif(name: "rolling")
        row2gif.loadGif(name: "rolling")
        row3gif.loadGif(name: "rolling")
        
        //hide row gif and cannotplay image
        row1gif.isHidden = true
        row2gif.isHidden = true
        row3gif.isHidden = true
        cannotplay.isHidden = true
        
        //show numbers
        jackpotl.text = String(jackpot)
        playermoneyl.text = String(playermoney)
        playerbetl.text = String(playerBet)
        playerwinning.text = String(winnings)
        // Do any additional setup after loading the view.
        
        
        
        do{
            let audioplayer = Bundle.main.path(forResource: "slotmachine", ofType: "mpeg")
            try player = AVAudioPlayer(contentsOf:NSURL(fileURLWithPath: audioplayer!) as URL)
            }
                 
            
            catch
            {
               // Error
            }
            
     
        //set image and name
        let imggrapes = slotComp(image: UIImage(named: "grapes"), item: "grapes")
        let imgbananas = slotComp(image: UIImage(named: "bananas"), item: "bananas")
        let imgoranges = slotComp(image: UIImage(named: "oranges"), item: "oranges")
        let imgcherries = slotComp(image: UIImage(named: "cherries"), item: "cherries")
        let imgbars = slotComp(image: UIImage(named: "bars"), item: "bars")
        let imgbells = slotComp(image: UIImage(named: "bells"), item: "bells")
        let imgseven = slotComp(image: UIImage(named: "seven"), item: "seven")
        let imgbomb = slotComp(image: UIImage(named: "bomb"), item: "bomb")
        
        //set picker source
        images = [imgbells, imgseven, imggrapes, imgbananas, imgoranges, imgcherries, imggrapes, imgbananas, imgoranges, imgcherries, imgbars, imgbells, imgseven, imgbomb, imggrapes, imgbananas, imgoranges, imgcherries, imgbars, imgbells, imgseven, imgbomb, imggrapes, imgbananas, imgoranges, imgcherries, imgbars, imgbells, imgseven, imgbomb]
        slotMachine.dataSource = self
        slotMachine.delegate = self
        
        //picker initialization
        slotMachine.selectRow(Int(1), inComponent: 0, animated: false)
        slotMachine.selectRow(Int(1), inComponent: 1, animated: false)
        slotMachine.selectRow(Int(1), inComponent: 2, animated: false)

        //for time delay
        srandom(UInt32(time(nil)))
    }
    
    //button: add 10 bet
    @IBAction func addten(_ sender: Any) {
        //check if slot button not finish, return
        if (btnstate == 1) {
            return
        }
        //check if already quit, return
        if (quitstate == 1) {
            return
        }
        //max bet is 500
        if (playerBet < 500) {
            playerBet = playerBet + 10
            playerbetl.text = String(playerBet)
        }
        //bet cannot over playermoney
        if (playerBet > playermoney) {
            cannotplay.isHidden = false
        } else {
            cannotplay.isHidden = true
        }
    }
    
    //button: -10 bet
    @IBAction func subten(_ sender: Any) {
        //check if slot button not finish, return
        if (btnstate == 1) {
            return
        }
        //check if already quit, return
        if (quitstate == 1) {
            return
        }
        //min bet is 10
        if (playerBet > 10) {
            playerBet = playerBet - 10
            playerbetl.text = String(playerBet)
        }
        // bet cannot over palyermoney
        if (playerBet > playermoney) {
            cannotplay.isHidden = false
        } else {
            cannotplay.isHidden = true
        }
        
    }
    
    //quit button, set zero to money, bet and winning
    @IBAction func quitbtn(_ sender: UIButton) {
        //check if slot button not finish, return
        //if finished, set zero, cannot play, information: goodluck, quitsstate set 1 = already quit
        if (btnstate == 0) {
            playermoney = 0
            playermoneyl.text = String(playermoney)
            playerBet = 0
            playerbetl.text = String(playerBet)
            winnings = 0
            playerwinning.text = String(winnings)
            cannotplay.isHidden = false
            infoimg.loadGif(name: "goodluck")
            quitstate = 1
        } else {
            return
        }
    }
    
    //reset button
    @IBAction func resetbtn(_ sender: Any) {
        //check if slot button not finish, return
        if (btnstate == 1) {
            return
        }
        //set picker
        slotMachine.selectRow(Int(1), inComponent: 0, animated: true)
        slotMachine.selectRow(Int(1), inComponent: 1, animated: true)
        slotMachine.selectRow(Int(1), inComponent: 2, animated: true)
        //set information image
        infoimg.loadGif(name: "goodluck")
        //hide cannot play
        cannotplay.isHidden = true
        //initialization
        playerBet = 200
        playermoney = 3000
        winnings = 0
        playerbetl.text = String(playerBet)
        playermoneyl.text = String(playermoney)
        playerwinning.text = String(winnings)
        //set quit state = 0 , not quit
        quitstate = 0
    }
    
    //slot button
    @IBAction func button(_ sender: Any) {
        //check bet not over playermoney
        if (playerBet > playermoney) {
            return
        }
        //check player have some money
        if (playermoney <= 0) {
            return
        }
        //check last action finished
        if (btnstate == 1){
            return
        }
        //set state to 1, start
        btnstate = 1
        player.play()
        
        //gif initialization
        infoimg.loadGif(name: "goodluck")
        backlightgif.loadGif(name: "backlightfast")
        
        //slot button image changed
        slotBtn.setImage( UIImage.init(named: "1"), for: .normal)
        //show the row gifs
        row1gif.isHidden = false
        row2gif.isHidden = false
        row3gif.isHidden = false
        //picker initialization
        slotMachine.selectRow(Int(1), inComponent: 0, animated: false)
        slotMachine.selectRow(Int(1), inComponent: 1, animated: false)
        slotMachine.selectRow(Int(1), inComponent: 2, animated: false)
        //initialization
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
        
        // count money
        playermoney = playermoney - playerBet
        self.playermoneyl.text = String(self.playermoney)
        
        //action part with time delay to show image in order
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.48) {
            self.row1gif.isHidden = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.randomSpin()
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.98) {
            self.row2gif.isHidden = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.randomSpin()
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.48) {
            self.row3gif.isHidden = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
            self.randomSpin()
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            //calculate quantity
            self.countitem()
            //calculate winnings
            self.determineWinnings()
            self.playermoney = self.playermoney + self.winnings
            self.jackpot = self.jackpot + self.playerBet
            //show lose gif image and numbers
            if self.winnings == 0 {
                self.infoimg.loadGif(name: "youlose")
                self.jackpotl.text = String(self.jackpot)
            }
            //show win gif image and numbers
            else {
                self.infoimg.loadGif(name: "youwin")
                self.jackpot = self.jackpot - self.winnings
                self.jackpotl.text = String(self.jackpot)
            }
            self.playermoneyl.text = String(self.playermoney)
            self.playerbetl.text = String(self.playerBet)
            self.playerwinning.text = String(self.winnings)
            
            //show normal backlight and slot button
            self.backlightgif.loadGif(name: "backlightslow")
            self.slotBtn.setImage( UIImage.init(named: "0"), for: .normal)
            
            //set state to 0, finished
            self.btnstate = 0
            if (self.playerBet > self.playermoney) {
                self.cannotplay.isHidden = false
            } else {
                self.cannotplay.isHidden = true
            }
            if self.playermoney == 0 {
                self.infoimg.loadGif(name: "gameover")
            }
            self.player.stop()
        }
    }
    
    //function count item number
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
    
    //function calculate winnings
    func determineWinnings(){
        //no bomb
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
        }
        else
        {
            return
        }
    }
    
    //odds
    func randomSpin(){
        let rownumber = Int.random(in: 0..<65) + 1
        switch rownumber {
        //41.5% bomb
        case 1..<28:
            randRow = 7 + 6
        //15.4% grapes
        case 28..<38:
            randRow = 0 + 6
        //13.8% bananas
        case 38..<47:
            randRow = 1 + 6
        //12.3% oranges
        case 47..<55:
            randRow = 2 + 6
        //7.7% cherries
        case 55..<60:
            randRow = 3 + 6
        //4.6% bars
        case 60..<63:
            randRow = 4 + 6
        //3.1% bells
        case 63..<65:
            randRow = 5 + 6
        //1.5% seven
        case 65:
            randRow = 6 + 6
        default:
            //randRow = 9 + 2
            return
        }
        //set picker with the random number from 1~65
        slotMachine.selectRow(Int(randRow), inComponent: counter, animated: true)
        self.pickerView(slotMachine, didSelectRow: Int(randRow), inComponent: counter)
        
        //for 3 times
        counter = counter + 1
        if counter == 3 {
            counter = 0
        }
    }
    
    //to know which row an which item
    func pickerView(_ pickerView: UIPickerView, didSelectRow: Int, inComponent: Int){
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

