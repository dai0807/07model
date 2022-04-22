package com.model2.mvc.web.purchase;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
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
import com.model2.mvc.service.product.impl.ProductServiceImpl;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.purchase.impl.PuchaseDaoImpl;
import com.model2.mvc.service.purchase.impl.PurchaseServiceImpl;
import com.model2.mvc.service.user.UserService;
import com.model2.mvc.service.user.impl.UserServiceImpl;
 
//구매관리 컨틀ㄹ러 
@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {
//7번
	
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService ;

	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
//	
//	
	public   PurchaseController (){
		System.out.println(this.getClass());
	}
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
	
	@RequestMapping( value ="/addPurchaseView" , method = RequestMethod.GET)
	public ModelAndView  addPurchaseView(@RequestParam("prodNo") int prodNo  , HttpSession session, HttpServletRequest request) throws Exception {
	
		System.out.println("addPurchaseView ::: "  +prodNo );
		
	//	ProductService service = new ProductServiceImpl() ; 
		 Product product =  productService.getProduct(prodNo);
 
			String buyer_id =((User)request.getSession(true).getAttribute("user")).getUserId(); //유저 아이디 뽑기 
		
 			
	 	User pubchaseUser=userService.getUser(buyer_id);
			
			System.out.println("user::::"+ buyer_id);
			System.out.println("product :::" + product);
		 
		

		ModelAndView modelAndView = new ModelAndView() ;
		modelAndView.addObject("buyer_id" ,buyer_id);
		modelAndView.addObject("product" ,product);
		modelAndView.addObject("User" ,pubchaseUser);

		modelAndView.setViewName("/purchase/addPurchaseView.jsp") ;
		
		return modelAndView;
	}
	
	@RequestMapping(value = "/addPurchase" , method = RequestMethod.POST ) // 아주 펑펑 터짐 진자 펑펑 불꽃 놀이 하냐고요 ,,,, 
//	public ModelAndView addPurchase(@ModelAttribute("purchase") Purchase purchase , @RequestParam("buyerId") String buyerId ,  @RequestParam("prodNo") int prodNo ) throws Exception {
	public ModelAndView addPurchase(@ModelAttribute("purchase") Purchase purchase , @ModelAttribute("user") User user ,  @ModelAttribute("product") Product product ) throws Exception {

	System.out.println("adddPrucase Action " + purchase );
//		System.out.println("adddPrucase buyerId " + buyerId );
	//	System.out.println("adddPrucase prodNo " + prodNo );
		
	//	User user  = new User() ;
		//user.setUserId(buyerId); 
 		purchase.setBuyer(user) ;
 		System.out.println("user 나와라!! :: " + user);
 		
 	//	Product product =new Product() ;
 	//	product.setProdNo(prodNo) ;
 		purchase.setPurchaseProd(product) ;
 		System.out.println("product 나와라!! :: " + product);

 		
		purchaseService.addPurchase(purchase);

		
		
		ModelAndView modelAndView = new ModelAndView() ;
		modelAndView.addObject("purchase" , purchase) ;
		modelAndView.setViewName("/purchase/receiptView.jsp") ;
		return modelAndView;
	}

	@RequestMapping(value = "/listPurchase") // 아주 펑펑 터짐 진자 펑펑 불꽃 놀이 하냐고요 ,,,, 
	public ModelAndView listPurchase(@ModelAttribute("search") Search search  ,HttpServletRequest request ,   HttpSession session ) throws Exception {
 //  리스트 하기 
		System.out.println("listPurchase :: 옴!! ");

		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		
		
		System.out.println("search 정보들 "+search);
		String buyer_id =((User)request.getSession(true).getAttribute("user")).getUserId(); //유저 아이디 뽑기 
		System.out.println("buyer_id :: " + buyer_id );
		search.setSearchCondition(" ") ;
		search.setSearchKeyword(buyer_id) ;

		
		// Business logic 수행

	 Map<String , Object> map=purchaseService.getPurchaseList(search);
			
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
 
		
		ModelAndView modelAndView = new ModelAndView() ;
		modelAndView.addObject("buyer_id", buyer_id) ; 
		modelAndView.addObject("search", search) ; 
		modelAndView.addObject("list",  map.get("list")) ; 
		modelAndView.addObject("resultPage", resultPage) ; 
 		modelAndView.setViewName("/purchase/ListPurchase.jsp") ;
 		
 		
		return modelAndView;
	}	
	
	@RequestMapping(value =  "/getPurchase"  ,method=RequestMethod.GET )
	public ModelAndView listPurchase(@RequestParam("tranNo" ) int tranNo , HttpServletRequest request ,  HttpSession session ) throws Exception 
	{
		
		String buyer_id =((User)request.getSession(true).getAttribute("user")).getUserId(); //유저 아이디 뽑기 
		System.out.println("buyer_id :: " + buyer_id );
		System.out.println("getPurchase TranNO " + tranNo);
		 Purchase purchase = purchaseService.getPurchase(tranNo) ;
		System.out.println(purchase);
		
		ModelAndView modelAndView = new ModelAndView() ;

		modelAndView.addObject("buyer_id", buyer_id) ; 
		modelAndView.addObject("purchase", purchase) ; 
 		modelAndView.setViewName("/purchase/getPurchaseView.jsp") ;

		return modelAndView;
		
	}
//	@RequestMapping("/updatePurchaseView.do")
	@RequestMapping(value = "/updatePurchase" ,method =RequestMethod.GET)

	public ModelAndView updatePurchaseView(@RequestParam("tranNo" ) int tranNo  , HttpServletRequest request ,  HttpSession session    ) throws Exception 
	{
		String buyer_id =((User)request.getSession(true).getAttribute("user")).getUserId(); //유저 아이디 뽑기 

		System.out.println("UpdatePurchaseViewAction View옴 ");
		System.out.println("tranNo  옴 " +  tranNo );

		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		System.out.println(purchase);

		
		
		ModelAndView modelAndView = new ModelAndView() ;
		modelAndView.addObject("buyer_id", buyer_id) ; 
		modelAndView.addObject("purchase", purchase) ; 
		
		
		
		//  업데이트 뷰 까지 함 ,  와서 VIw에서 데이터 확인 하기!! 
		
		
		
 		modelAndView.setViewName("/purchase/updatePurchaseView.jsp") ;
 		return modelAndView;
		
	}
	
	
	//@RequestMapping("/updatePurchase.do")  // 데이터 받기 
	@RequestMapping(value = "/updatePurchase" , method = RequestMethod.POST)  // 데이터 받기 

	public ModelAndView updatePurchase(@RequestParam("tranNo") int tranNo,@ModelAttribute("purchase") Purchase purchase, HttpServletRequest request ,  HttpSession session ) throws Exception 
	{
		System.out.println("updatePurchase ::  "  + purchase );
		String buyer_id =((User)request.getSession(true).getAttribute("user")).getUserId(); //유저 아이디 뽑기 

		System.out.println("updatePurchase옴 ");
		ModelAndView modelAndView = new ModelAndView() ;
		purchaseService.updatePurchase(purchase) ; 
		
		
		System.out.println("update 끝! ");
		
 		modelAndView.setViewName("/purchase/getPurchase?tranNo"+tranNo) ;
 		return modelAndView;
		
	}
	
	//@RequestMapping("/updateTranCode.do")  // 데이터 받기 
	@RequestMapping(value ="/updateTranCode" , method = RequestMethod.GET)  // 데이터 받기 

	public ModelAndView updateTranCode(@ModelAttribute("search") Search search  , @RequestParam("tranNo") int tranNo  , @RequestParam("tranCode") String tranCode ,@RequestParam("currentPage") int  intcurrentPage ) throws Exception 
	{
		System.out.println("updatePurchase옴 ");

		System.out.println("updateTranCode :: tranNo ::  "  + tranNo  + " tranc Code :: " + tranCode );
 
		
		Purchase purchase = purchaseService.getPurchase(tranNo);		
		System.out.println("tranNo업뎃 전  " + purchase  );
		purchase.setTranCode(tranCode)  ; 
		System.out.println(   "purchase ::: "+  purchase.getTranCode()     );    
		//purchase.setTranCode(tranCode); // 트랜 코드 삽입
		System.out.println("값들어감");
		purchaseService.updateTranCode(purchase) ;
		
 
		purchase = purchaseService.getPurchase(tranNo);		
		System.out.println("tranNo업뎃후   " + purchase.getTranCode()  );
		
		ModelAndView modelAndView = new ModelAndView() ;
 		
		System.out.println(intcurrentPage);
		
		System.out.println("update 끝! ");
		modelAndView.addObject("search", search) ; 

 		modelAndView.setViewName("/purchase/listPurchase") ;
 		return modelAndView;
		
	}
	 //  	<a href="/updateProdcutTranCodeByProd.
	
//	@RequestMapping("listSale.do") // 판매 리스트 
	@RequestMapping(value = "listSale") // 판매 리스트 

	public ModelAndView listSale(@ModelAttribute("search") Search search  ,HttpServletRequest request ,   HttpSession session ) throws Exception {
 //  리스트 하기 
		System.out.println("listSale/: GET / POST");

		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
	search.setSearchCondition("") ;
 
 
		

		 Map<String , Object> map=purchaseService.getSaleList(search);
				
			Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
			System.out.println(resultPage);
			
	 
			
			ModelAndView modelAndView = new ModelAndView() ;
 			modelAndView.addObject("search", search) ; 
			modelAndView.addObject("list",  map.get("list")) ; 
			modelAndView.addObject("resultPage", resultPage) ;
		
 		modelAndView.setViewName("/purchase/listSaleView.jsp");
		return modelAndView;
	}	
	
}
