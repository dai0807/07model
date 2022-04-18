package com.model2.mvc.web.product;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.user.UserService;


@Controller
@RequestMapping("/product/*")
public class ProdctController {

	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method ���� ����
		
	public ProdctController(){
		System.out.println(this.getClass());
	}
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml ���� �Ұ�
	//==> �Ʒ��� �ΰ��� �ּ��� Ǯ�� �ǹ̸� Ȯ�� �Ұ�
	
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
	//@RequestMapping("/addProductView.do")
	@RequestMapping( value="addProduct" , method=RequestMethod.GET )
	public String addProductView() throws Exception {

		System.out.println("/addProductView  �� ������ ");
		
		return "redirect:/product/addProductView.jsp";
	}
	
	
	//@RequestMapping("/addProduct.do") // d�̰� �ٽ� �ϱ�! ,,,, �����Ͱ� ��� ��� �ʴ� �� ������ �ִ� 
	@RequestMapping( value="addProduct" , method=RequestMethod.POST)
	public String addProduct( @ModelAttribute("product1 ") Product  product1 , Model model    ) throws Exception {


		System.out.println("add Product View + product ::  �������� ������ " + product1 );
		product1.setManuDate(product1.getManuDate().replaceAll("-", "")) ;  // �������� 
		System.out.println("add Product View + product ::  �������� ���� �� " + product1 );

		productService.addProduct(product1) ;
		//Business Logic
 		
		
 		model.addAttribute("product1", product1);

		return "forward:/product/addgetProduct.jsp";
	}	
	
	
	//@RequestMapping("/listProduct.do")
	@RequestMapping(value = "listProduct"   )
	public String listProduct( @ModelAttribute("search") Search search , Model model ,@RequestParam("menu") String menu  ,HttpServletRequest request) throws Exception{
		System.out.println("/listProduct ::  GET / POST\"");

		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		System.out.println("search ������ "+search);
		// Business logic ����
		Map<String , Object> map=productService.getProductList(search);
		
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		System.out.println("menu :::  " + menu +" ��µ� ");
		
		// Model �� View ����
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		model.addAttribute("menu", menu);  // �޴��� searh �� manage ������ 

		
		return "forward:/product/listProduct.jsp";
	}

	
	
	//@RequestMapping("/getProduct.do")
	@RequestMapping(value = "getProduct" ,method=RequestMethod.GET  )
	
	public String getProduct(@RequestParam("prodNo" ) int prodNo , Model model ) throws Exception 
	{
		System.out.println("/getProduct ::  ");
		Product product  = productService.getProduct(prodNo) ;
	
		System.out.println("product ::: ����ϱ� " + product );
		model.addAttribute("Product" , product ) ;
	 	
	
		return "forward:/product/getProduct.jsp";
		
	
	}
	
//	@RequestMapping("/updateProductView.do")
	@RequestMapping(value = "updateProductView" ,  method=RequestMethod.GET  )

	public String updateProductView(@RequestParam("prodNo" ) int prodNo ,@RequestParam("tranCode" ) String  tranCode ,  Model model ) throws Exception 
	{
		System.out.println("/updateProductView.");
		Product product  = productService.getProduct(prodNo) ;
	
		System.out.println("product ::: ����ϱ� " + product );
		model.addAttribute("Product" , product ) ;
	 	
	
		return "forward:/product/updateProductView.jsp";
		
	
	}
		
	//@RequestMapping("/updateProduct.do")
	@RequestMapping(value = "updateProduct" ,  method=RequestMethod.POST  )
	public String updateProduct( @ModelAttribute("product ") Product  product , Model model ) throws Exception 
	{
		System.out.println("/updateProductView.do");
//		Product product  = productService.getProduct(prodNo) ;
		product.setManuDate(product.getManuDate().replaceAll("-", "")) ;  // �������� 

		productService.updateProduct(product) ;
		
		System.out.println("product ::: ����ϱ� " + product );
	//	model.addAttribute("Product" , product ) ;
	 	System.out.println("��������!! ");
	
		return "redirect:/getProduct.do?prodNo="+product.getProdNo();
		
	
	}	
	
}