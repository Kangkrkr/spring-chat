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
	
	@RequestMapping(value = "/user_join.do")
	public ModelAndView join(HttpServletRequest request, HttpServletResponse response, UserDto user) {
		ModelAndView mav = new ModelAndView("user/user_join");
		
		return mav;
	}
	
	@RequestMapping(value = "/user_save.do", method = RequestMethod.POST)
	public ModelAndView user_save(HttpServletRequest request, HttpServletResponse response, UserDto user) {
		HttpSession session = request.getSession();
		ModelAndView mav = new ModelAndView("jsonView");
		
		try {
			if(null == user) {
				mav.addObject("message", "회원가입에 대한 정보가 없습니다.");
				mav.addObject("isJoinOk", "N");
			} else {
				user.setMember_channel("C001");
				user.setMember_auth("A001");
				user.setMember_exit("N");
				
				userService.insertUser(user);
				
				mav.addObject("message", "회원가입에 성공하였습니다.");
				mav.addObject("isjoinOk", "Y");
				
				session.setAttribute("S_MEMBER_ID", user.getMember_id());
				session.setAttribute("S_MEMBER_NAME", user.getMember_name());
			}
		} catch(Exception e) {
			e.printStackTrace();
			mav.addObject("message", "회원가입에  도중 문제가 발생하였습니다.");
			mav.addObject("isJoinOk", "N");
		}
		
		return mav;
	}
	
	@RequestMapping(value = "/id_check.do", method = RequestMethod.POST)
	public ModelAndView id_check(HttpServletRequest request, HttpServletResponse response, UserDto user) {
		ModelAndView mav = new ModelAndView("jsonView");
		
		try {
			UserDto exsistMember = userService.getUserById(user.getMember_id());
			
			if(exsistMember != null) {
				mav.addObject("message", "이미 가입된 아이디입니다.");
				mav.addObject("idCheckOk", "N");
			} else {
				mav.addObject("message", "사용가능한 아이디입니다.");
				mav.addObject("idCheckOk", "Y");
			}
		} catch(Exception e) {
			e.printStackTrace();
			
			mav.addObject("message", "아이디 체크 도중 오류가 발생했습니다.");
			mav.addObject("idCheckOk", "N");
		}
		
		return mav;
	}
}
