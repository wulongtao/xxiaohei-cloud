package com.xxiaohei.service.impl;

import com.alibaba.csp.sentinel.annotation.SentinelResource;
import com.alibaba.csp.sentinel.slots.block.BlockException;
import com.xxiaohei.service.SentinelTestService;
import com.xxiaohei.vo.SuccessVO;
import org.springframework.stereotype.Service;

/**
 * @author xxiaohei
 * @since 2023-07-23 11:13
 */
@Service
public class SentinelTestServiceImpl implements SentinelTestService {

    public SuccessVO flowBlockHandler(BlockException e){
        return new SuccessVO(false, "流控");
    }

    public SuccessVO fallbackHandler(Throwable ex){
        return new SuccessVO(false, "熔断");
    }

    @SentinelResource(value = "testSentinelFallback", fallback = "fallbackHandler")
    @Override
    public SuccessVO testSentinelFallback() {
        try {
            Thread.sleep(500L);
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
        return new SuccessVO(true, "xxx");
    }

    @SentinelResource(value = "testSentinelBlock", blockHandler = "flowBlockHandler")
    @Override
    public SuccessVO testSentinelBlock() {
        return new SuccessVO(true, "xxx");
    }
}