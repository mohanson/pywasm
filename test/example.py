import pathlib
import subprocess

for name in [p.name for p in pathlib.Path('example').iterdir() if p.is_dir()]:
    subprocess.run(f'python example/{name}.py', shell=True, check=True)
