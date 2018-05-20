package com.model2.mvc.web.purchase;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.purchase.impl.PurchaseServiceImpl;

@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;

	public PurchaseController() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	@RequestMapping(value="addPurchase", method=RequestMethod.GET)
	public String addPurchaseView(@RequestParam("prodNo") int prodNo, Model model) throws Exception{
		System.out.println("/addPurchaseView.do");
		
		Product product = productService.getProduct(prodNo);
		model.addAttribute("product", product);
		
		return "forward:/purchase/addPurchaseView.jsp";

	}
	
	@RequestMapping(value="addPurchase", method=RequestMethod.POST)
	public String addProduct(@ModelAttribute("purchase") Purchase purchase, @RequestParam("prodNo") int prodNo, 
			HttpSession session) throws Exception{
		
		System.out.println("/addPurchase.do");
		
		User user = (User)session.getAttribute("user");
		Product product = productService.getProduct(prodNo);
		purchase.setPurchaseProd(product);
		purchase.setBuyer(user);
		
		purchaseService.addPurchase(purchase);
		
		return "forward:/purchase/addPurchase.jsp";
	}
	
	@RequestMapping(value="listPurchase")
	public String listPurchase( @ModelAttribute("search") Search search , Model model , HttpServletRequest request, HttpSession session) throws Exception{
		
		System.out.println("/listPurchase.do");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		User user = (User) session.getAttribute("user");
		Map<String , Object> map=purchaseService.getPurchaseList(search, user.getUserId());
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/purchase/listPurchase.jsp";
	}
	
	@RequestMapping(value="getPurchase")
	public String getPrucahse( @RequestParam("tranNo") int tranNo , Model model ) throws Exception {
		
		System.out.println("/getPurchase.do");
		//Business Logic
		Purchase purchase = purchaseService.getPurchase(tranNo);
		
		// Model 과 View 연결
		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/getPurchase.jsp";
	}
	
	@RequestMapping(value="deletePurchase",method=RequestMethod.GET)
	public String deletePurchaseView( @RequestParam("tranNo") int tranNo , Model model, HttpSession session ) throws Exception{

		System.out.println("/deletePurchaseView.do");
		//Business Logic
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		model.addAttribute("purchase", purchase);
		
		// Model 과 View 연결

		return "forward:/purchase/deletePurchaseView.jsp";
	}
	
	@RequestMapping(value="deletePurchase", method=RequestMethod.POST)
	public String deletePurchase (@RequestParam("tranNo") int tranNo, Model model) throws Exception{
		System.out.println("/deletePurchase.do");
		
		purchaseService.deletePurchase(tranNo);
		
		return "forward:/purchase/deletePurchase.jsp";
	}
	
	@RequestMapping(value="updatePurchase", method=RequestMethod.GET)
	public String updatePurchaseView( @RequestParam("tranNo") int tranNo , Model model ) throws Exception{

		System.out.println("/updatePurchaseView.do");
		//Business Logic
		Purchase purchase = purchaseService.getPurchase(tranNo);
		
		// Model 과 View 연결
		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/updatePurchaseView.jsp";
	}
	
	@RequestMapping(value="updatePurchase", method=RequestMethod.POST)
	public String updatePurchase ( @ModelAttribute("purchase") Purchase purchase , Model model) throws Exception{
		System.out.println("/updatePurchase.do");
		
		purchaseService.updatePurchase(purchase);
		
		return "redirect:/purchase/getPurchase?tranNo="+purchase.getTranNo();
	}
	
	@RequestMapping(value="updateTranCode")
	public ModelAndView updateTranCodeByProd(@RequestParam(value = "prodNo", required=false) String prodNo, @RequestParam(value="tranNo", required=false) String tranNo,
			@RequestParam("tranCode") String tranCode, HttpSession session) throws Exception{
		
		int tranCodeu = Integer.parseInt(tranCode.trim());
		System.out.println("/purchase/updateTranCodeByProd : GET");
		
		String role = "";
		User user = (User)session.getAttribute("user");
		
		if(user != null) {
			role = user.getRole();	
		}
		Purchase purchase = null;
		ModelAndView modelAndView = new ModelAndView();
		

		if(role.equals("admin")) {
			modelAndView.setViewName("redirect:/product/listProduct?menu=manage&orderby=");
			purchase = purchaseService.getPurchase2(Integer.parseInt(prodNo));			
		} 
		else if(role.equals("user")) {
			modelAndView.setViewName("redirect:/purchase/listPurchase");
			purchase = purchaseService.getPurchase(Integer.parseInt(tranNo));
		}
		System.out.println(tranCodeu);
		tranCodeu++;
		System.out.println(tranCodeu);
		
		purchase.setTranCode(String.valueOf(tranCodeu));
		purchaseService.updateTranCode(purchase);
	
		return modelAndView;
	}
	

}
