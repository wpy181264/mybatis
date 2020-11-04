package com.dj.ssm.mapper;


import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dj.ssm.pojo.User;
import org.springframework.dao.DataAccessException;

public interface UserMapper extends BaseMapper<User> {

    User getByNameAndPwd(User user) throws DataAccessException;

}
