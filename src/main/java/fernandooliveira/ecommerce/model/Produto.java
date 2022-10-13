package fernandooliveira.ecommerce.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "produto")
@SequenceGenerator(name = "seq_produto", sequenceName = "seq_produto", allocationSize = 1, initialValue = 1)
public class Produto implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_produto")
	private Long id;

	@Column(nullable = false, length = 20)
	private String tipoUnidade;

	@Column(nullable = false, length = 60)
	private String nome;

	@Column(nullable = false)
	private Boolean ativo = Boolean.TRUE;

	@Column(columnDefinition = "text", length = 2000, nullable = false)
	private String descricao;

	/** Nota item nota produto - ASSOCIAR **/

	@Column(nullable = false)
	private Double peso; /* 1000.55 G */

	@Column(nullable = false)
	private Double largura;

	@Column(nullable = false)
	private Double altura;

	@Column(nullable = false)
	private Double profundidade;

	@Column(nullable = false)
	private BigDecimal valorVenda = BigDecimal.ZERO;

	@Column(nullable = false)
	private Integer QtdEstoque = 0;

	private Integer QtdeAlertaEstoque = 0;

	private String linkYoutube;

	private Boolean alertaQtdeEstoque = Boolean.FALSE;

	private Integer qtdeClique = 0;
}
