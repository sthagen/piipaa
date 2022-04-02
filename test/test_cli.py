import pipa.cli as cli


def test_cli_main_empty(capsys):
    assert cli.main([]) is None
    out, err = capsys.readouterr()
    assert not err
    assert 'pipa' in out


def test_cli_main_add_foo(capsys):
    cli.main(['foo'])
    out, err = capsys.readouterr()
    assert not err
    assert 'pipa' in out and 'foo' in out

