package xyz.oahoushs.vote.service;


import xyz.oahoushs.vote.pojo.User;
import xyz.oahoushs.vote.result.Result;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface IUserService {
    void createCaptcha(HttpServletResponse response, String captchaKey) throws Exception;

    Result getUserInfo(int userId);

    Result updateUserInfo(HttpServletRequest request, HttpServletResponse response, int userId, User user);

    Result listUsers(HttpServletRequest request, HttpServletResponse response, int page, int size);


    Result findAllCanVote(String activityId,String userName, int page, int size);

    Result checkEmail(String email);

    Result register(User user, String emailCode, String captchaCode, String captchaKey,HttpServletRequest request);

    Result sendEmail(String type, HttpServletRequest request, String emailAddress);

    Result deleteUserById(int userId, HttpServletRequest request, HttpServletResponse response);

    Result checkUserName(String userName);

    Result doLogin(String captcha, String captchaKey, User user, HttpServletRequest request, HttpServletResponse response);

    User getByUserName(String username);

    Result updatePassword(User user);

    Result updateEmail(String email,String verifyCode,User user);

    Result reSetPassword(int userId);

    Result checkEmailCode(String email, String emailCode);

    Result changeUserState(int userId,boolean state);

    Result addVoter(String activityId, String userName);

    Result updateAvatar(String avatar, String userName);
}
