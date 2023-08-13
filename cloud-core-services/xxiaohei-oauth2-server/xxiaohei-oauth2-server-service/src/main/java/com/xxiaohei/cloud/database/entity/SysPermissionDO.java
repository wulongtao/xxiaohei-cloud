package com.xxiaohei.cloud.database.entity;

import com.mybatisflex.annotation.Column;
import com.mybatisflex.annotation.Id;
import com.mybatisflex.annotation.Table;
import com.xxiaohei.mybatis.entity.BaseDO;
import java.io.Serializable;
import java.math.BigInteger;
import java.time.LocalDateTime;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 权限表 实体类。
 *
 * @author xxiaohei
 * @since 2023-08-13
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table(value = "sys_permission")
public class SysPermissionDO extends BaseDO implements Serializable {

    /**
     * 权限表id
     */
    @Id
    private BigInteger permissionId;

    /**
     * 权限url
     */
    private String permissionUrl;

    /**
     * 角色名称
     */
    private String permissionName;

    /**
     * 是否删除：0-未删除 1-删除
     */
    @Column(isLogicDelete = true)
    private Integer isDeleted;

    /**
     * 创建事件
     */
    private LocalDateTime gmtCreate;

    /**
     * 修改时间
     */
    private LocalDateTime gmtModified;

}
