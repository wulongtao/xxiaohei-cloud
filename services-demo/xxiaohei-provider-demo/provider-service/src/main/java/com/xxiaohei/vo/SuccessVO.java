package com.xxiaohei.vo;

import lombok.AllArgsConstructor;
import lombok.Data;

/**
 * @author xxiaohei
 * @since 2023-07-23 13:56
 */
@Data
@AllArgsConstructor
public class SuccessVO {

    private Boolean success;

    private String msg;

}