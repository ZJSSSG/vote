package xyz.oahoushs.vote.result;

public enum ResultCode {

    SUCCESS(200),
    FAIL(400),
    UNAUTHORIZED(401),
    ACCOUNT_NOT_LOGIN(402),
    NOT_FOUND(404),
    INTERNAL_SERVER_ERROR(500);


    public int code;
    ResultCode(int code){
        this.code = code;
    }

}
