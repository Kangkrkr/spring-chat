package com.teamk.chat.user.dao;

import java.util.List;

import com.teamk.chat.user.dto.UserDto;

public interface UserDao {
	
	public List<UserDto> getAllUser();
	
	public UserDto getUser(UserDto user);
	
	public UserDto getUserById(String userId);
}
