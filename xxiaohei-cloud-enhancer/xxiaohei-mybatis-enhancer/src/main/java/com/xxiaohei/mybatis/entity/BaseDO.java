package com.xxiaohei.mybatis.entity;

import com.mybatisflex.annotation.Column;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 数据库基础父类
 *
 * @author xxiaohei
 * @since 2023-08-08 21:20
 */
@Data
public class BaseDO {

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