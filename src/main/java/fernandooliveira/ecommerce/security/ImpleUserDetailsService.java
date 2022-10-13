package fernandooliveira.ecommerce.security;

import fernandooliveira.ecommerce.model.Usuario;
import fernandooliveira.ecommerce.repository.UsuarioRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
@Service
@RequiredArgsConstructor
public class ImpleUserDetailsService implements UserDetailsService {


    private final UsuarioRepository usuarioRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

        Usuario usuario = usuarioRepository.findUserByLogin(username); /** Recebe o login para consulta*/

        if (usuario == null){
            throw new UsernameNotFoundException("Usuário não foi encontrado: ");
        }
        return new User(usuario.getLogin(), usuario.getPassword(), usuario.getAuthorities());
    }
}
