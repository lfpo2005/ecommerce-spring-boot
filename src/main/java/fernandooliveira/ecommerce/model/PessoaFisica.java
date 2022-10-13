package fernandooliveira.ecommerce.model;

import fernandooliveira.ecommerce.enums.TipoSexo;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.Date;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "pessoa_fisica")
@PrimaryKeyJoinColumn(name = "id")
public class PessoaFisica extends Pessoa {

	private static final long serialVersionUID = 1L;

	@Column(nullable = false)
	private String cpf;

	@Temporal(TemporalType.DATE)
	private Date dataNascimento;

	@Column(nullable = false)
	@Enumerated(EnumType.STRING)
	private TipoSexo sexo;
}
