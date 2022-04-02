import pipa.cli as cli


def test_cli_main_empty(capsys):
    assert cli.main([]) == 0
    out, err = capsys.readouterr()
    assert not err
    assert 'pipa' in out


def test_cli_main_add_foo(capsys):
    assert cli.main(['foo']) == 0
    out, err = capsys.readouterr()
    assert not err
    assert 'pipa' in out and 'foo' in out
