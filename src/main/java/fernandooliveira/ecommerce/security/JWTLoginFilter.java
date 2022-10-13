package fernandooliveira.ecommerce.security;


import com.fasterxml.jackson.databind.ObjectMapper;
import fernandooliveira.ecommerce.model.Usuario;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AbstractAuthenticationProcessingFilter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class JWTLoginFilter extends AbstractAuthenticationProcessingFilter {

    /** Configura o gerenciador de autenticação*/
    public JWTLoginFilter(String url, AuthenticationManager authenticationManager) {

        /** Autentica  a url*/
        super(new AntPathRequestMatcher(url));

        /** Gerenciador de autenticao*/
        setAuthenticationManager(authenticationManager);

    }


    @Override /** Retorna o usuer ao processo de autenticação*/
    public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response)
            throws AuthenticationException, IOException, ServletException {

        /** Obtem o usuario*/
        Usuario usuario = new ObjectMapper().readValue(request.getInputStream(), Usuario.class);

        /** Retorna o usuario com o login e senha*/
        return getAuthenticationManager().
                authenticate(new UsernamePasswordAuthenticationToken(usuario.getLogin(), usuario.getPassword()));
    }

    @Override
    protected void successfulAuthentication(HttpServletRequest request, HttpServletResponse response, FilterChain chain,
                                            Authentication authResult) throws IOException, ServletException {

        try {
            new JWTTokenAuthenticationService().addAuthentication(response, authResult.getName());

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
