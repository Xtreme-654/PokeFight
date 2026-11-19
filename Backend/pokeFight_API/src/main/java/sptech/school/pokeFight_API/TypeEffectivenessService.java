package sptech.school.pokeFight_API;

import org.springframework.stereotype.Service;
import java.text.Normalizer;
import java.util.*;

/** Regras de efetividade de golpes considerando os dois tipos do defensor. */
@Service
public class TypeEffectivenessService {
    private static final Map<String, Set<String>> WEAKNESSES = Map.ofEntries(
        Map.entry("NORMAL", Set.of("FIGHTING")),
        Map.entry("FIRE", Set.of("WATER", "GROUND", "ROCK")),
        Map.entry("WATER", Set.of("ELECTRIC", "GRASS")),
        Map.entry("ELECTRIC", Set.of("GROUND")),
        Map.entry("GRASS", Set.of("FIRE", "ICE", "POISON", "FLYING", "BUG")),
        Map.entry("ICE", Set.of("FIRE", "FIGHTING", "ROCK", "STEEL")),
        Map.entry("FIGHTING", Set.of("FLYING", "PSYCHIC", "FAIRY")),
        Map.entry("POISON", Set.of("GROUND", "PSYCHIC")),
        Map.entry("GROUND", Set.of("WATER", "GRASS", "ICE")),
        Map.entry("FLYING", Set.of("ELECTRIC", "ICE", "ROCK")),
        Map.entry("PSYCHIC", Set.of("BUG", "GHOST", "DARK")),
        Map.entry("BUG", Set.of("FIRE", "FLYING", "ROCK")),
        Map.entry("ROCK", Set.of("WATER", "GRASS", "FIGHTING", "GROUND", "STEEL")),
        Map.entry("GHOST", Set.of("GHOST", "DARK")),
        Map.entry("DRAGON", Set.of("ICE", "DRAGON", "FAIRY")),
        Map.entry("STEEL", Set.of("FIRE", "FIGHTING", "GROUND")),
        Map.entry("DARK", Set.of("FIGHTING", "BUG", "FAIRY")),
        Map.entry("FAIRY", Set.of("POISON", "STEEL"))
    );
    private static final Map<String, Set<String>> IMMUNITIES = Map.of(
        "NORMAL", Set.of("GHOST"), "GROUND", Set.of("ELECTRIC"),
        "FLYING", Set.of("GROUND"), "GHOST", Set.of("NORMAL", "FIGHTING"),
        "DARK", Set.of("PSYCHIC"), "STEEL", Set.of("POISON"), "FAIRY", Set.of("DRAGON")
    );
    // Resistências padrão da tabela moderna; o pedido não listou resistências individualmente.
    private static final Map<String, Set<String>> RESISTANCES = Map.ofEntries(
        Map.entry("NORMAL", Set.of()),
        Map.entry("FIRE", Set.of("FIRE", "GRASS", "ICE", "BUG", "STEEL", "FAIRY")),
        Map.entry("WATER", Set.of("FIRE", "WATER", "ICE", "STEEL")),
        Map.entry("ELECTRIC", Set.of("ELECTRIC", "FLYING", "STEEL")),
        Map.entry("GRASS", Set.of("WATER", "ELECTRIC", "GRASS", "GROUND")),
        Map.entry("ICE", Set.of("ICE")),
        Map.entry("FIGHTING", Set.of("BUG", "ROCK", "DARK")),
        Map.entry("POISON", Set.of("GRASS", "FIGHTING", "POISON", "BUG", "FAIRY")),
        Map.entry("GROUND", Set.of("POISON", "ROCK")),
        Map.entry("FLYING", Set.of("GRASS", "FIGHTING", "BUG")),
        Map.entry("PSYCHIC", Set.of("FIGHTING", "PSYCHIC")),
        Map.entry("BUG", Set.of("GRASS", "FIGHTING", "GROUND")),
        Map.entry("ROCK", Set.of("NORMAL", "FIRE", "POISON", "FLYING")),
        Map.entry("GHOST", Set.of("POISON", "BUG")),
        Map.entry("DRAGON", Set.of("FIRE", "WATER", "ELECTRIC", "GRASS")),
        Map.entry("STEEL", Set.of("NORMAL", "GRASS", "ICE", "FLYING", "PSYCHIC", "BUG", "ROCK", "DRAGON", "STEEL", "FAIRY")),
        Map.entry("DARK", Set.of("GHOST", "DARK")),
        Map.entry("FAIRY", Set.of("FIGHTING", "BUG", "DARK"))
    );

    public record Result(double multiplier, boolean immune, int weaknesses, int resistances) {}

    public Result calculate(String attackType, String primaryType, String secondaryType) {
        String attack = normalize(attackType);
        List<String> defenses = new ArrayList<>();
        if (primaryType != null && !primaryType.isBlank()) defenses.add(normalize(primaryType));
        if (secondaryType != null && !secondaryType.isBlank() && !normalize(secondaryType).equals(normalize(primaryType))) defenses.add(normalize(secondaryType));
        if (defenses.stream().anyMatch(type -> IMMUNITIES.getOrDefault(type, Set.of()).contains(attack)))
            return new Result(0.0, true, 0, 0);

        int weak = 0, resist = 0;
        for (String defense : defenses) {
            if (WEAKNESSES.getOrDefault(defense, Set.of()).contains(attack)) weak++;
            else if (RESISTANCES.getOrDefault(defense, Set.of()).contains(attack)) resist++;
        }
        // Fraquezas são somadas como multiplicadores 2x por tipo vulnerável:
        // uma fraqueza = 2x; duas fraquezas = 2x + 2x = 4x.
        // Sem fraquezas, cada resistência reduz pela metade; imunidade já foi tratada acima.
        double multiplier = weak > 0
            ? Math.max(0.0, (2.0 * weak) - (0.5 * resist))
            : Math.pow(0.5, resist);
        return new Result(multiplier, false, weak, resist);
    }

    public static String normalize(String value) {
        if (value == null) return "";
        String normalized = Normalizer.normalize(value.trim(), Normalizer.Form.NFD)
            .replaceAll("\\p{M}", "").toUpperCase(Locale.ROOT);
        return switch (normalized) {
            case "FOGO" -> "FIRE"; case "AGUA" -> "WATER"; case "ELETRICO" -> "ELECTRIC";
            case "PLANTA" -> "GRASS"; case "GELO" -> "ICE"; case "LUTADOR" -> "FIGHTING";
            case "VENENOSO" -> "POISON"; case "TERRESTRE" -> "GROUND"; case "VOADOR" -> "FLYING";
            case "PSIQUICO" -> "PSYCHIC"; case "INSETO" -> "BUG"; case "PEDRA" -> "ROCK";
            case "FANTASMA" -> "GHOST"; case "DRAGAO" -> "DRAGON"; case "ACO" -> "STEEL";
            case "SOMBRIO" -> "DARK"; case "FADA" -> "FAIRY"; default -> normalized;
        };
    }
}
