package fernandooliveira.ecommerce.security;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.filter.GenericFilterBean;


/** Filtra todas as requisição para autenticar */
public class JwtApiAuthenticatorFilter extends GenericFilterBean {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        try {

        /** Estabelece a autenticao do usuario */
            Authentication authentication = new JWTTokenAuthenticationService()
                    .getAuthentication((HttpServletRequest) request, (HttpServletResponse) response);

        /** Adiciona o precesso de autenticação para o spring secutiry */
            SecurityContextHolder.getContext().setAuthentication(authentication);

            chain.doFilter(request, response);

        }catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Ocorreu um erro no sistema, avise o administrador: \n" + e.getMessage());
        }
    }
}
