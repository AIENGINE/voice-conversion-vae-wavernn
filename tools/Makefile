# Allow Python 3.10 but use PyTorch 1.11.0 (earliest version with Python 3.10 support)
PYTHON_VERSION_MIN=3.6
PYTHON_VERSION_MAX=3.10
PYTHON_VERSION=$(shell python3 -c "import sys;t='{v[0]}.{v[1]}'.format(v=list(sys.version_info[:2]));sys.stdout.write(t)")
PYTHON_VERSION_OK=$(shell python3 -c 'import sys; min_ver = [int(x) for x in "${PYTHON_VERSION_MIN}".split(".")]; max_ver = [int(x) for x in "${PYTHON_VERSION_MAX}".split(".")]; ver = list(sys.version_info[:2]); print(1 if (ver >= min_ver and ver <= max_ver) else 0)')

ifeq ($(PYTHON_VERSION_OK),0)
  $(error "Need python $(PYTHON_VERSION) >= $(PYTHON_VERSION_MIN)")
endif
PYTHON_VERSION_WITHOUT_DOT = $(strip $(subst .,,$(PYTHON_VERSION)))

# Python 3.8+ uses different ABI tags
ifeq ($(PYTHON_VERSION_OK),0)
  $(error "Python version ${PYTHON_VERSION} is outside the supported range (${PYTHON_VERSION_MIN} to ${PYTHON_VERSION_MAX})")
endif

# Use CUDA 11.3 (compatible with PyTorch 1.11.0 which supports Python 3.10)
CUDA_VERSION := 11.3
CUDA_VERSION_WITHOUT_DOT = $(strip $(subst .,,$(CUDA_VERSION)))

# PyTorch 1.11.0 is the earliest version with Python 3.10 support
PYTORCH_VERSION := 1.11.0
TORCHVISION_VERSION := 0.12.0
TORCHAUDIO_VERSION := 0.11.0

.PHONY: all clean

all: activate torch

activate:
	test -d venv || virtualenv -p python$(PYTHON_VERSION) venv
	. venv/bin/activate; pip install pip --upgrade; pip install -r requirements.txt; pip install matplotlib;
	touch venv/bin/activate

torch: activate
	. venv/bin/activate; pip install pip --upgrade; \
	pip install torch==$(PYTORCH_VERSION)+cu$(CUDA_VERSION_WITHOUT_DOT) \
	            torchvision==$(TORCHVISION_VERSION)+cu$(CUDA_VERSION_WITHOUT_DOT) \
	            torchaudio==$(TORCHAUDIO_VERSION)+cu$(CUDA_VERSION_WITHOUT_DOT) \
	            --extra-index-url https://download.pytorch.org/whl/cu$(CUDA_VERSION_WITHOUT_DOT); \
	pip install torch-optimizer

clean:
	rm -fr venv
	find -iname "*.pyc" -delete
