package com.tag;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

public class SumTag extends TagSupport{
	private static final long serialVersionUID = 1L;

	private int num;

	public void setNum(int num) {
		this.num = num;
	} 
	
	@Override
	public int doStartTag() throws JspException {
		JspWriter out = pageContext.getOut();
		
		try {
			int s = 0;
			for(int i=1; i<=num; i++) {
				s += i;
			}
			out.print(s);
		} catch (Exception e) {
			throw new JspException(e);
		}
		
		return SKIP_BODY;
	}
	
	
}
