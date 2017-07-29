package com.teamk.chat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.teamk.chat.front.util.CmFuntion;
import com.teamk.chat.user.dto.UserDto;
import com.teamk.chat.user.service.UserService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class IndexController {

	@Autowired
	private UserService userService;
	
	private static final Logger logger = LoggerFactory.getLogger(IndexController.class);

	@RequestMapping(value = {"/", "/index.do"}, method = RequestMethod.GET)
	public ModelAndView index(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		ModelAndView mav = new ModelAndView();
		
		String userId = (String)session.getAttribute("S_MEMBER_ID");
		
		if(CmFuntion.isEmpty(userId)) {
			mav.setViewName("user/user_login");
			return mav;
		}
		
		UserDto user = userService.getUserById(userId);
		
		mav.setViewName("index");
		mav.addObject("reqVo", user);
		return mav;
	}
	
}
