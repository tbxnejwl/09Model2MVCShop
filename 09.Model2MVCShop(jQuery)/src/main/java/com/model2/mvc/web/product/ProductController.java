package com.model2.mvc.web.product;

import java.io.File;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.CookieGenerator;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;

@Controller
@RequestMapping("/product/*")
public class ProductController {

	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	public ProductController() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	@RequestMapping(value="addProduct", method=RequestMethod.GET )
	public ModelAndView addProduct() throws Exception{
		System.out.println("/product/addProduct : GET");
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/product/addProductView.jsp");
		
		return modelAndView;
	}
	
	@RequestMapping(value = "addProduct", method=RequestMethod.POST)
	public String addProduct( @ModelAttribute("product") Product product, 
			@RequestParam("file") MultipartFile file, HttpServletRequest request) throws Exception{
		
		System.out.println("/product/addProduct : POST");

		System.out.println(request.getRealPath("\\images\\uploadFiles\\")+"\\" + file.getOriginalFilename());
		/*절대경로
		 * File f = new File(
		request.getRealPath("\\images\\uploadFiles\\")+"\\" + file.getOriginalFilename());
		*/
		File f = new File("C:\\workspace\\09.Model2MVCShop(jQuery)\\WebContent\\images\\uploadFiles\\"+file.getOriginalFilename());
		file.transferTo(f);
		
	
		
		product.setFileName(file.getOriginalFilename());
		
/*		
		if(FileUpload.isMultipartContent(request)) {
			String temDir = "C:\\workspace\\07.Model2MVCShop(URI,pattern)\\WebContent\\images\\uploadFiles\\";
			
			DiskFileUpload fileUpload = new DiskFileUpload();
			fileUpload.setRepositoryPath(temDir);
			fileUpload.setSizeMax(1024 * 1024 * 10);
			fileUpload.setSizeThreshold(1024 * 100);
			
			if(request.getContentLength() < fileUpload.getSizeMax()) {

				StringTokenizer token = null;
				
				List fileItemList = fileUpload.parseRequest(request);
				int size = fileItemList.size();
				for (int i = 0; i < size; i++) {
					FileItem fileItem = (FileItem) fileItemList.get(i);
					if(fileItem.isFormField()) {
						if(fileItem.getFieldName().equals("manuDate")) {
							token = new StringTokenizer(fileItem.getString("euc-kr"), "-");
							String manuDate = token.nextToken() + token.nextToken() + token.nextToken();
							product.setManuDate(manuDate);
						} else if(fileItem.getFieldName().equals("prodName")) {
							product.setProdName(fileItem.getString("euc-kr"));
						} else if(fileItem.getFieldName().equals("prodDetail")) {
							product.setProdDetail(fileItem.getString("euc-kr"));
						} else if(fileItem.getFieldName().equals("price")) {
							product.setPrice(Integer.parseInt(fileItem.getString("euc-kr")));
						}
					} else {
						if(fileItem.getSize() > 0) {
							int idx = fileItem.getName().lastIndexOf("\\");
							if(idx == -1) {
								idx=fileItem.getName().lastIndexOf("/");
							}
							String fileName = fileItem.getName().substring(idx+1);
							product.setFileName(fileName);
							try {
								File uploadedFile = new File(temDir, fileName);
								fileItem.write(uploadedFile);
							} catch (Exception e) {
								System.out.println(e);
							}
						} else {
							product.setFileName("../../images/empty.GIF");
						}
					}
				}
				
				
			} else {
				int overSize = (request.getContentLength() / 1000000);
				System.out.println("<script>alery('파일의 크기는 1MB까지 입니다. 올리신 파일용량은" + overSize + "MB입니다');");
				System.out.println("history.back();<script>");
			}
		} else {
			System.out.println("인코딩 타입이 multipart/form-data가 아닙니다..");
		}
		*/
		productService.addProduct(product);
		
		return "redirect:/product/listProduct?menu=manage&orderby=";

	}
	
	@RequestMapping(value="getProduct", method=RequestMethod.GET)
	public ModelAndView getProduct(@RequestParam("prodNo") int prodNo, Model model, HttpServletRequest request, HttpServletResponse response ) throws Exception{
		
		System.out.println("/product/getProduct : GET");
		
		Product product = productService.getProduct(prodNo);
		
		String history = null;
		
		Cookie[] cookies = request.getCookies();
		
		if (cookies!=null && cookies.length > 0) {
			for (int i = 0; i < cookies.length; i++) {
				Cookie cookie = cookies[i];
				if (cookie.getName().equals("history")) {
					history = cookie.getValue();
				}
			}
		}
		
		history += ","+product.getProdNo();
		
		CookieGenerator cg = new CookieGenerator();
		cg.setCookieName("history");
		cg.addCookie(response, history);
		
		model.addAttribute("product", product);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/product/getProduct.jsp");
		
		return modelAndView;
		
	}
	
	@RequestMapping(value = "listProduct")
	public String listProduct( @ModelAttribute("search") Search search , @RequestParam("orderby") String orderby, Model model , HttpServletRequest request) throws Exception{
		
		System.out.println("/product/listProduct : get/post");
		System.out.println(search.getCurrentPage()+" : currentpage");
		
		if(search.getCurrentPage() == 0){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		System.out.println(search.getCurrentPage()+" : currentpage");
		// Business logic 수행
		Map<String , Object> map=productService.getProductList(search,orderby);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/product/listProduct.jsp";
	}

	@RequestMapping(value="updateProduct", method=RequestMethod.GET)
	public String updateProduct(@RequestParam("prodNo") String prodNo, Model model) throws Exception{
		System.out.println("/product/updateProduct : get");
		
		Product product = productService.getProduct(Integer.parseInt(prodNo));
		
		model.addAttribute("product", product);
		
		return "forward:/product/updateProductView.jsp";
	}
		
	@RequestMapping(value="updateProduct", method=RequestMethod.POST)
	public ModelAndView updateProduct( @ModelAttribute("product") Product product, 
			@RequestParam("file") MultipartFile file, HttpServletRequest request) throws Exception{

		System.out.println("/product/updateProduct : POST");
		//Business Logic
		File f = new File(request.getRealPath("\\images\\uploadFiles\\")+"\\"+file.getOriginalFilename());
		file.transferTo(f);
		
		product.setFileName(file.getOriginalFilename());
		
		productService.updateProduct(product);
		
		
		//int prodNo = Integer.parseInt(request.getParameter("prodNo"));
	
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/product/getProduct.jsp");
		
		return modelAndView;
	
	}
	
	@RequestMapping(value="deleteProduct",method=RequestMethod.GET)
	public String deletePurchaseView( @RequestParam("prodNo") int prodNo , Model model, HttpSession session ) throws Exception{

		System.out.println("/deleteProductView.do");
		//Business Logic
		Product product = productService.getProduct(prodNo);
		model.addAttribute("product", product);

		// Model 과 View 연결

		return "forward:/product/deleteProductView.jsp";
	}
	
	@RequestMapping(value="deleteProduct", method=RequestMethod.POST)
	public String deletePurchase (@RequestParam("prodNo") int prodNo, Model model) throws Exception{
		System.out.println("/deleteProduct.do");
		
		productService.deleteProduct(prodNo);
		
		return "forward:/product/deleteProduct.jsp";
	}

}
