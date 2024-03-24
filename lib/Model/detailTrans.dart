class InputContainer {
  String? selectedCategory;
  String? selectedJenis;
  String? selectedJenisHarga;
  int quantity;
  int amount;
  InputContainer(
      {this.selectedCategory,
      this.selectedJenis,
      this.quantity = 0,
      this.selectedJenisHarga,
      this.amount = 0});
}
