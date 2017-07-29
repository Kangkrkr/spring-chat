package com.teamk.chat.user.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.teamk.chat.user.dto.UserDto;

@Repository
public class UserDaoImpl implements UserDao {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<UserDto> getAllUser() {
		return sqlSession.selectList("User.getAllUser");
	}

	@Override
	public UserDto getUser(UserDto user) {
		return sqlSession.selectOne("User.getUser", user);
	}

	@Override
	public UserDto getUserById(String userId) {
		return sqlSession.selectOne("User.getUserById", userId);
	}

	@Override
	public void insertUser(UserDto user) {
		sqlSession.insert("User.insertUser", user);
	}

}
