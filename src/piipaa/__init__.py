from importlib.metadata import PackageNotFoundError, version

VERSION_FALLBACK = '2022.4.1'
try:
    __version__ = version(__name__)
except PackageNotFoundError:
    # package is not installed
    # assign signal or sane value as a default
    __version__ = VERSION_FALLBACK
    pass
