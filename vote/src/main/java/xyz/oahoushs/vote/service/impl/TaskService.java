package xyz.oahoushs.vote.service.impl;

import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import xyz.oahoushs.vote.utils.EmailSender;

@Service
public class TaskService {

    @Async
    public void sendEmailVerifyCode(String verifyCode,String emailAddress) throws Exception {
        EmailSender.sendRegisterVerifyCode(verifyCode,emailAddress );
    }
}
