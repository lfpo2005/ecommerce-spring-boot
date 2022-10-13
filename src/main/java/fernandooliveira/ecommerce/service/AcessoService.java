package fernandooliveira.ecommerce.service;

import fernandooliveira.ecommerce.model.Acesso;
import fernandooliveira.ecommerce.repository.AcessoRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.persistence.EntityExistsException;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class AcessoService {


    private final AcessoRepository acessoRepository;


    public Acesso save(Acesso acesso) {

        if (acessoRepository.existsByDescricao(acesso.getDescricao())) {
            throw new EntityExistsException(String.format("Descrição para o Role existente!"));
        } else {
            acessoRepository.save(acesso);
        }
        return acesso;
    }

    public void deleteById(Long accessId) {

        if (accessId != null && accessId.equals("")) {
            acessoRepository.deleteById(accessId);
        } else {
            throw new EntityExistsException(String.format("Description for the existing ROLE!"));
        }
    }

    public Optional<Acesso> findById(Long accessId) {

        if (accessId != null && accessId.equals("")) {
            return acessoRepository.findById(accessId);
        } else {
            throw new EntityExistsException(String.format("Description for the existing ROLE!"));
        }
    }

    public List<Acesso> buscarAcessoDesc(String description) {

        if (description != null && description.equals("")) {
            return acessoRepository.buscarAcessoDesc(description);
        } else {
            throw new EntityExistsException(String.format("Description not found!"));
        }
    }

}
