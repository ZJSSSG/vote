package xyz.oahoushs.vote.controller.user;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import xyz.oahoushs.vote.pojo.Candidate;
import xyz.oahoushs.vote.result.Result;
import xyz.oahoushs.vote.result.ResultFactory;
import xyz.oahoushs.vote.service.ICandidateService;
import xyz.oahoushs.vote.utils.StringUtils;

import java.io.File;
import java.io.IOException;

@Slf4j
@RestController
@RequestMapping("/api")
public class CandidateController {


    @Autowired
    ICandidateService candidateService;
    @PostMapping("/admin/candidate")
    public Result addACandidate(@RequestBody Candidate candidate){
        return candidateService.addCandidate(candidate);
    }

    @DeleteMapping("/admin/candidate/{candidateId}")
    public Result deleteCandidate(@PathVariable("candidateId") String  candidateId){
        return candidateService.deleteCandidate(candidateId);
    }

    @PutMapping("/admin/candidate/state/{candidateId}")
    public Result updateState(@PathVariable("candidateId") String  candidateId,@RequestParam("state") boolean state){
        return candidateService.updateState(candidateId,state);
    }

    @GetMapping("/candidate/{candidateId}")
    public Result getCandidate(@PathVariable("candidateId") String  candidateId){
        return candidateService.getCandidate(candidateId);
    }

    /**
     * 候选人编辑
     * 根据活动分页列出候选人   == > 获取全部候选人（接口前要加admin）
     * @param page
     * @param size
     * @return
     */
    @GetMapping("/admin/candidate/list/{activityId}")
    public Result listCandidate(@PathVariable("activityId")String activityId,
                                @RequestParam("page")int page,
                                @RequestParam("size")int size){
        return candidateService.listCandidate(activityId,page,size);
    }
    /**
     * 根据活动列出状态正常的候选人 === > (接口前面不用加/admin)
     * @return
     */
    @GetMapping("/candidate/list/all/{activityId}")
    public Result listAllNormalCandidate(@PathVariable("activityId")String activityId){
        return candidateService.listAllNormalCandidate(activityId);
    }

    /**
     * 根据活动分页列出状态正常的候选人  === > (接口前面不用加/admin)
     * @param page
     * @param size
     * @return
     */
    @GetMapping("/candidate/list/{activityId}")
    public Result listNormalCandidate(@PathVariable("activityId")String activityId,
                                @RequestParam("page")int page,
                                @RequestParam("size")int size){
        return candidateService.listNormalCandidate(activityId,page,size);
    }

    /**
     * 排序列出
     * @param activityId
     * @return
     */
    @GetMapping("/candidate/list/sequence/{activityId}")
    public Result listNormalCandidate(@PathVariable("activityId")String activityId){
        return candidateService.listRankCandidate(activityId);
    }
    /**
     * 分页列出状态正常的候选人
     * @param candidateId
     * @param candidate
     * @return
     */
    @PutMapping("/admin/candidate/{candidateId}")
    public Result updateCandidate(@PathVariable("candidateId") String  candidateId,@RequestBody Candidate candidate){
        return candidateService.updateCandidate(candidateId,candidate);
    }


    @DeleteMapping("/batch")
    public Result multipleRemove(@RequestParam String selectedCandidateIds){
        System.out.println(selectedCandidateIds);
        String[] cids =  selectedCandidateIds.split(" ");
        try {
            for(String cid : cids){
                candidateService.deleteCandidate(cid);
            }
        }catch (Exception e){
            e.printStackTrace();
            String message = "删除失败";
            return ResultFactory.buildFailResult(message);
        }
        return ResultFactory.buildSuccessResult("删除成功");
    }


    @Value("${image.save-path}")
    private String imagePath;

    @PostMapping("/admin/candidate/covers")
    public String coversUpload(MultipartFile file) throws Exception {
        String folder = imagePath;
        File imageFolder = new File(folder);
        File f = new File(imageFolder, StringUtils.getRandomString(6) + file.getOriginalFilename()
                .substring(file.getOriginalFilename().length() - 4));
        if (!f.getParentFile().exists())
            f.getParentFile().mkdirs();

        try {
            file.transferTo(f);
            String imgURL = "http://localhost:8443/api/file/" + f.getName();
            return imgURL;
        } catch (IOException e) {
            e.printStackTrace();
            return "";
        }
    }
}
