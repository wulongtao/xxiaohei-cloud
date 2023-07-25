package sentinel;

import com.alibaba.csp.sentinel.Entry;
import com.alibaba.csp.sentinel.SphU;
import com.alibaba.csp.sentinel.slots.block.BlockException;
import com.alibaba.csp.sentinel.slots.block.RuleConstant;
import com.alibaba.csp.sentinel.slots.block.flow.FlowRule;
import com.alibaba.csp.sentinel.slots.block.flow.FlowRuleManager;

import java.util.ArrayList;
import java.util.List;

/**
 * Sentinel测试
 *
 * @author xxiaohei
 * @since 2023-07-22 13:36
 */
public class SentinelTest {

    public static void main(String[] args) {
        initFlowRules();
        while (true) {
            try (Entry entry = SphU.entry("TestQps")){
                System.out.println(System.currentTimeMillis() / 1000);
            } catch (BlockException e) {

            }
        }
    }

    private static void initFlowRules() {
        List<FlowRule> rules = new ArrayList<>();
        FlowRule rule = new FlowRule();
        //限流规则的作用对象
        rule.setResource("TestQps");
        //限流阈值类型：QPS模式或者线程数模式
        rule.setGrade(RuleConstant.FLOW_GRADE_QPS);
        //限流阈值
        rule.setCount(8);

        rules.add(rule);

        FlowRuleManager.loadRules(rules);

    }

}