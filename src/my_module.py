"""Put module description here."""
from typing import List, Union


def function1(list_numbers: List[Union[int, float]]) -> Union[int, float]:
    """Sum a list of numbers.

    Args:
        list_numbers (List[int | float]): a list of numbers

    Returns:
        int | float: sum of the list of numbers
    """
    return sum(list_numbers)
