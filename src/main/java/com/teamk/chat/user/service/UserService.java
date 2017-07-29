package com.teamk.chat.user.service;

import java.util.List;

import com.teamk.chat.user.dto.UserDto;

public interface UserService {

	public List<UserDto> getAllUser();
	
	public UserDto getUser(UserDto user);
	
	public UserDto getUserById(String userId);
	
	public void insertUser(UserDto user);
	
}
