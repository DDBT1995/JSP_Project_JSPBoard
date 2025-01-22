package com.sist.web.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.sist.common.util.StringUtil;
import com.sist.web.db.DBManager;
import com.sist.web.model.User;

public class UserDao {
	private static Logger logger = LogManager.getLogger(UserDao.class);
	
	public static Logger getLogger() {return logger;}
	public static void setLogger(Logger logger) {UserDao.logger = logger;}
	
	// 유저 정보 조회
	public User userSelect(String userId) {
		User user = null;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		StringBuilder sb = new StringBuilder();
		sb.append("SELECT NVL(USER_PWD, '') USER_PWD, ")
		  .append("NVL(USER_NAME, '') USER_NAME, ")
		  .append("NVL(USER_EMAIL, '') USER_EMAIL, ")
		  .append("NVL(USER_BIRTHDAY, '') USER_BIRTHDAY, ")
		  .append("NVL(USER_STATUS, 'N') USER_STATUS, ")
		  .append("NVL(TO_CHAR(REG_DATE, 'YYYYMMDD HH24:MI:SS'), '') REG_DATE ")
		  .append("FROM USERS ")
		  .append("WHERE USER_ID = ? ");
		
		try {
			conn = DBManager.getConnection();
			ps = conn.prepareStatement(sb.toString());
			ps.setString(1, userId);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				user = new User();
				user.setUserId(userId);
				user.setUserPwd(rs.getString("USER_PWD"));
				user.setUserName(rs.getString("USER_NAME"));
				user.setUserEmail(rs.getString("USER_EMAIL"));
				user.setUserBirthday(rs.getString("USER_BIRTHDAY"));
				user.setUserStatus(rs.getString("USER_STATUS"));
				user.setRegDate(rs.getString("REG_DATE"));
			}
		} catch (SQLException e) {
			logger.error("[UserDao]userSelect SQLException", e);
		} finally {
			DBManager.close(rs, ps, conn);
		}
		
		
		return user;
	}
	
	// 유저 아이디 조회
	public String userIdSearch(String userName, String userEmail) {
		String userId = null;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		StringBuilder sb = new StringBuilder();
		sb.append("SELECT NVL(USER_ID, '') USER_ID ")
		  .append("FROM USERS ")
		  .append("WHERE USER_NAME = ? AND ") 
		  .append("USER_EMAIL = ? ");
		
		try {
			conn = DBManager.getConnection();
			ps = conn.prepareStatement(sb.toString());
			ps.setString(1, userName);
			ps.setString(2, userEmail);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				userId = rs.getString("USER_ID");
			}
		} catch (SQLException e) {
			logger.error("[UserDao]userSelect SQLException", e);
		} finally {
			DBManager.close(rs, ps, conn);
		}
		
		return userId;
	}
	
	// 유저 비밀번호 조회
	public boolean userPwdSearch(String userName, String userEmail, String userId) {
		return StringUtil.equals(userIdSearch(userName, userEmail), userId);
	}
	
	// 유저 회원가입
	public boolean userInsert(User user) {
		Connection conn = null;
		PreparedStatement ps = null;
		
		StringBuilder sb = new StringBuilder();
		sb.append("INSERT INTO USERS(USER_ID, USER_PWD, USER_NAME, USER_EMAIL, USER_BIRTHDAY, USER_STATUS, REG_DATE) ")
		  .append("VALUES (?, ?, ?, ?, ?, 'Y', SYSDATE)");
		
		int cnt = 0;
		
		try {
			conn = DBManager.getConnection();
			ps = conn.prepareStatement(sb.toString());
			
			int idx = 0;
			ps.setString(++idx, user.getUserId());
			ps.setString(++idx, user.getUserPwd());
			ps.setString(++idx, user.getUserName());
			ps.setString(++idx, user.getUserEmail());
			ps.setString(++idx, user.getUserBirthday());
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			logger.error("[UserDao]userInsert SQLException", e);
		} finally {
			DBManager.close(ps, conn);
		}
		
		return (cnt == 1) ? true : false;
	}
	
	// 유저 아이디 중복검사
	public boolean userIdIsDuplicated(String userId) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		StringBuilder sb = new StringBuilder();
		sb.append("SELECT COUNT(USER_ID) CNT ")
		  .append("FROM USERS ")
		  .append("WHERE USER_ID = ?");
		
		int cnt = 0;
		
		try {
			conn = DBManager.getConnection();
			ps = conn.prepareStatement(sb.toString());
			ps.setString(1, userId);
			rs = ps.executeQuery();
			if(rs.next())
			{
				cnt = rs.getInt("CNT");
			}
		} catch (SQLException e) {
			logger.error("[UserDao]userIdIsDuplicated SQLException", e);
		} finally {
			DBManager.close(rs, ps, conn);
		}

		return (cnt != 0) ? true : false;
	}
	
	// 유저 이메일 중복검사
	public boolean userEmailIsDuplicated(String userEmail) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		StringBuilder sb = new StringBuilder();
		sb.append("SELECT COUNT(USER_ID) CNT ") 
		  .append("FROM USERS ")
		  .append("WHERE USER_EMAIL = ? ");
		
		int cnt = 0;
		
		try {
			conn = DBManager.getConnection();
			ps = conn.prepareStatement(sb.toString());
			ps.setString(1, userEmail);
			rs = ps.executeQuery();
			if(rs.next())
			{
			cnt = rs.getInt("CNT");
			}
		} catch (SQLException e) {
			logger.error("[UserDao]userEmailIsDuplicated SQLException", e);
		} finally {
			DBManager.close(rs, ps, conn);
		}

		return (cnt != 0) ? true : false;
	}
	
	// 유저 정보 업데이트
	public boolean userUpdate(User user) {
		Connection conn = null;
		PreparedStatement ps = null;
		
		StringBuilder sb = new StringBuilder();
		sb.append("UPDATE USERS ")
		  .append("SET USER_PWD = ?, USER_NAME = ?, USER_EMAIL = ?, USER_BIRTHDAY = ? ")
		  .append("WHERE USER_ID = ?");
		
		int cnt = 0;
		
		try {
			conn = DBManager.getConnection();
			ps = conn.prepareStatement(sb.toString());
			
			int idx = 0;
			ps.setString(++idx, user.getUserPwd());
			ps.setString(++idx, user.getUserName());
			ps.setString(++idx, user.getUserEmail());
			ps.setString(++idx, user.getUserBirthday());
			ps.setString(++idx, user.getUserId());
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			logger.error("[UserDao]userUpdate SQLException", e);
		} finally {
			DBManager.close(ps, conn);
		}
		
		return (cnt == 1) ? true : false;
	}
	
	// 유저 회원 탈퇴('Y'를 'N'으로 변경)
	public boolean userCancel(String userId) {
		Connection conn = null;
		PreparedStatement ps = null;
		
		StringBuilder sb = new StringBuilder();
		sb.append("UPDATE USERS ")
		  .append("SET USER_STATUS = 'N' ")
		  .append("WHERE USER_ID = ?");
		
		int cnt = 0;
		
		try {
			conn = DBManager.getConnection();
			ps = conn.prepareStatement(sb.toString());
			ps.setString(1, userId);
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			logger.error("[UserDao]userCancel SQLException", e);
		} finally {
			DBManager.close(ps, conn);
		}
		
		return (cnt == 1) ? true : false;
	}
}
