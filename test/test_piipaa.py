import piipaa.piipaa as pp


def test_pp_what_empty(capsys):
    assert pp.what([]) == 0
    out, err = capsys.readouterr()
    assert not err
    assert 'piipaa' in out


def test_pp_what_add_foo(capsys):
    assert pp.what(['foo']) == 0
    out, err = capsys.readouterr()
    assert not err
    assert 'piipaa' in out and 'foo' in out
