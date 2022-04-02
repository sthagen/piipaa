import importlib.metadata
import importlib.resources
import json
from typing import List, Union

from pipa import __version__ as my_version

def read_what():
    """My resources?"""
    with open(importlib.resources.path(__package__, 'data.json'), 'rt', encoding='utf-8') as handle:
        return json.load(handle).get('what', 'Oh no!')


def what(argv: Union[List[str], None] = None) -> int:
    """Tell the what and then something else."""
    that = read_what()
    v = importlib.metadata.version(__package__)
    print(that, v, argv, my_version)