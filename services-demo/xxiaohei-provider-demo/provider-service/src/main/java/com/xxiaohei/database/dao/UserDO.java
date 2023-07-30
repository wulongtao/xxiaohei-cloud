package com.xxiaohei.database.dao;

import com.mybatisflex.annotation.Id;
import com.mybatisflex.annotation.Table;
import lombok.Data;

/**
 * 用户DO
 *
 * @author xxiaohei
 * @since 2023-07-30 10:23
 */
@Data
@Table("user")
public class UserDO {

    @Id
    private Long userId;

    private String userName;

}