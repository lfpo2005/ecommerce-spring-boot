package fernandooliveira.ecommerce.controller;

import fernandooliveira.ecommerce.model.Acesso;
import fernandooliveira.ecommerce.service.AcessoService;
import fernandooliveira.ecommerce.util.ExceptionMentoriaJava;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequiredArgsConstructor
@CrossOrigin(origins = "*", maxAge = 3600)
@RequestMapping("/acesso")
@Controller
public class AcessoController {

    @Autowired
    private AcessoService acessoService;




    @ResponseBody /*Poder dar um retorno da API*/
    @PostMapping(value = "**/deleteAcesso") /*Mapeando a url para receber JSON*/ public ResponseEntity<?> deleteAcesso(@RequestBody Acesso acesso) { /*Recebe o JSON e converte pra Objeto*/

        acessoService.deleteById(acesso.getId());

        return new ResponseEntity("Acesso Removido", HttpStatus.OK);
    }

    @ResponseBody
    @DeleteMapping(value = "**/deleteAcessoPorId/{id}")
    public ResponseEntity<?> deleteAcessoPorId(@PathVariable("id") Long id) {

        acessoService.deleteById(id);

        return new ResponseEntity("Acesso Removido", HttpStatus.OK);
    }

    @ResponseBody
    @GetMapping(value = "**/obterAcesso/{id}")
    public ResponseEntity<Acesso> obterAcesso(@PathVariable("id") Long id) throws ExceptionMentoriaJava {

        Acesso acesso = acessoService.findById(id).orElse(null);

        if (acesso == null) {
            throw new ExceptionMentoriaJava("Não encontrou Acesso com código: " + id);
        }

        return new ResponseEntity<Acesso>(acesso, HttpStatus.OK);
    }

    @ResponseBody
    @GetMapping(value = "**/buscarPorDesc/{desc}")
    public ResponseEntity<List<Acesso>> buscarPorDesc(@PathVariable("desc") String desc) {

        List<Acesso> acesso = acessoService.buscarAcessoDesc(desc.toUpperCase());

        return new ResponseEntity<List<Acesso>>(acesso, HttpStatus.OK);
    }

    @ResponseBody
    @PostMapping(value = "**/salvarAcesso") /*Mapeando a url para receber JSON*/
    public ResponseEntity<Acesso> save(@RequestBody Acesso acesso) throws ExceptionMentoriaJava {

        if (acesso.getId() == null) {
            List<Acesso> acessos = acessoService.buscarAcessoDesc(acesso.getDescricao().toUpperCase());

            if (!acessos.isEmpty()) {
                throw new ExceptionMentoriaJava("Já existe Acesso com a descrição: " + acesso.getDescricao());
            }
        }

        Acesso acessoSalvo = acessoService.save(acesso);

        return new ResponseEntity<Acesso>(acessoSalvo, HttpStatus.OK);
    }
}


