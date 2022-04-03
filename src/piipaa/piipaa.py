import importlib.metadata
import importlib.resources
import json
from typing import List, Union, no_type_check

from piipaa import __version__ as my_version


@no_type_check
def read_what():
    """My resources?"""
    with importlib.resources.path(__package__, 'data.json') as data_path:
        with open(data_path, 'rt', encoding='utf-8') as handle:
            return json.load(handle).get('what', 'Oh no!')


def what(argv: Union[List[str], None] = None) -> int:
    """Tell the what and then something else."""
    that = read_what()
    v = importlib.metadata.version(__package__)
    print(that, v, argv, my_version)
    return 0
