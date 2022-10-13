package fernandooliveira.ecommerce.enums;

public enum TipoSexo {

    MASCULINO("masculino"),
    FEMININO("feminino");

    private String descricao;


    private TipoSexo(String descricao) {
        this.descricao = descricao;
    }


    public String getDescricao() {
        return descricao;
    }

    @Override
    public String toString() {
        return this.descricao;
    }

}
