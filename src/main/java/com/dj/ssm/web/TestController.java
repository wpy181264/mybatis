package com.dj.ssm.web;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.dj.ssm.pojo.ResultModel;
import com.dj.ssm.pojo.User;
import com.dj.ssm.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.*;

import java.util.List;


@Controller
@RequestMapping("/user")
public class TestController {

    @Autowired
    private UserService userService;

    @GetMapping
    public ResultModel get(User user) {
        try {
            User user1 = userService.getByNameAndPwd(user);
            if (user1 == null) {
                return new ResultModel().error("用户不存在");
            }
            String code = "200";
            return new ResultModel().success(code);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultModel().error(e.getMessage());
        }
    }

    @PostMapping
    public ResultModel save(User user) {
        try {
            return new ResultModel().success(userService.save(user));
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultModel().error(e.getMessage());
        }
    }

    @PutMapping
    public ResultModel update(User user) {
        try {
            return new ResultModel().success(userService.updateById(user));
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultModel().error(e.getMessage());
        }
    }

    @RequestMapping("list")
    public ResultModel list(Integer pageNo, User user, Integer[] userHobby) {
        try {

            // 分页插件的实现原理 SQL拦截器
            IPage<User> page = new Page<>(pageNo, 2);// 当前页,每页条数
            QueryWrapper<User> queryWrapper = new QueryWrapper<>();
            if (user.getUserName() != null) {
                queryWrapper.like("user_name", user.getUserName());
            }
            if (userHobby != null) {
                queryWrapper.in("user_hobby", userHobby);
            }
            if (user.getUserSex() != null) {
                queryWrapper.eq("user_sex", user.getUserSex());
            }
            // 无查询条件可以直接使用 .page(page);
            IPage<User> pageInfo = userService.page(page, queryWrapper);
            return new ResultModel().success(pageInfo);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultModel().error(e.getMessage());
        }
    }


    @DeleteMapping("/{id}")
    public ResultModel delete(@PathVariable Integer id) {
        try {
            return new ResultModel().success(userService.removeById(id));
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultModel().error(e.getMessage());
        }
    }


}
