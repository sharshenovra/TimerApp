//
//  ViewController.swift
//  TimerApp
//
//  Created by Ruslan Sharshenov on 15.01.2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var timer = Timer()
    
    var second = 0
    var hour = 0
    var minute = 0
    
    var timerPicker: UIDatePicker = {
        let view = UIDatePicker()
        view.datePickerMode = .countDownTimer
        view.countDownDuration = 1
        view.roundsToMinuteInterval = false
        return view
    }()
    
    private lazy var timerView: UIView = {
        let view = UIView()
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 5, height: 5)
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 1.0
        view.layer.cornerRadius = 20
        view.backgroundColor = .gray
        return view
    }()
    
    
    private lazy var buttonToCount: UIButton = {
        let view = UIButton(type: .system)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 5, height: 5)
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 1.0
        view.layer.cornerRadius = 20
        view.setTitle("СТАРТ", for: .normal)
        view.addTarget(nil, action: #selector(timerStarted), for: .touchUpInside)
        view.setTitleColor(.black, for: .normal)
        view.backgroundColor = .systemGray6
        return view
    }()
    
    private lazy var buttonToStop: UIButton = {
        let view = UIButton(type: .system)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 5, height: 5)
        view.layer.shadowRadius = 20
        view.layer.shadowOpacity = 1.0
        view.layer.cornerRadius = 20
        view.setTitle("СТОП", for: .normal)
        view.addTarget(nil, action: #selector(timerStopped), for: .touchUpInside)
        view.setTitleColor(.black, for: .normal)
        view.backgroundColor = .systemGray6
        return view
    }()
    
    private lazy var timerLabel: UILabel = {
        let view = UILabel()
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 5, height: 5)
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 1.0
        view.layer.cornerRadius = 20
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubview()
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        timerPicker.addTarget(self, action: #selector(onDurationChanged), for: .valueChanged)
        
    }

    private func setupSubview(){
        view.addSubview(timerView)
        timerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(view.frame.width / 5)
            make.height.equalToSuperview().dividedBy(3)
            make.width.equalToSuperview().multipliedBy(0.9)
        }
        
        timerView.addSubview(timerPicker)
        timerPicker.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        view.addSubview(buttonToStop)
        buttonToStop.snp.makeConstraints { make in
            make.left.equalTo(timerView).offset(view.frame.height / 20)
            make.top.equalTo(timerView.snp.bottom).offset(view.frame.height / 20)
            make.height.equalTo(view.frame.height / 14)
            make.width.equalToSuperview().dividedBy(3.3)
        }
        
        view.addSubview(buttonToCount)
        buttonToCount.snp.makeConstraints { make in
            make.right.equalTo(timerView).offset(view.frame.height / -20)
            make.width.equalToSuperview().dividedBy(3.3)
            make.top.equalTo(timerView.snp.bottom).offset(view.frame.height / 20)
            make.height.equalTo(view.frame.height / 14)
        }
        
        view.addSubview(timerLabel)
        timerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(buttonToCount.snp.bottom).offset(view.frame.height / 10)
            make.width.equalToSuperview()
        }
    }
    
    @objc private func onDurationChanged(_ picker: UIDatePicker){
        let seconds = Int(picker.countDownDuration)
        second = seconds
        let minutes = seconds / 60
        minute = minutes
        let hours = minutes / 60
        hour = hours
        
        if hour >= 1{
            timerLabel.text = "Осталось \(hour) часов \n \(minute - (hour * 60)) минут \n \(second - (minute * 60)) секунд"
        }else if minute > 0{
            timerLabel.text = "Осталось \(minute) минут \n \(second - (minute * 60)) секунд"
        }else{
            
        }
        }
    
    @objc private func startTimer(){
        second -= 1

        if second == 0{
            timer.invalidate()
        }
        
        var minutes = second / 60
        var hours = minutes / 60
        
        timerLabel.text = "Осталось \(hours) часов \(minutes - (hours * 60)) минут и \(second - (minutes * 60)) секунд"
    }
    
    @objc func timerStarted(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startTimer), userInfo: nil, repeats: true)
        
        if second == 0{
            minute -= 1
            second = 60
        }else if second == 0 && minute == 0 && second == 0{
            timer.invalidate()
        }else{
            
        }
        
    }
    
    @objc func timerStopped(){
        timer.invalidate()
    }
    
}


