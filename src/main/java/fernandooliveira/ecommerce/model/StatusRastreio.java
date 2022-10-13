package fernandooliveira.ecommerce.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "status_rastreio")
@SequenceGenerator(name = "seq_status_rastreio", sequenceName = "seq_status_rastreio", allocationSize = 1, initialValue = 1)
public class StatusRastreio implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_status_rastreio")
	private Long id;

	@Column(length = 150)
	private String centroDistribuicao;

	@Column(length = 150)
	private String cidade;

	@Column(length = 15)
	private String estado;

	@Column(length = 30)
	private String status;

	@ManyToOne
	@JoinColumn(name = "venda_compra_loja_virt_id", nullable = false,
			foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT, name = "venda_compra_loja_virt_fk"))
	private VendaCompraLojaVirtual vendaCompraLojaVirtual;

}
