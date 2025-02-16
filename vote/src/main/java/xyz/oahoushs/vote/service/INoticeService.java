package xyz.oahoushs.vote.service;

import xyz.oahoushs.vote.pojo.Notice;
import xyz.oahoushs.vote.result.Result;

public interface INoticeService {
    Result addNotice(Notice notice);

    Result updateNotice(String noticeId, Notice notice);

    Result listNotice(int page, int size);

    Result deleteNotice(String noticeId);

    Result getNotice(String noticeId);
}
