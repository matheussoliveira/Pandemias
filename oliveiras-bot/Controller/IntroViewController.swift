//
//  IntroViewController.swift
//  oliveiras-bot
//
//  Created by Marina Miranda Aranha on 28/05/20.
//  Copyright © 2020 Oliveiras. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController{
    
    @IBOutlet weak var button: UIButton!
    
    var buttonCounts: Int?
    
    
    @IBAction func buttonPressed(_ sender: Any) {
        if buttonCounts == 0{
            if scrollView.contentOffset.x < self.view.bounds.width * CGFloat(pages.count - 1) {
                scrollView.contentOffset.x +=  self.view.bounds.width
            }
        } else if buttonCounts == 1{
            if scrollView.contentOffset.x < self.view.bounds.width * CGFloat(pages.count - 1) {
                scrollView.contentOffset.x +=  self.view.bounds.width
                self.button.setTitle("INICIAR", for: .normal)
            }
        } else{
            performSegue(withIdentifier: "goToMain", sender: self)
        }
        self.buttonCounts! += 1
        
    }
    
    var pages : [IntroView] {
        get {
            let page1: IntroView = Bundle.main.loadNibNamed("IntroView", owner: self, options: nil)?.first as! IntroView
            page1.imageView.image = UIImage(named: "intro-chat")
            page1.title.text = "Conversa"
            page1.descriptionLabel.text = "Tire suas dúvidas e receba dicas sobre o Coronavírus (COVID - 19), com fontes confiáveis através de uma conversa com June"
            
            let page2: IntroView = Bundle.main.loadNibNamed("IntroView", owner: self, options: nil)?.first as! IntroView
            page2.imageView.image = UIImage(named: "intro-stats")
            page2.title.text = "Estatísticas"
            page2.descriptionLabel.text = "Obtenha estatísticas atualizadas sobre os casos confirmados, recuperados, mortes e ativos, através de gráficos e uma visão geral"
            
            let page3: IntroView = Bundle.main.loadNibNamed("IntroView", owner: self, options: nil)?.first as! IntroView
            page3.imageView.image = UIImage(named: "intro-faq")
            page3.title.text = "Dúvidas"
            page3.descriptionLabel.text = "Acesse respostas sobre dúvidas frequentes a respeito do Coronavírus (COVID - 19) de maneira rápida e objetiva com fontes confiáveis"
            
            return [page1, page2, page3]
        }
    }
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.buttonCounts = 0
            
            view.bringSubviewToFront(pageControl)
            view.bringSubviewToFront(button)
            
            setupScrollView(pages: pages)
            
            pageControl.numberOfPages = pages.count
            pageControl.currentPage = 0
        }

        func setupScrollView(pages: [IntroView]) {
            scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(pages.count), height: view.frame.height)
            scrollView.isPagingEnabled = true
            
            for i in 0 ..< pages.count {
                pages[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
                scrollView.addSubview(pages[i])
            }
        }
    }

extension IntroViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}
