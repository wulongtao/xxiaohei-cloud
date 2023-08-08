package com.xxiaohei.cloud.controller;

import com.xxiaohei.cloud.database.entity.UserDO;
import com.xxiaohei.cloud.database.mapper.UserMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * 用户接口
 *
 * @author xxiaohei
 * @since 2023-08-08 21:51
 */
@RestController
@RequestMapping("/user")
@RequiredArgsConstructor
public class UserController {

    private final UserMapper userMapper;

    @RequestMapping("/list")
    public List<UserDO> testMybatisFlex() {
        return userMapper.selectAll();
    }

}