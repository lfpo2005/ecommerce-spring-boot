package fernandooliveira.ecommerce.unums;

import lombok.AllArgsConstructor;

@AllArgsConstructor
public enum StatusAccountReceive {

    CHARGE ("Charge"),
    EXPIRED ("Expired"),
    OPEN ("Open"),
    RELEASED("Released");

    private String description;



}
