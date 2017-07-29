package com.teamk.chat.user.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.teamk.chat.front.util.CmFuntion;
import com.teamk.chat.user.dto.UserDto;
import com.teamk.chat.user.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	private UserService userService;
	
	@RequestMapping("/user_login.do")
	public ModelAndView user_login(HttpServletRequest request, HttpServletResponse response, UserDto user) {
		HttpSession session = request.getSession();
		ModelAndView mav = new ModelAndView("user/user_login");
		
		if(CmFuntion.isNotEmpty((String)session.getAttribute("S_MEMBER_ID"))) {
			try {
				response.sendRedirect("/index.do");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		return mav;
	}
	
	@RequestMapping(value = "/login.do", method = RequestMethod.POST)
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response, UserDto user) {
		HttpSession session = request.getSession();
		ModelAndView mav = new ModelAndView("jsonView");

		try {
			UserDto result = userService.getUser(user);
			
			if(null == result) {
				mav.addObject("message", "입력된 회원정보를 찾을 수 없습니다.");
				mav.addObject("isLoginOk", "N");
			}else{
				if("Y".equals(user.getMember_exit())) {
					mav.addObject("message", "탈퇴한 회원입니다.");
					mav.addObject("isLoginOk", "N");
				} else {
					mav.addObject("message", "로그인에 성공하였습니다.");
					mav.addObject("isLoginOk", "Y");
					
					session.setAttribute("S_MEMBER_ID", user.getMember_id());
					session.setAttribute("S_MEMBER_NAME", user.getMember_name());
				}
			}
			
			return mav;
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return mav;
	}
	
	@RequestMapping(value = "/logout.do")
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response, UserDto user) {
		HttpSession session = request.getSession();
		ModelAndView mav = new ModelAndView("include/cm_message");
		
		session.invalidate();
		
		mav.addObject("message", "로그아웃 되었습니다.");
		mav.addObject("returnUrl", "/user/user_login.do");
		return mav;
	}
	
}
