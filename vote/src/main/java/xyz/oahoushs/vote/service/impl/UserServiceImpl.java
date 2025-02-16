package xyz.oahoushs.vote.service.impl;

import com.wf.captcha.ArithmeticCaptcha;
import com.wf.captcha.GifCaptcha;
import com.wf.captcha.SpecCaptcha;
import com.wf.captcha.base.Captcha;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.crypto.SecureRandomNumberGenerator;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.web.util.HtmlUtils;
import xyz.oahoushs.vote.dao.UserDAO;
import xyz.oahoushs.vote.pojo.AdminRole;
import xyz.oahoushs.vote.pojo.AdminRoleMenu;
import xyz.oahoushs.vote.pojo.AdminUserRole;
import xyz.oahoushs.vote.result.Result;
import xyz.oahoushs.vote.result.ResultFactory;
import xyz.oahoushs.vote.service.AdminRoleMenuService;
import xyz.oahoushs.vote.service.AdminRoleService;
import xyz.oahoushs.vote.service.AdminUserRoleService;
import xyz.oahoushs.vote.service.IUserService;
import xyz.oahoushs.vote.utils.Constants;
import xyz.oahoushs.vote.utils.IdWorker;
import xyz.oahoushs.vote.utils.RedisUtils;
import xyz.oahoushs.vote.utils.TextUtils;
import xyz.oahoushs.vote.pojo.User;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.transaction.Transactional;
import java.util.Date;
import java.util.List;
import java.util.Random;

@Slf4j
@Service
@Transactional
public class UserServiceImpl extends BaseService implements IUserService {


    @Autowired
    UserDAO userDAO;

    @Autowired
    IdWorker idWorker;


    @Autowired
    AdminRoleService adminRoleService;
    @Autowired
    AdminUserRoleService adminUserRoleService;


    public static final int[] captcha_font_types = {
            Captcha.FONT_1,
            Captcha.FONT_2,
            Captcha.FONT_3,
            Captcha.FONT_4,
            Captcha.FONT_5,
            Captcha.FONT_6,
            Captcha.FONT_7,
            Captcha.FONT_8,
            Captcha.FONT_9,
            Captcha.FONT_10};

    @Autowired
    Random random;

    @Autowired
    RedisUtils redisUtils;

    @Override
    public void createCaptcha(HttpServletResponse response, String captchaKey)throws Exception {
        if(TextUtils.isEmpty(captchaKey) || captchaKey.length() < 13){
            return;
        }
        long key;
        try{
            key = Long.parseLong(captchaKey);
        }catch (Exception e){
            return;
        }
        //可以用了
        // 设置请求头为输出图片类型
        response.setContentType("image/gif");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);
        int captchaType = random.nextInt(3);
        Captcha targetCaptcha = null;
        if(captchaType  == 0){
            // 三个参数分别为宽、高、位数
            targetCaptcha = new SpecCaptcha(210,60,5);
        }else if(captchaType == 1){
            //gif类型
            targetCaptcha = new GifCaptcha(210,60,5);
        }else {
            //算数类型
            targetCaptcha= new ArithmeticCaptcha(210,60);
            targetCaptcha.setLen(2);//几位数运算、默认两位
        }


        int index = random.nextInt(captcha_font_types.length);
        log.info("captcha font type index == > "+index);
        targetCaptcha.setFont(captcha_font_types[index]);
        targetCaptcha.setCharType(Captcha.TYPE_DEFAULT);
        String content = targetCaptcha.text().toLowerCase();//转成小写
        log.info("captcha content == > "+ content);
        //保存到redis
        redisUtils.set(Constants.User.KEY_CAPTCHA_CONTENT + key,content,60 * 10);
        targetCaptcha.out(response.getOutputStream());
    }



    @Override
    public Result getUserInfo(int userId) {
        return null;
    }

    @Override
    public Result updateUserInfo(HttpServletRequest request, HttpServletResponse response, int userId, User user) {
        User userFromDb = userDAO.findOneById(user.getId());
        userFromDb.setEmail(user.getEmail());
        try {
            userDAO.save(userFromDb);
            adminUserRoleService.saveRoleChanges(userFromDb.getId(), user.getRoles());
        } catch (IllegalArgumentException e) {
            return ResultFactory.buildFailResult("更新成功");
        }
        return ResultFactory.buildSuccessResult("参数错误，更新失败");

    }


    @Override
    public Result listUsers(HttpServletRequest request, HttpServletResponse response, int page, int size) {
        //分页查询
        page = checkPage(page);
        size = checkSize(size);
        //根据注册日期降序
        Sort sort = Sort.by(Sort.Direction.DESC, "createTime");
        Pageable pageable = PageRequest.of(page - 1, size,sort);

        Page<User> all = userDAO.listAllUser(pageable);

        List<AdminRole> roles;
        for(User user : all){
            roles = adminRoleService.listRolesByUser(user.getUserName());
            user.setRoles(roles);
        }
        return ResultFactory.buildSuccessResult(all);
    }

    /**
     * 检查邮箱是否已被注册
     * @param email
     * @return
     */
    @Override
    public Result checkEmail(String email) {
        User user = userDAO.findOneByEmail(email);
        return user == null ? ResultFactory.buildFailResult("该邮箱未注册") : ResultFactory.buildSuccessResult("该邮箱已被注册");
    }

    /**
     * 注册
     * @param user
     * @param captchaCode
     * @param captchaKey
     * @param request
     * @return
     */
    @Override
    public Result register(User user,String emailCode, String captchaCode, String captchaKey, HttpServletRequest request) {

        //第一步：检查当前用户名是否已经注册
        String userName = user.getUserName();
        if (TextUtils.isEmpty(userName)) {
            return ResultFactory.buildFailResult("用户名不能为空.");
        }
        User userByName = userDAO.findOneByUserName(userName);
        if(userByName != null){
            return ResultFactory.buildFailResult("该用户名已被注册.");
        }
        //第二步：检查邮箱格式是否正确
        String email = user.getEmail();
        if (TextUtils.isEmpty(email)) {
            return ResultFactory.buildFailResult("邮箱地址不能为空.");
        }
        if(!TextUtils.isEmailAddressOk(email)){
            return ResultFactory.buildFailResult("邮箱地址格式不正确！");
        }
        //第三步：检查该邮箱是否已经注册
        User userByEmail = userDAO.findOneByEmail(email);
        if(userByEmail != null){
            return ResultFactory.buildFailResult("该邮箱已被注册.");
        }
        //第四步：检查邮箱验证码是否正确
//        String emailVerifyCode = (String) redisUtils.get(Constants.User.KEY_EMAIL_CODE_CONTENT + email);
//        if (TextUtils.isEmpty(emailVerifyCode)) {
//            return ResultFactory.buildFailResult("邮箱验证码已过期");
//        }
//        if (!emailVerifyCode.equals(emailCode)) {
//            return  ResultFactory.buildFailResult("邮箱验证码不正确");
//        } else {
//            //正确，干掉redis里的内容
//            redisUtils.del(Constants.User.KEY_EMAIL_CODE_CONTENT + email);
//        }
        //第四步：检查图灵验证码是否正确
        String captchaVerifyCode = (String) redisUtils.get(Constants.User.KEY_CAPTCHA_CONTENT + captchaKey);
        log.info("captchaVerifyCode === > " + captchaVerifyCode);
        if (TextUtils.isEmpty(captchaVerifyCode)) {
            return ResultFactory.buildFailResult("验证码已过期");
        }
        if (!captchaVerifyCode.equals(captchaCode)) {
            return ResultFactory.buildFailResult("验证码不正确");
        } else {
            redisUtils.del(Constants.User.KEY_CAPTCHA_CONTENT + captchaKey);
        }
        //达到可以注册的条件
        //第五步： 对密码加密
        String  password = user.getPassword();
        // 生成盐,默认长度 16 位
        String salt = new SecureRandomNumberGenerator().nextBytes().toString();
        // 设置 hash 算法迭代次数
        int times = 2;
        // 得到 hash 后的密码
        String encodedPassword = new SimpleHash("md5", password, salt, times).toString();
        // 存储用户信息，包括 salt 与 hash 后的密码
        user.setSalt(salt);
        user.setPassword(encodedPassword);
        //第六步：补全数据
        //包括：注册IP,登录IP,头像,创建时间,更新时间
        String ipAddress = request.getRemoteAddr();
        user.setRegIp(ipAddress);
        user.setLoginIp(ipAddress);
        user.setUpdateTime(new Date());
        user.setCreateTime(new Date());
        user.setAvatar(Constants.User.DEFAULT_AVATAR);
        user.setState(true);
        //保存到数据库中
        userDAO.save(user);
        //设置成普通用户角色
        User userFromDb = userDAO.findOneByUserName(userName);
        AdminUserRole userRole = new AdminUserRole();
        userRole.setRid(3);
        userRole.setUid(userFromDb.getId());
        adminUserRoleService.addUserRole(userRole);
        //返回结果
        return ResultFactory.buildSuccessResult("注册成功");
    }


    @Autowired
    private TaskService taskService;

    /**
     * 发送验证码
     * 发送邮箱email
     * 使用场景： 注册、找回密码、修改邮箱(会输入新的邮箱)
     * 注册(register)：已经注册过，提示已被注册
     * 找回密码(forget)：如果没有注册过，提示没有注册
     * 修改邮箱(update)：新的邮箱地址--如果已经注册，提示被注册     *
     * @param request
     * @param emailAddress
     * @return
     */
    @Override
    public Result sendEmail(String type,HttpServletRequest request, String emailAddress) {
        if (emailAddress == null) {
            return ResultFactory.buildFailResult("邮箱地址不能为空.");
        }
        //根据类型，查询邮箱是否存在
        if("register".equals(type) || "update".equals(type)){

            User userByEmail = userDAO.findOneByEmail(emailAddress);
            if (userByEmail != null) {
                return ResultFactory.buildFailResult("该邮箱已被注册.");
            }
        }else if("forget".equals(type)){
            User userByEmail = userDAO.findOneByEmail(emailAddress);
            if (userByEmail == null) {
                return ResultFactory.buildFailResult("该邮箱未注册.");
            }
        }

        //1.防止暴力发送,同一个邮箱，间隔要超过30秒，同一个ip，最多只能发送10次
        String remoteAddr  = request.getRemoteAddr();
        if(remoteAddr != null){
            remoteAddr = remoteAddr.replaceAll(":","_");
        }
        log.info("sendEmail == > ip ===> "+ remoteAddr);
        //从redis中取出来，如果没有，就过了
        Integer ipSendTime =  (Integer) redisUtils.get(Constants.User.KEY_EMAIL_SEND_IP + remoteAddr);
        if(ipSendTime != null && ipSendTime > 10){
            return ResultFactory.buildFailResult("您发送验证码也太频繁了吧！");
        }
        Object hasEmailSend =  redisUtils.get(Constants.User.KEY_EMAIL_SEND_ADDRESS + emailAddress);
        if(hasEmailSend != null){
            return ResultFactory.buildFailResult("您发送验证码也太频繁了吧！");
        }

        //2.检查邮箱地址是否正确
        boolean isEmailFormatOk =  TextUtils.isEmailAddressOk(emailAddress);
        if (!isEmailFormatOk) {
            return ResultFactory.buildFailResult("邮箱地址格式不正确！");
        }

        //0~999999
        int code = random.nextInt(999999);
        if(code < 10000){
            code += 10000;
        }
        log.info("sendEmail == > code == >"+code);
        //3.发送验证码
        try{
            taskService.sendEmailVerifyCode(String.valueOf(code),emailAddress);
        }catch (Exception e){
            return ResultFactory.buildFailResult("验证码发送失败，请稍后重试.");
        }
        //4.做记录
        //发送记录: code
        redisUtils.set(Constants.User.KEY_EMAIL_SEND_IP + remoteAddr,ipSendTime,60 * 60);
        redisUtils.set(Constants.User.KEY_EMAIL_SEND_ADDRESS + emailAddress,true,30);
        //保存code 10分钟内有效
        redisUtils.set(Constants.User.KEY_EMAIL_CODE_CONTENT+ emailAddress,String.valueOf(code),60 * 10);
        return ResultFactory.buildSuccessResult("验证码发送成功.");
    }

    @Override
    public Result deleteUserById(int userId, HttpServletRequest request, HttpServletResponse response) {

        int result = userDAO.deleteUserByState(userId);
        if (result > 0) {
            return ResultFactory.buildSuccessResult("删除成功");
        }
        return ResultFactory.buildFailResult("用户不存在");
    }

    /**
     * 检查用户名是否已被注册
     * @param userName
     * @return
     */
    @Override
    public Result checkUserName(String userName) {
        User user = userDAO.findOneByUserName(userName);
        return user == null ? ResultFactory.buildFailResult("用户名未注册") : ResultFactory.buildSuccessResult("用户名已被注册");
    }

    /**
     * 登录
     * @param captcha
     * @param captchaKey
     * @param user
     * @param request
     * @param response
     * @return
     */
    @Override
    public Result doLogin(String captcha, String captchaKey, User user, HttpServletRequest request, HttpServletResponse response) {

        //检查验证码正不正确
        String captchaValue = (String) redisUtils.get(Constants.User.KEY_CAPTCHA_CONTENT + captchaKey);
        if (!captcha.equals(captchaValue)) {
            return ResultFactory.buildFailResult("验证码不正确");
        }

        if (TextUtils.isEmpty(user.getUserName())){
            return ResultFactory.buildFailResult("账号不可以为空.");
        }
        String password = user.getPassword();
        if (TextUtils.isEmpty(password)) {
            return ResultFactory.buildFailResult("密码不可以为空.");
        }
        //执行登录
        String userName = user.getUserName();
        Subject subject = SecurityUtils.getSubject();
        UsernamePasswordToken usernamePasswordToken = new UsernamePasswordToken(userName, user.getPassword());
        usernamePasswordToken.setRememberMe(true);
        try {
            subject.login(usernamePasswordToken);
            log.info("doLogin == success == userName == > " + userName);
            return ResultFactory.buildSuccessResult(userName);
        } catch (Exception e) {
            String message = "账号密码错误";
            return ResultFactory.buildFailResult(message);
        }
    }

    @Override
    public User getByUserName(String username) {
        return userDAO.findOneByUserName(username);
    }

    /**
     * 更新密码
     * @param user
     * @return
     */
    @Override
    public Result updatePassword(User user) {
        //检查邮箱是否有填写
        String email = user.getEmail();
        if (TextUtils.isEmpty(email)) {
            return ResultFactory.buildFailResult("邮箱不可以为空.");
        }

        //对密码加密
        log.info("password == > "+ user.getPassword());
        String password = user.getPassword();
        // 生成盐,默认长度 16 位
        String salt = new SecureRandomNumberGenerator().nextBytes().toString();
        // 设置 hash 算法迭代次数
        int times = 2;
        // 得到 hash 后的密码
        String encodedPassword = new SimpleHash("md5", password, salt, times).toString();
        int result = userDAO.updatePasswordByEmail(encodedPassword, salt,email);
        //修改密码
        return result > 0 ? ResultFactory.buildSuccessResult("密码修改成功") : ResultFactory.buildFailResult("密码修改失败");
    }

    @Override
    public Result updateEmail(String email,String verifyCode,User user) {
        //对比验证码，确保新的邮箱地址是属于当前用户的
        String redisVerifyCode = (String) redisUtils.get(Constants.User.KEY_EMAIL_CODE_CONTENT + email);
        if (TextUtils.isEmpty(redisVerifyCode) || !redisVerifyCode.equals(verifyCode)) {
            return ResultFactory.buildFailResult("验证码错误");
        }
        //可以修改邮箱
        int result = userDAO.updateEmailById(email,user.getId());
        return result > 0 ? ResultFactory.buildSuccessResult("邮箱修改成功") : ResultFactory.buildFailResult("邮箱修改失败");
    }

    @Override
    public Result reSetPassword(int userId) {
        User userInDB = userDAO.findOneById(userId);
        String salt = new SecureRandomNumberGenerator().nextBytes().toString();
        int times = 2;
        String encodedPassword = new SimpleHash("md5", "123", salt, times).toString();
        userInDB.setPassword(encodedPassword);
        userInDB.setSalt(salt);
        try {
            userDAO.save(userInDB);
        } catch (IllegalArgumentException e) {
            return ResultFactory.buildFailResult("密码重置失败");
        }
        return ResultFactory.buildSuccessResult("密码已经重置为123");
    }

    @Override
    public Result checkEmailCode(String email, String emailCode) {
        //检查邮箱验证码
        String redisVerifyCode = (String) redisUtils.get(Constants.User.KEY_EMAIL_CODE_CONTENT + email);
        if(!emailCode.equals(redisVerifyCode)){
            return ResultFactory.buildFailResult("邮箱验证码不正确");
        }else{
            return ResultFactory.buildSuccessResult("验证码正确");
        }

    }

    @Override
    public Result changeUserState(int userId,boolean state) {
        User userInDB = userDAO.findOneById(userId);
        userInDB.setState(state);
        try {
            userDAO.save(userInDB);
        } catch (IllegalArgumentException e) {
            return ResultFactory.buildFailResult("状态更新失败");
        }
        return ResultFactory.buildSuccessResult("状态更新成功");
    }


}
