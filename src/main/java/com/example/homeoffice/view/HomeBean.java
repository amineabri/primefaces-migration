package com.example.homeoffice.view;

import com.example.homeoffice.model.InfoCard;

import java.io.Serializable;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Named;

@Named
@ApplicationScoped
public class HomeBean implements Serializable {

    private static final long serialVersionUID = 1L;

    private final List<InfoCard> cards = Collections.unmodifiableList(Arrays.asList(
            new InfoCard("Operational Overview", "Current internal service position.", "Stable"),
            new InfoCard("Employee Services", "Staff records available for review.", "8 records"),
            new InfoCard("Reporting", "Monthly governance packs prepared.", "4 reports")
    ));

    public List<InfoCard> getCards() {
        return cards;
    }
}
