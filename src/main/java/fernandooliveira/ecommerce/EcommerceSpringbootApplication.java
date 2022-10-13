package fernandooliveira.ecommerce;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.transaction.annotation.EnableTransactionManagement;

/**
 * Created by fernandoOliveira.
 */
@SpringBootApplication
@EntityScan(basePackages = "fernandooliveira.ecommerce.model")
@EnableJpaRepositories(basePackages = {"fernandooliveira.ecommerce.repository"})
@EnableTransactionManagement
public class EcommerceSpringbootApplication {
	public static void main(String[] args) {


		System.out.println(new BCryptPasswordEncoder().encode("197197"));

		SpringApplication.run(EcommerceSpringbootApplication.class, args);
	}

}
