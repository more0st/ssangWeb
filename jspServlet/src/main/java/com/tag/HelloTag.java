package com.tag;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

public class HelloTag extends TagSupport {
	private static final long serialVersionUID = 1L;
	
	@Override
	public int doStartTag() throws JspException {
		JspWriter out = pageContext.getOut();
		
		try {
			out.print("<b>반가워요</b>");
			
		} catch (Exception e) {
			throw new JspException(e);
		}
		
		return SKIP_BODY;
	}

}
