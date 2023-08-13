package com.xxiaohei.cloud.database.mapper;

import com.mybatisflex.core.BaseMapper;
import com.xxiaohei.cloud.database.entity.SysUserDO;
import org.apache.ibatis.annotations.Param;

/**
 * 用户表 映射层。
 *
 * @author xxiaohei
 * @since 2023-08-13
 */
public interface SysUserMapper extends BaseMapper<SysUserDO> {

    /**
    * 查询用户信息
    * @param username username
    * @return com.xxiaohei.cloud.database.entity.SysUserDO
    * @author xxiaohei
    * @since 2023/8/13
    */
    SysUserDO getByUsername(@Param("username") String username);
}
