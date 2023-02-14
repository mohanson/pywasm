import os.path
import setuptools

root = os.path.abspath(os.path.dirname(__file__))
with open(os.path.join(root, 'README.md')) as f:
    long_description = f.read()

setuptools.setup(
    name='pywasm',
    version='1.0.8',
    url='https://github.com/mohanson/pywasm',
    license='MIT',
    author='mohanson',
    author_email='mohanson@outlook.com',
    description='WebAssembly Interpreter by pure Python',
    long_description=long_description,
    long_description_content_type='text/markdown',
    packages=['pywasm'],
    python_requires='>=3.6',
    install_requires=['numpy'],
    license_files=["LICENSE"],
)
