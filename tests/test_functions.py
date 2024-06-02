"""This module is for testing functions in my_module."""

from cicd_template import my_module


def test_function1():
    list_numbers = [2, 3, 5]
    assert my_module.function1(list_numbers) == 10
