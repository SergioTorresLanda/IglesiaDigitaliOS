//
//  NewOnboardingsView.swift
//  EncuentroCatolicoProfile
//
//  Created by Pablo Luis Velazquez Zamudio on 13/09/21.
//

import UIKit


class NewOnboardingsView: UIViewController, NewOnboardingViewProtocol {
    
// MARK: - PROTOCOL VAR
    var presenter: NewOnboardingPresenterProtocol?
    
    var typeView = "FirstOnboarding"
    var isFormLogin = false
    var normalText : [String] = []
    var titulosText : [String] = []
    var imgNames: [String] = []
    var showViñetas: [Bool] = []
    var viñetasText : [String] = []
    var name = "Unsoecified"
    let defaults = UserDefaults.standard
    
// MARK: @IBOUTLETS -
    @IBOutlet weak var mainCollectionVewi: UICollectionView!
    @IBOutlet weak var pagerControl: UIPageControl!
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var goIcon: UIImageView!
    @IBOutlet weak var btnSkip: UIButton!
    
// MARK: LIFE CYCLE VIEW FUNCTIONS -
    override func viewDidLoad() {
        super.viewDidLoad()
        validateFormView(typeView: typeView)
        setupGestures()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("VC ECProfile - NewonboardingsV ")
    }
    
    func validateFormView(typeView: String) {
        let nombre = defaults.string(forKey: "nombre") ?? ""
        if nombre != "" {
            name = nombre
        }
        
        switch  typeView{
        case "FirstOnboarding":
            showViñetas = [false, false, false]
            titulosText = ["Bienvenido", "", ""]
            normalText = ["A este espacio de Iglesia Digital de la Arquidiócesis de México, donde fieles, sacerdotes, religiosos, comunidades e instituciones de inspiración católica tenemos un lugar especial.", "En esta app encontrarás espacios de oración, formación, interacción e información relevante de iglesias y comunidades que te ayudarán a vivir tu fe.", "Te invitamos a completar tu registro para conocerte mejor y darte acceso a las funciones que podrás utilizar según tu rol."]
            imgNames = ["FirstA", "FirstB", "FirstC"]
        case "PriestAdmin":
            showViñetas = [true, false]
            titulosText = ["", ""]
            normalText = ["Gracias padre \(name) has sido registrado como sarcedote administrador y ahora puedes:", "Necesitamos que definas los módulos que quieres aplicar en tu iglesia y las personas que pueden ayudarte como administradoras de las funcionalidades de la app." ]
            imgNames = ["PriestAdminA", "PriestAdminB"]
            viñetasText = ["Ver y editar el perfil con la información de tu iglesia", "Consultar el historial de ofrenda recibidas, publicar en red social a nombre propio y de tu iglesia", "Recibir notificaciones"]
        case "CommunityResp":
            showViñetas = [true, false]
            titulosText = ["", ""]
            normalText = ["Gracias \(name) te registraste como responsable de comunidad, a partir de ahora tu tienes la posibildad de:", "Necesitamos que definas en 'Configuración' los módulos que quieres aplicar en tu comunidad y las personas que pueden ayudarte como administradoras de las funcionalidades de la app." ]
            imgNames = ["ComRespA", "ComRespB"]
            viñetasText = ["Editar el perfil de tu comunidad", "Publicar en red social a nombre propio y de tu comunidad", "Recibir notificaciones"]
        case "Priest":
            goIcon.isHidden = true
            btnContinue.isHidden = false
            pagerControl.isHidden = true
            showViñetas = [true]
            titulosText = [""]
            //normalText = ["Estamos trabajando en la actualización de los datos. Agradecemos su comprensión"]
            normalText = ["Gracias padre \(name) has sido registrado como sacerdote y ahora tienes derecho a:" ]
            imgNames = ["Priest"]
            viñetasText = ["Ver y editar tu perfil", "Consultar el historial de ofrendas recibidas", "Publicar en red social a nombre propio"]
        case "FaithfulAdmin":
            goIcon.isHidden = true
            btnContinue.isHidden = false
            btnSkip.isHidden = true
            pagerControl.isHidden = true
            showViñetas = [false]
            titulosText = [""]
            normalText = ["Has sido nombrado adminstrador por lo que ahora a nombre de la iglesia puedes editar su información o gestionar servicios según los permisos que se te hayan otorgado"]
            imgNames = ["Generic"]
            
            
        case "CommunityAdmin":
            goIcon.isHidden = true
            btnContinue.isHidden = false
            btnSkip.isHidden = true
            pagerControl.isHidden = true
            showViñetas = [false]
            titulosText = [""]
            normalText = ["Has sido nombrado adminstrador por lo que ahora a nombre de la comunidad puedes editar su información o gestionar servicios según los permisos que se te hayan otorgado"]
            imgNames = ["Generic"]
            
        default:
            break
        }
        setupDelegates()
        
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(TapGo))
        goIcon.addGestureRecognizer(tapGesture)
    }
    
    func setupDelegates() {
        pagerControl.numberOfPages = normalText.count
        mainCollectionVewi.delegate = self
        mainCollectionVewi.dataSource = self
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pagerControl.currentPage = Int(x / mainCollectionVewi.frame.width)
        
        switch typeView {
        case "FirstOnboarding":
            if pagerControl.currentPage == 2 {
                goIcon.isHidden = true
                btnContinue.isHidden = false
            }else{
                goIcon.isHidden = false
                btnContinue.isHidden = true
            }
        case "PriestAdmin", "CommunityResp":
            if pagerControl.currentPage == 1 {
                goIcon.isHidden = true
                btnContinue.isHidden = false
            }else{
                goIcon.isHidden = false
                btnContinue.isHidden = true
            }
            
        default:
            break
            
        }
        
    }
    
// MARK: @OBJC FUNC -
    func handleNext() {
        if pagerControl.currentPage == normalText.count - 1 {
            pagerControl.currentPage = 0
            let nextIndex = min(pagerControl.currentPage, normalText.count)
            let indexPath = IndexPath(item: nextIndex, section: 0)
            print(nextIndex)
            pagerControl.currentPage = nextIndex
           // defaults.set(pageControl.currentPage, forKey: "Page")
            mainCollectionVewi.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }else{
            let nextIndex = min(pagerControl.currentPage + 1, normalText.count)
            let indexPath = IndexPath(item: nextIndex, section: 0)
            print(nextIndex)
            pagerControl.currentPage = nextIndex
           // defaults.set(pageControl.currentPage, forKey: "Page")
            mainCollectionVewi.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
        
       
   }
    
    @objc func TapGo() {
        handleNext()
        switch typeView {
        case "FirstOnboarding":
            if pagerControl.currentPage == 2 {
                goIcon.isHidden = true
                btnContinue.isHidden = false
            }
        case "PriestAdmin", "CommunityResp":
            if pagerControl.currentPage == 1 {
                goIcon.isHidden = true
                btnContinue.isHidden = false
            }
        default:
            break
        }
                
    }
    
    
// MARK: @IBACTIONS -
    @IBAction func skipAction(_ sender: Any) {
        let defaults = UserDefaults.standard
        let newUser = defaults.bool(forKey: "isNewUser")
        if newUser == true {
            self.dismiss(animated: true, completion: nil)
            //let view = ProfileInfoRouter.createModule()
            //self.navigationController?.pushViewController(view, animated: true)
            //defaults.setValue(false, forKey: "isNewUser")
        }else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func continueAction(_ sender: Any) {
        let defaults = UserDefaults.standard
        let newUser = defaults.bool(forKey: "isNewUser")
        if newUser == true {
            self.dismiss(animated: true, completion: nil)
            //let view = ProfileInfoRouter.createModule()
            //self.navigationController?.pushViewController(view, animated: true)
            //defaults.setValue(false, forKey: "isNewUser")
        }else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    

}


