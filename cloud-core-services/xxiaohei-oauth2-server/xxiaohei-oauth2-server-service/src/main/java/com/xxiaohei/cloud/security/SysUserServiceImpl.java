package com.xxiaohei.cloud.security;

import com.mybatisflex.core.query.QueryWrapper;
import com.xxiaohei.cloud.database.entity.SysRoleDO;
import com.xxiaohei.cloud.database.entity.SysUserDO;
import com.xxiaohei.cloud.database.entity.SysUserRoleDO;
import com.xxiaohei.cloud.database.mapper.SysRoleMapper;
import com.xxiaohei.cloud.database.mapper.SysUserMapper;
import com.xxiaohei.cloud.database.mapper.SysUserRoleMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.math.BigInteger;
import java.util.Collections;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

import static com.xxiaohei.cloud.database.entity.table.SysRoleTableDef.SYS_ROLE;
import static com.xxiaohei.cloud.database.entity.table.SysUserRoleTableDef.SYS_USER_ROLE;
import static com.xxiaohei.cloud.database.entity.table.SysUserTableDef.SYS_USER;

/**
 * UserDetailsService实现类
 *
 * @author xxiaohei
 * @since 2023-08-13 13:47
 */
@Service
@RequiredArgsConstructor
public class SysUserServiceImpl implements UserDetailsService {

    private final SysUserMapper sysUserMapper;

    private final SysUserRoleMapper sysUserRoleMapper;

    private final SysRoleMapper sysRoleMapper;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        SysUserDO sysUserDO = getSysUser(username);

        List<String> userRoleCodes = listUserRoleCodes(sysUserDO.getUserId());

        return SecurityUser.builder()
                .userId(sysUserDO.getUserId())
                .username(sysUserDO.getUserName())
                .password(sysUserDO.getPassword())
                .authorities(AuthorityUtils.createAuthorityList(userRoleCodes.toArray(new String[0])))
                .build();
    }

    private SysUserDO getSysUser(String username) {
        QueryWrapper queryWrapper = QueryWrapper.create()
                .select(SYS_USER.USER_ID, SYS_USER.USER_NAME, SYS_USER.PASSWORD)
                .where(SYS_USER.USER_NAME.eq(username));
        SysUserDO sysUserDO = sysUserMapper.selectOneByQuery(queryWrapper);

        if (Objects.isNull(sysUserDO)) {
            throw new UsernameNotFoundException("用户不存在！");
        }

        return sysUserDO;
    }

    private List<String> listUserRoleCodes(BigInteger userId) {
        QueryWrapper queryWrapper = QueryWrapper.create()
                .select(SYS_USER_ROLE.ROLE_ID)
                .where(SYS_USER_ROLE.USER_ID.eq(userId));

        List<BigInteger> userRoleIds = sysUserRoleMapper.selectListByQuery(queryWrapper)
                .stream().map(SysUserRoleDO::getRoleId).collect(Collectors.toList());

        if (CollectionUtils.isEmpty(userRoleIds)) {
            return Collections.emptyList();
        }

        queryWrapper = QueryWrapper.create()
                .select(SYS_ROLE.ROLE_CODE)
                .where(SYS_ROLE.ROLE_ID.in(userRoleIds));

        return sysRoleMapper.selectListByQuery(queryWrapper).stream()
                .map(SysRoleDO::getRoleCode).collect(Collectors.toList());
    }

}