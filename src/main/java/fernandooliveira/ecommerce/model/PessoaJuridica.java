package fernandooliveira.ecommerce.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "pessoa_juridica")
@PrimaryKeyJoinColumn(name = "id")
public class PessoaJuridica extends Pessoa {

	private static final long serialVersionUID = 1L;

	@Column(nullable = false, length = 30)
	private String cnpj;

	@Column(nullable = false, length = 30)
	private String inscEstadual;

	@Column(length = 30)
	private String inscMunicipal;

	@Column(nullable = false, length = 150)
	private String nomeFantasia;

	@Column(nullable = false)
	private String razaoSocial;

}
