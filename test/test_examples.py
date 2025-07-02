import pathlib
import subprocess

for name in [p.name for p in pathlib.Path('examples').iterdir() if p.is_dir()]:
    subprocess.run(f'python examples/{name}.py', shell=True, check=True)
