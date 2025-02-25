package xyz.oahoushs.vote.controller.user;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import xyz.oahoushs.vote.pojo.Activity;
import xyz.oahoushs.vote.result.Result;
import xyz.oahoushs.vote.service.IActivityService;


@Slf4j
@RestController
@RequestMapping("/api")
public class ActivityController {


    @Autowired
    IActivityService activityService;

    @PostMapping("/admin/activity")
    public Result addActivity(@RequestBody Activity activity){
        return activityService.addActivity(activity);
    }

    @DeleteMapping("/admin/activity/{activityId}")
    public Result deleteActivity(@PathVariable("activityId") String  activityId){
        return activityService.deleteActivity(activityId);
    }

    @GetMapping("/activity/{activityId}")
    public Result getActivity(@PathVariable("activityId") String  activityId){
        return activityService.getActivity(activityId);
    }

    @GetMapping("/admin/activity/list")
    public Result listActivity(@RequestParam("page")int page,@RequestParam("size")int size){
        return activityService.listActivity(page,size);
    }

    @GetMapping("/activity/list/case")
    public Result listActivityByCase(@RequestParam("page")int page,
                                     @RequestParam("size")int size){
        return activityService.listActivityByCase(page,size);
    }


    @GetMapping("/admin/activity/list/self")
    public Result listActivityByUser(@RequestParam("userName") String userName,
                                     @RequestParam("page")int page,
                                     @RequestParam("size")int size){
        return activityService.listActivityByUser(userName,page,size);
    }
    @GetMapping("/admin/activity/list/canVote")
    public Result listActivityCanVote(@RequestParam("userName") String userName,
                                     @RequestParam("page")int page,
                                     @RequestParam("size")int size){
        return activityService.listActivityCanVote(userName,page,size);
    }



    @PutMapping("/admin/activity/{activityId}")
    public Result updateActivity(@PathVariable("activityId") String activityId,
                                 @RequestBody Activity activity){
        return activityService.updateActivity(activityId,activity);
    }
}
