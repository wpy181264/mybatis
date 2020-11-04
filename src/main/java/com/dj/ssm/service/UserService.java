package com.dj.ssm.service;


import com.baomidou.mybatisplus.extension.service.IService;
import com.dj.ssm.pojo.User;

public interface UserService extends IService<User> {

    User getByNameAndPwd(User user) throws Exception;

}
