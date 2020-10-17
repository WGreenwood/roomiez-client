
enum BillType {
  OneTime,
  Weekly,
  BiWeekly,
  Monthly,
  Quarterly,
  SemiAnually,
  Yearly,
}

final Map<int, BillType> billTypeMap = Map<int, BillType>.unmodifiable({
  1: BillType.OneTime,
  2: BillType.Weekly,
  3: BillType.BiWeekly,
  4: BillType.Monthly,
  5: BillType.Quarterly,
  6: BillType.SemiAnually,
  7: BillType.Yearly,
});
final Map<BillType, String> billTypeStrings = Map<BillType, String>.unmodifiable({
  BillType.OneTime: 'One Time',
  BillType.Weekly: 'Weekly',
  BillType.BiWeekly: 'Bi-Weekly',
  BillType.Monthly: 'Monthly',
  BillType.Quarterly: 'Quarterly',
  BillType.SemiAnually: 'Semi-Anually',
  BillType.Yearly: 'Yearly',
});
final Map<BillType, String> billTypeIdentifiers = Map<BillType, String>.unmodifiable({
  BillType.OneTime: 'O',
  BillType.Weekly: 'W',
  BillType.BiWeekly: 'BW',
  BillType.Monthly: 'M',
  BillType.Quarterly: 'Q',
  BillType.SemiAnually: 'SA',
  BillType.Yearly: 'Y',
});