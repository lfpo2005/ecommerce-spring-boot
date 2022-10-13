package fernandooliveira.ecommerce.model;

import fernandooliveira.ecommerce.enums.TipoEndereco;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "endereco")
@SequenceGenerator(name = "seq_endereco", sequenceName = "seq_endereco", allocationSize = 1, initialValue = 1)
public class Endereco implements Serializable {

    private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_endereco")
	private Long id;

	@Column(nullable = false, length = 60)
	private String ruaLogra;

	@Column(nullable = false, length = 15)
	private String cep;

	@Column(nullable = false, length = 10)
	private String numero;

	@Column(length = 50)
	private String complemento;

	@Column(nullable = false, length = 30)
	private String bairro;

	@Column(nullable = false, length = 30)
	private String uf;

	@Column(nullable = false, length = 50)
	private String cidade;

	@ManyToOne(targetEntity = Pessoa.class)
	@JoinColumn(name = "pessoa_id", nullable = false, foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT, name = "pessoa_fk"))
	private Pessoa pessoa;

	@Column(nullable = false)
	@Enumerated(EnumType.STRING)
	private TipoEndereco tipoEndereco;

}
