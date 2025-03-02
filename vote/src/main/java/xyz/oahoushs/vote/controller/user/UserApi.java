package xyz.oahoushs.vote.controller.user;

import io.swagger.annotations.ApiResponse;
import io.swagger.annotations.ApiResponses;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import xyz.oahoushs.vote.pojo.User;
import xyz.oahoushs.vote.result.Result;
import xyz.oahoushs.vote.result.ResultFactory;
import xyz.oahoushs.vote.service.IUserService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Slf4j
@RestController
@RequestMapping("/api")
public class UserApi {


    @Autowired
    IUserService userService;


    @GetMapping("/admin/user/list")
    public Result listUsers(
            HttpServletRequest request,
            HttpServletResponse response,
            @RequestParam("page") int page,
            @RequestParam("size") int size) {
        return userService.listUsers(request, response, page, size);
    }

    @GetMapping("/user/findAllCanVote")
    public Result findAllCanVote(
            @RequestParam("activityId") String activityId,
            @RequestParam("userName") String userName,
            @RequestParam("page") int page,
            @RequestParam("size") int size) {
        return userService.findAllCanVote(activityId, userName, page, size);
    }

    @GetMapping("/user/addVoter")
    public Result addVoter(
            @RequestParam("activityId") String activityId,
            @RequestParam("userName") String userName) {
        return userService.addVoter(activityId, userName);
    }

    @GetMapping("/user")
    public User getUserByName(@RequestParam("userName") String userName) {
        return userService.getByUserName(userName);
    }


    @PutMapping("/admin/user/state/{userId}")
    public Result changeUserState(@PathVariable("userId") int userId, @RequestParam("state") boolean state) {
        return userService.changeUserState(userId, state);
    }



    /**
     * 注册
     * @param user
     * @return
     */
    @PostMapping("/user/join_in")
    public Result register(@RequestBody User user,
                           @RequestParam("email_code")String emailCode,
                           @RequestParam("captcha_code")String captchaCode,
                           @RequestParam("captcha_key")String captchaKey,
                           HttpServletRequest request){
        return  userService.register(user,emailCode,captchaCode,captchaKey,request);
    }

    /**
     * 登录 sign-up
     *
     * 需要提交的数据
     * 1、用户账号-昵称/邮箱，
     * 2、密码
     * 3、图灵验证码
     * 4、图灵验证码的key
     * @param captcha
     * @param captchaKey
     * @param user
     * @return
     */
    @PostMapping("/user/login/{captcha}/{captcha_key}")
    public Result login(@PathVariable("captcha") String captcha,
                        @PathVariable("captcha_key") String captchaKey,
                        @RequestBody User user,
                        HttpServletRequest request,
                        HttpServletResponse response){

        return userService.doLogin(captcha,captchaKey,user,request,response);
    }

    /**
     * 退出登录
     * @return
     */
    @GetMapping("/user/logout")
    public Result logout() {
        Subject subject = SecurityUtils.getSubject();
        subject.logout();
        return ResultFactory.buildSuccessResult("成功登出");
    }

    /**
     * 获取图灵验证码
     * 有效时长10分钟
     * @return
     */
    @GetMapping("/user/captcha")
    public void getCaptcha(HttpServletResponse response,@RequestParam("captcha_key")String captchaKey)  {
        try{
            userService.createCaptcha(response,captchaKey);
        }catch (Exception e){
            log.error(e.toString());
        }
    }


    /**
     * 发送邮箱email
     * 使用场景： 注册、找回密码、修改邮箱(会输入新的邮箱)
     * 注册：已经注册过，提示已被注册
     * 找回密码：如果没有注册过，提示没有注册
     * 修改邮箱：新的邮箱地址--如果已经注册，提示被注册
     * @param request
     * @param emailAddress
     * @return
     */

    @GetMapping("/user/verify_code")
    public Result sendVerifyCode(HttpServletRequest request,
                                 @RequestParam("type")String type,
                                 @RequestParam("email")String emailAddress){
        log.info("email == > " + emailAddress);
        return userService.sendEmail(type,request,emailAddress);
    }

    /**
     * 修改密码
     * @param user
     * @return
     */
    @PutMapping("/user/password")
    public Result updatePassword( @RequestBody User user){
        return userService.updatePassword(user);
    }

    /**
     * 重置密码
     * @return
     */
    @PutMapping("/admin/user/repassword/{userId}")
    public Result reSetPassword( @PathVariable("userId") int userId){
        return userService.reSetPassword(userId);
    }

    /**
     * 修改邮箱
     *
     * @param user
     * @return
     */
    @PutMapping("/user/email")
    public Result updateEmail(@RequestParam("email") String email,
                              @RequestParam("verify_code") String verifyCode,
                              @RequestBody User user) {
        return userService.updateEmail(email, verifyCode, user);
    }

    /**
     * 修改头像
     *
     * @param user
     * @return
     */
    @PutMapping("/user/avatar")
    public Result updateAvatar(@RequestBody User user) {
        return userService.updateAvatar(user.getAvatar(), user.getUserName());
    }

    /**
     * 修改用户信息
     * <P>
     *     允许用户修改的内容
     *     1. 头像
     *     2. 用户名（唯一）
     *     2.5 签名
     *     3. 密码（单独修改）
     *     4. Email(唯一，单独修改)
     * </P>
     * @return
     */
    @PutMapping("/admin/user/{userId}")
    public Result updateUserInfo(HttpServletRequest request,
                                 HttpServletResponse response,
                                 @PathVariable("userId")int userId,
                                 @RequestBody User user){

        return userService.updateUserInfo(request, response, userId, user);
    }


    /**
     * 需要管理员权限
     *
     * @param userId
     * @return
     */
    @DeleteMapping("/user/{userId}")
    public Result deleteUser(HttpServletResponse response, HttpServletRequest request,
                             @PathVariable("userId") int userId) {
        //判断当前操作的用户是谁
        //根据用户角色判断是否可以删除
        //TODO:通过注解的方式来控制权限
        return userService.deleteUserById(userId, request, response);
    }



    /**
     * 检查邮箱是否已经被注册
     *
     * @param email
     * @return SUCCESS == > 已经注册了
     *         FAIL    == > 没有注册
     */
    @ApiResponses({
            @ApiResponse(code = 200,message = "当前邮箱已经被注册了"),
            @ApiResponse(code = 400,message = "当前邮箱未被注册了")
    })

    @GetMapping("/user/email")
    public Result checkEmail(@RequestParam("email")String email ){
        return userService.checkEmail(email);
    }


    /**
     * 检查用户名是否已经被注册
     *
     * @param userName
     * @return SUCCESS == > 已经注册了
     *         FAIL    == > 没有注册
     */
    @ApiResponses({
            @ApiResponse(code = 200,message = "用户名已经被注册了"),
            @ApiResponse(code = 400,message = "用户名未被注册了")
    })

    @GetMapping("/user/user_name")
    public Result checkUserName(@RequestParam("userName")String userName ){
        return userService.checkUserName(userName);
    }


    @GetMapping("/user/check_email_code")
    public Result checkEmailCode(@RequestParam("email") String email,
                                 @RequestParam("emailCode") String emailCode){
        return userService.checkEmailCode(email,emailCode);
    }


}
