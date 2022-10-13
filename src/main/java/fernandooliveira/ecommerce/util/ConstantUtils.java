package fernandooliveira.ecommerce.util;

public final class ConstantUtils {


    private ConstantUtils() {
        throw new IllegalStateException("Utility class");
    }

    /** TOKEN JWT*/
    public static  final long EXPIRATION_TIME = 3600000 * 720; /** validade do token 3600000 = 1 hora * 720 horas 30 dias*/
    public static final String TOKEN_PREFIX = "Bearer ";
    public static final String HEADER_STRING = "Authorization";

    
}
