String maskCard(String card) {

  if (card.length < 4) return card;

  return "XXXX XXXX XXXX ${card.substring(card.length - 4)}";
}