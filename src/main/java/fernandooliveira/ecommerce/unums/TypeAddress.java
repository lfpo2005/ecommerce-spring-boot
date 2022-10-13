package fernandooliveira.ecommerce.unums;

import lombok.AllArgsConstructor;

@AllArgsConstructor
public enum TypeAddress {

	CHARGE("Charge"),
	DELIVERY("Delivery");
	
	private String description;

}
