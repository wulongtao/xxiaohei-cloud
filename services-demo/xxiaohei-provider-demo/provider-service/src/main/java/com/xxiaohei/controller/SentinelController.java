package com.xxiaohei.controller;

import com.xxiaohei.service.SentinelTestService;
import com.xxiaohei.vo.SuccessVO;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author xxiaohei
 * @since 2023-07-23 13:42
 */
@RestController
@RequestMapping("/sentinel")
@RequiredArgsConstructor
public class SentinelController {

    private final SentinelTestService sentinelTestService;

    @RequestMapping("/testSentinelFallback")
    public SuccessVO testSentinel() {
        return sentinelTestService.testSentinelFallback();
    }

    @RequestMapping("/testSentinelBlock")
    public SuccessVO testSentinelBlock() {
        return sentinelTestService.testSentinelBlock();
    }


}