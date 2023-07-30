package com.xxiaohei.controller;

import com.xxiaohei.database.dao.UserDO;
import com.xxiaohei.database.mapper.UserMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * @author xxiaohei
 * @since 2023-07-30 10:32
 */
@RestController
@RequestMapping("/mybatis")
@RequiredArgsConstructor
public class MyBatisFlexController {

    private final UserMapper userMapper;

    @RequestMapping("/testMybatisFlex")
    public List<UserDO> testMybatisFlex() {
        return userMapper.selectAll();
    }

}