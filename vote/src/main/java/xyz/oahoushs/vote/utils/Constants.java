package xyz.oahoushs.vote.utils;

import xyz.oahoushs.vote.pojo.VoteRecord;

public interface Constants {

    int DEFAULT_SIZE = 30;

    interface User{
        String ROLE_ADMIN = "role_admin";
        String ROLE_NORMAL = "role_normal";
        String DEFAULT_AVATAR = "https://s1.ax1x.com/2020/09/10/wGlRa9.png";
        String DEFAULT_STATE = "1";
        String KEY_CAPTCHA_CONTENT = "key_captcha_content_";
        String KEY_EMAIL_CODE_CONTENT = "key_email_code_content_";
        String KEY_EMAIL_SEND_IP = "key_email_send_ip_";
        String KEY_EMAIL_SEND_ADDRESS = "key_email_send_address_";
        String KEY_TOKEN = "key_token_";
        String COOKIE_TOKEN_KEY = "SOB_BLOG_TOKEN";
    }

    interface Settings{
        String MANAGER_ACCOUNT_INIT_STATE = "manager_account_init_state";
    }

    interface Page{
        int DEFAULT_PAGE = 1;
        int DEFAULT_SIZE = 4;
        int MIN_SIZE =  10;
    }


    /**
     * 单位毫秒
     */
    interface TimeValueInMillions{
        long MIN = 60 * 1000;
        long HOUR = 60 * MIN;
        long HOUR_2 = 60 * MIN * 2;
        long DAY = 24 * HOUR;
        long WEEK = 7 * DAY;
        long MONTH = 30 * DAY;
    }
    /**
     * 单位是秒
     */
    interface TimeValueInSecond{
        int MIN = 60;
        int HOUR = 60 * MIN;
        int HOUR_2 = 60 * MIN * 2;
        int DAY = 24 * HOUR;
        int WEEK = 7 * DAY;
        int MONTH = 30 * DAY;
    }


    interface VoteRecord{

    }



}
