package xyz.oahoushs.vote.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import xyz.oahoushs.vote.result.Result;
import xyz.oahoushs.vote.service.IUserService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Slf4j
@RestController
@RequestMapping("/api/admin")
public class TestAdminController {

    @Autowired
    IUserService userService;

    @GetMapping("/list-user")
    public Result listUsers(
            HttpServletRequest request,
            HttpServletResponse response,
            @RequestParam("page")int page,
            @RequestParam("size")int size){

        return userService.listUsers(request,response,page,size);
    }
}
