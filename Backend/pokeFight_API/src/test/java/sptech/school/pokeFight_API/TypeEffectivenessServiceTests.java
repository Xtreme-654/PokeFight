package sptech.school.pokeFight_API;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class TypeEffectivenessServiceTests {
    private final TypeEffectivenessService service = new TypeEffectivenessService();

    @Test
    void immunityOverridesWeaknessOfSecondaryType() {
        var result = service.calculate("Ghost", "Normal", "Psychic");
        assertTrue(result.immune());
        assertEquals(0.0, result.multiplier());
    }

    @Test
    void doubleWeaknessAddsBothTwoTimesMultipliers() {
        var result = service.calculate("Water", "Fire", "Rock");
        assertEquals(2, result.weaknesses());
        assertEquals(4.0, result.multiplier());
    }

    @Test
    void singleWeaknessIsTwoTimes() {
        var result = service.calculate("Water", "Fire", null);
        assertEquals(2.0, result.multiplier());
    }

    @Test
    void singleResistanceHalvesDamage() {
        var result = service.calculate("Water", "Grass", null);
        assertEquals(0.5, result.multiplier());
    }
}
