package com.xxiaohei.service;

import com.xxiaohei.vo.SuccessVO;

/**
 * @author xxiaohei
 * @since 2023-07-23 11:12
 */
public interface SentinelTestService {

    SuccessVO testSentinelFallback();

    SuccessVO testSentinelBlock();

}
