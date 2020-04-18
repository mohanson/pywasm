import os.path
import setuptools

root = os.path.abspath(os.path.dirname(__file__))
with open(os.path.join(root, 'README.md'), encoding='utf-8') as f:
    long_description = f.read()

setuptools.setup(
    name='pywasm',
    version='0.4.8',
    url='https://github.com/mohanson/pywasm',
    license='WTFPL',
    author='mohanson',
    author_email='mohanson@outlook.com',
    description='WebAssembly Interpreter by pure Python',
    long_description=long_description,
    long_description_content_type='text/markdown',
    packages=['pywasm'],
    python_requires='>=3.6',
)
