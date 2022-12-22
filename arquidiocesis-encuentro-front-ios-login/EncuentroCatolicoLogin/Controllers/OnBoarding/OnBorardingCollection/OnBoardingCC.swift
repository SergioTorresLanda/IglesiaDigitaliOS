//
//  OnBoardingCC.swift
//  EncuentroCatolicoLogin
//
//  Created by Pablo Luis Velazquez Zamudio on 03/06/21.
//

import UIKit

class OnBoardingCC: UIViewController {

    var presenter: OnBoardingCCPresenterProtocol?
    
    @IBOutlet weak var onBoardingCV: UICollectionView!
    @IBOutlet weak var obPageControl: UIPageControl!
    @IBOutlet weak var siguienteOutlet: UIButton!
    @IBOutlet weak var omitirOutlet: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionRegister()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("VC ECLogin - OnBoardingCC")
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        obPageControl.currentPage = Int(x / onBoardingCV.frame.width)
        
        switch obPageControl.currentPage {
        case 0:
            siguienteOutlet.setTitle("Siguiente", for: .normal)
        default:
            siguienteOutlet.setTitle("Entendido", for: .normal)
        }
        
    }
    
     func handleNext() {
        let indexPath = IndexPath(item: 1, section: 0)
        obPageControl.currentPage = 1
        obPageControl.layoutIfNeeded()
        onBoardingCV.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func collectionRegister(){
      
        onBoardingCV.dataSource = self
        onBoardingCV.delegate = self
      
    }
    
    @IBAction func omitirOnBoarding(_ sender: Any) {
        presenter?.omitir(controller: self)
    }
    
    @IBAction func siguiente(_ sender: Any) {
        
        switch obPageControl.currentPage {
        case 0:
            handleNext()
            siguienteOutlet.setTitle("Entendido", for: .normal)
        default:
            presenter?.fin(controller: self)
        }
        handleNext()
    }

}

extension OnBoardingCC: OnBoardingCCProtocol {
    // TODO: implement view output methods
}
