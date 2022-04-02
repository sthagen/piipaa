import sys
from typing import List, Union

import piipaa.piipaa as pp


def main(argv: Union[List[str], None] = None) -> int:
    """Delegate processing to functional module."""
    argv = sys.argv[1:] if argv is None else argv
    return pp.what(argv)
