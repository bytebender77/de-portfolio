"""Placeholder so `pytest` has something to collect until projects add real tests."""


def test_python_version():
    import sys

    assert sys.version_info[:2] == (3, 11)
