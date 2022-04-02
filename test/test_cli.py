import pipa.cli as cli


def test_cli_main_empty(capsys):
    assert cli.main([]) == 0
    out, err = capsys.readouterr()
    assert not err
    assert 'pipa' in out
