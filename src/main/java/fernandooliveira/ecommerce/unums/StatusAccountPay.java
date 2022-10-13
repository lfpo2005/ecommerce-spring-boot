package fernandooliveira.ecommerce.unums;

import lombok.AllArgsConstructor;

@AllArgsConstructor
public enum StatusAccountPay {

    CHARGE ("Charge"),
    EXPIRED ("Expired"),
    OPEN ("Open"),
    RENT ("Rent"),
    EMPLOYEE ("Employee"),
    RELEASED("Released"),
    NEGOTIATED("Negortiated");

    private String description;

}
