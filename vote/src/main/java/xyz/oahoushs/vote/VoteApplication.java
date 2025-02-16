package xyz.oahoushs.vote;

import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import springfox.documentation.swagger2.annotations.EnableSwagger2;
import xyz.oahoushs.vote.utils.IdWorker;
import xyz.oahoushs.vote.utils.RedisUtils;

import java.util.Random;

@Slf4j
@EnableSwagger2
@SpringBootApplication
public class VoteApplication {

    public static void main(String[] args) {
        log.info("SpringBootApplication run...");
        SpringApplication.run(VoteApplication.class, args);
    }
    @Bean
    public Random createRandom(){
        return new Random();
    }

    @Bean
    public Gson createGson(){
        return new Gson();
    }
    @Bean
    public IdWorker createIdWorker(){
        return new IdWorker(0,0);
    }

    @Bean
    public RedisUtils createRedisUtil(){
        return new RedisUtils();
    }

}
