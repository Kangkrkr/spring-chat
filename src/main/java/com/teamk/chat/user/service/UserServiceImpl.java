package com.teamk.chat.user.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamk.chat.user.dao.UserDao;
import com.teamk.chat.user.dto.UserDto;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDao userDao;
	
	@Override
	public List<UserDto> getAllUser() {
		return userDao.getAllUser();
	}

	@Override
	public UserDto getUser(UserDto user) {
		return userDao.getUser(user);
	}

	@Override
	public UserDto getUserById(String userId) {
		return userDao.getUserById(userId);
	}

	@Override
	public void insertUser(UserDto user) {
		userDao.insertUser(user);
	}

}
