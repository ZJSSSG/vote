package xyz.oahoushs.vote.service.impl;

import com.sun.org.apache.bcel.internal.generic.ARETURN;
import xyz.oahoushs.vote.utils.Constants;

public class BaseService {

    int checkPage(int page){
        if (page < Constants.Page.DEFAULT_PAGE) {
            page = Constants.Page.DEFAULT_PAGE;
        }

        return page;
    }

    int checkSize(int size){
        if (size < Constants.Page.DEFAULT_SIZE) {
            size = Constants.Page.DEFAULT_SIZE;
        }
        return size;
    }

}
