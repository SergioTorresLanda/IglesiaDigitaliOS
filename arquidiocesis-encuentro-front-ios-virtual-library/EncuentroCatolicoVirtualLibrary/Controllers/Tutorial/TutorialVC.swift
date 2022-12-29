//
//  TutorialView.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 14/09/21.
//

import UIKit

open class TutorialView: UIViewController {
    
    
    var arrayImg = [UIImage(named: "Mis iglesias-tutorial – 2", in: Bundle.local, compatibleWith: nil), UIImage(named: "Mis iglesias-tutorial – 3", in: Bundle.local, compatibleWith: nil)]
    
// MARK: @IBOUTELTS -
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var doubleChev1: UIImageView!
    @IBOutlet weak var doubleChev2: UIImageView!
    @IBOutlet weak var doubleChev3: UIImageView!
    @IBOutlet weak var tutorialCollection: UICollectionView!
    @IBOutlet weak var btnGeneric: UIButton!
    @IBOutlet weak var pager: UIPageControl!
    @IBOutlet weak var doubleChevChurch1: UIImageView!
    @IBOutlet weak var doubleChevChurch2: UIImageView!
    @IBOutlet weak var lblExplanation1: UILabel!
    @IBOutlet weak var lblExpalantionChurch2: UILabel!
    
    var page = 0
    
// MARK: LIFE CYCLE VIEW FUNCTIONS -
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        rotateIcons()
        setupCollection()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.animate(withDuration: 0.3) {
                self.shadowView.alpha = 0.5
            }
        }

    }
    
    open override func viewWillAppear(_ animated: Bool) {
        print("VC ECVirtualLibrary - TutorialVC xx ")

    }
    
    private func setupCollection() {
        tutorialCollection.register(UINib(nibName: "TutorialCell", bundle: Bundle.local), forCellWithReuseIdentifier: "TUTOCELL")
        tutorialCollection.delegate = self
        tutorialCollection.dataSource = self
    }
    
    private func rotateIcons() {
        doubleChev1.transform = doubleChev1.transform.rotated(by: .pi * 1.5)
        doubleChev2.transform = doubleChev2.transform.rotated(by: .pi * 1.5)
        doubleChev3.transform = doubleChev3.transform.rotated(by: .pi * 1.5)
        doubleChevChurch1.transform.rotated(by: .pi * 1.5)
        btnGeneric.borderButtonColorWhite(color: .white)
    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pager.currentPage = Int(x / tutorialCollection.frame.width)
        
//        switch typeView {
//        case "FirstOnboarding":
//            if pager.currentPage == 2 {
//                //goIcon.isHidden = true
//               // btnContinue.isHidden = false
//            }else{
//               // goIcon.isHidden = false
//               // btnContinue.isHidden = true
//            }
//        case "PriestAdmin", "CommunityResp":
//            if pager.currentPage == 1 {
//               // goIcon.isHidden = true
//               // btnContinue.isHidden = false
//            }else{
//              //  goIcon.isHidden = false
//              //  btnContinue.isHidden = true
//            }
//
//        default:
//            break
//
//        }
        
    }
  
//        if pagerControl.currentPage == normalText.count - 1 {
//            pagerControl.currentPage = 0
//            let nextIndex = min(pagerControl.currentPage, normalText.count)
//            let indexPath = IndexPath(item: nextIndex, section: 0)
//            print(nextIndex)
//            pagerControl.currentPage = nextIndex
//           // defaults.set(pageControl.currentPage, forKey: "Page")
//            mainCollectionVewi.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//        }else{
//            let nextIndex = min(pagerControl.currentPage + 1, normalText.count)
//            let indexPath = IndexPath(item: nextIndex, section: 0)
//            print(nextIndex)
//            pagerControl.currentPage = nextIndex
//           // defaults.set(pageControl.currentPage, forKey: "Page")
//            mainCollectionVewi.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//        }
    
// MARK: @IBACTIONS -
    @IBAction func genericAction(_ sender: Any) {
        
        UIView.animate(withDuration: 0.6) {
            self.doubleChevChurch1.alpha = 0
            self.lblExplanation1.alpha = 0
            self.doubleChevChurch2.alpha = 1
            self.lblExpalantionChurch2.alpha = 1
        }
        
        btnGeneric.setTitle("Finalizar", for: .normal)
        
        if btnGeneric.titleLabel?.text == "Finalizar" {
            shadowView.alpha = 0
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    
//MARK: - Inicialización
    class public func showTutorial() -> TutorialView {
        let storyboard = UIStoryboard(name: "Tutorial", bundle: Bundle(for: AcceptAlert.self))
        let view = storyboard.instantiateViewController(withIdentifier: "TutorialView") as! TutorialView
        view.modalPresentationStyle = .overFullScreen
        
        return view
    }

}

extension TutorialView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayImg.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TUTOCELL", for: indexPath) as! TutorialCell
        cell.img.image = arrayImg[indexPath.item]
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: tutorialCollection.frame.width, height: self.tutorialCollection.bounds.height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

