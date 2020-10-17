
DateTime cloneDateTime(DateTime dt)
  => DateTime(
    dt.year, dt.month, dt.day,
    dt.hour, dt.minute, dt.second,
    dt.millisecond, dt.microsecond,
  );