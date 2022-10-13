package fernandooliveira.ecommerce.security;

import fernandooliveira.ecommerce.config.ApplicationContextLoad;
import fernandooliveira.ecommerce.model.Usuario;
import fernandooliveira.ecommerce.repository.UsuarioRepository;
import fernandooliveira.ecommerce.util.ConstantUtils;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.SignatureException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;

/**
 * Cria a autenticacao e retorna também a autorizacao JWT
 */
@Service
@Component
public class JWTTokenAuthenticationService {

  /*  private static final long EXPIRATION_TIME = 959990000;

    *//*Chave de senha para juntar com o JWT*//*
    private static final String SECRET = "ss/-*-*sds565dsd-s/d-s*dsds";

    private static final String TOKEN_PREFIX = "Bearer";

    private static final String HEADER_STRING = "Authorization";
*/

   private static final long EXPIRATION_TIME = ConstantUtils.EXPIRATION_TIME;
    private static final String TOKEN_PREFIX = ConstantUtils.TOKEN_PREFIX;
    private static final String HEADER_STRING = ConstantUtils.HEADER_STRING;
    private static final String SECRET = "1213213";

  /*  @Value("${jwt.secret}")
    private String SECRET;*/

    /**
     * Gera o token e da resposta para o cliente com o JWT
     */
    public void addAuthentication(HttpServletResponse response, String username) throws Exception {

        /** Monta o TOKEN */

        String JWT = Jwts.builder() /** Chama o gerador do token*/
                .setSubject(username) /** Add o usuario*/
                .setExpiration(new Date(System.currentTimeMillis() + EXPIRATION_TIME))/** Tempo de expiração do token*/
                .signWith(SignatureAlgorithm.HS512, SECRET).compact(); /** compacta o tempo de expiração, senha do JWT e o usuaria*/

        /** Monta o token*/
        String token = TOKEN_PREFIX + " " + JWT;

        /** Retorno para o cliente*/
        response.addHeader(HEADER_STRING, token);

        accessCors(response);

        /** Usado para teste no postman*/
        response.getWriter().write("{\"Authorization\": \"" + token + "\"}");
    }

    /**
     * Retorna o user validado com o token JWT
     */
    public Authentication getAuthentication(HttpServletRequest request, HttpServletResponse response) throws IOException {

        String token = request.getHeader(HEADER_STRING);

        try {
            if (token != null) {

                String tokenClear = token.replace(TOKEN_PREFIX, "").trim();

                /** Faz a validação do Tokem e do user*/
                String user = Jwts.parser().
                        setSigningKey(SECRET)
                        .parseClaimsJws(tokenClear)
                        .getBody().getSubject();

                if (user != null) {

                    Usuario usuario = ApplicationContextLoad.
                            getApplicationContext().
                            getBean(UsuarioRepository.class).findUserByLogin(user);

                    if (usuario != null) {
                        return new UsernamePasswordAuthenticationToken(
                                usuario.getLogin(),
                                usuario.getPassword(),
                                usuario.getAuthorities());
                    }

                }
            }

        } catch (SignatureException e) {
            response.getWriter().write("Token está inválido.");

        } catch (ExpiredJwtException e) {
            response.getWriter().write("Token está expirado, efetue o login novamente.");
        } finally {
            accessCors(response);
        }
        return null;
    }

    private void accessCors(HttpServletResponse response) {  /** validação do cors no navegador*/

        if (response.getHeader("Access-Control-Allow-Origin") == null) {
            response.addHeader("Access-Control-Allow-Origin", "*");
        }

        if (response.getHeader("Access-Control-Allow-Headers") == null) {
            response.addHeader("Access-Control-Allow-Headers", "*");
        }

        if (response.getHeader("Access-Control-Request-Headers") == null) {
            response.addHeader("Access-Control-Request-Headers", "*");
        }

        if (response.getHeader("Access-Control-Allow-Methods") == null) {
            response.addHeader("Access-Control-Allow-Methods", "*");
        }
    }
}
