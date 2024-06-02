"""Put module description here."""

import pandas as pd


def function1(list_numbers):
    return sum(list_numbers)


def function2(df: pd.DataFrame, groupby_col: str) -> pd.DataFrame:
    return df.groupby(groupby_col).min()
