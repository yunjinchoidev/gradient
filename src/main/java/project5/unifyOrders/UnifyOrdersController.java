package project5.unifyOrders;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UnifyOrdersController {
	
	@RequestMapping("/unifyOrders.do")
	public String unifyIndex() {
		return "unify/orders";
	}
	
}
