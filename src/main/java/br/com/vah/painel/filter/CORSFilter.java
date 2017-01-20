package br.com.vah.painel.filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.container.ContainerResponseContext;
import javax.ws.rs.container.ContainerResponseFilter;
import java.io.IOException;

/**
 * Created by Jairoportela on 29/12/2016.
 */
public class CORSFilter implements Filter {

  public CORSFilter() {
  }

  public void init(FilterConfig fConfig) throws ServletException {
  }

  public void destroy() {
  }

  public void doFilter(
      ServletRequest request, ServletResponse response,
      FilterChain chain) throws IOException, ServletException {

    ((HttpServletResponse) response).addHeader(
        "Access-Control-Allow-Origin", "*"
    );
    chain.doFilter(request, response);
  }
}
