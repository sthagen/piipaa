import piipaa.cli as cli


def test_cli_main_empty(capsys):
    assert cli.main([]) == 0
    out, err = capsys.readouterr()
    assert not err
    assert 'piipaa' in out


def test_cli_main_add_foo(capsys):
    assert cli.main(['foo']) == 0
    out, err = capsys.readouterr()
    assert not err
    assert 'piipaa' in out and 'foo' in out
