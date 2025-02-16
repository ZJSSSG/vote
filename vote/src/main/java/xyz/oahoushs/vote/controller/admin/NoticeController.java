package xyz.oahoushs.vote.controller.admin;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import xyz.oahoushs.vote.pojo.Notice;
import xyz.oahoushs.vote.result.Result;
import xyz.oahoushs.vote.service.INoticeService;

@Slf4j
@RestController
@RequestMapping("/api")
public class NoticeController {

    @Autowired
    INoticeService noticeService;

    @PostMapping("/admin/notice")
    public Result addNotice(@RequestBody Notice notice){
        return noticeService.addNotice(notice);
    }

    @DeleteMapping("/admin/notice/{noticeId}")
    public Result deleteNotice(@PathVariable("noticeId") String  noticeId){
        return noticeService.deleteNotice(noticeId);
    }

    @GetMapping("/notice/{noticeId}")
    public Result getNotice(@PathVariable("noticeId") String  noticeId){
        return noticeService.getNotice(noticeId);
    }

    @GetMapping("/notice/list")
    public Result listNotice(@RequestParam("page")int page,@RequestParam("size")int size){
        return noticeService.listNotice(page,size);
    }

    @PutMapping("/admin/notice/{noticeId}")
    public Result updateNotice(@PathVariable("noticeId") String  noticeId,Notice notice){
        return noticeService.updateNotice(noticeId,notice);
    }
}
