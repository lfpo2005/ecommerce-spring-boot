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
@Table(name = "imagem_produto")
@SequenceGenerator(name = "seq_imagem_produto", sequenceName = "seq_imagem_produto", allocationSize = 1, initialValue = 1)
public class ImagemProduto implements Serializable {

	private static final long serialVersionUID = 1L;


	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_imagem_produto")
	private Long id;


	@Column(columnDefinition = "text", nullable = false)
	private String imagemOriginal;

	@Column(columnDefinition = "text", nullable = false)
	private String imagemMiniatura;

	@ManyToOne
	@JoinColumn(name = "produto_id", nullable = false,
			foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT, name = "produto_fk"))
	private Produto produto;


}
