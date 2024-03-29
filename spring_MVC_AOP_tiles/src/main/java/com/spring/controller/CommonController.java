package com.spring.controller;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.command.LoginCommand;
import com.spring.dto.MenuVO;
import com.spring.exception.InvalidPasswordException;
import com.spring.exception.NotFoundIDException;
import com.spring.service.MemberService;
import com.spring.service.MenuService;

@Controller
public class CommonController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private MenuService menuService;
	
	
	@RequestMapping(value="/common/login",method=RequestMethod.GET)
	public void loginForm()throws Exception{}
	
	@RequestMapping(value="/common/login",method=RequestMethod.POST)
	public String loginPost(LoginCommand loginReq,HttpServletRequest request,
										RedirectAttributes rttr)throws Exception{
		
		String url="redirect:/index.do";

		HttpSession session = request.getSession();
		
		try {
			memberService.login(loginReq.getId(),loginReq.getPwd());
			session.setAttribute("loginUser", memberService.getMember(loginReq.getId()));
			session.setMaxInactiveInterval(6*60);
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} catch (NotFoundIDException | InvalidPasswordException e) {			
			url="redirect:/common/login.do";
			rttr.addFlashAttribute("msg",e.getMessage());
		} 
		
		return url;
	}
	
	
	@RequestMapping("/index")
	public ModelAndView indexPage(ModelAndView mnv,
								@RequestParam(defaultValue="M000000")String mCode) 
									throws Exception{
		String url="common/indexPage.page";

		try {
			List<MenuVO> menuList = menuService.getMainMenuList();			
			MenuVO menu = menuService.getMenuByMcode(mCode);
			
			mnv.addObject("menuList",menuList);
			mnv.addObject("menu",menu);
		} catch (SQLException e) {			
			e.printStackTrace();
			throw e;
		}
		mnv.setViewName(url);
		return mnv;
	}
	
	
	
	@RequestMapping("/main")
	public String main() {
		String url="common/main";
		return url;
	}
	
	
	@RequestMapping("/getMcode")
	@ResponseBody //view단에 던지지말고 바로 리스폰스로 쏴라라는 뜻이다
	public ResponseEntity<MenuVO> getMcode(String mName)throws Exception{

		
		ResponseEntity<MenuVO> entity = null;
		
		try {
			
			MenuVO menu = menuService.getMenuByMname(mName);
			
			entity = new ResponseEntity<MenuVO>(menu,HttpStatus.OK);
			
		} catch (SQLException e) {
			entity = new ResponseEntity<MenuVO>(HttpStatus.INTERNAL_SERVER_ERROR);
			
			
		}
		
		return entity;
		
	}
	
	
	
	@RequestMapping("/subMenu")
	@ResponseBody
	public ResponseEntity<List<MenuVO>> SubMenu(String mCode)throws Exception{
		
		ResponseEntity<List<MenuVO>> entity = null;
		
		try {
			
			List<MenuVO> menuList = menuService.getSubMenuList(mCode);
			
			entity = new ResponseEntity<List<MenuVO>>(menuList,HttpStatus.OK);
			
		} catch (SQLException e) {
			entity = new ResponseEntity<List<MenuVO>>(HttpStatus.INTERNAL_SERVER_ERROR);
			
		}
		
		return entity;
		
	}
	
	
	
	@RequestMapping(value="/common/logout",method=RequestMethod.GET)
	public String logout(HttpSession session)throws Exception{
		
		String url="redirect:/";
		
		session.invalidate();
		
		return url;
	}
	
	
	
	
	
	
	
	
	
	
	
}


























