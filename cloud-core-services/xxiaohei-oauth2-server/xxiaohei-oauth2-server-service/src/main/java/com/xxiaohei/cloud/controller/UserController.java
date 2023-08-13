package com.xxiaohei.cloud.controller;

import com.xxiaohei.cloud.database.entity.SysUserDO;
import com.xxiaohei.cloud.database.mapper.SysUserMapper;
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

    private final SysUserMapper sysUserMapper;

    @RequestMapping("/list")
    public List<SysUserDO> testMybatisFlex() {
        return sysUserMapper.selectAll();
    }

}