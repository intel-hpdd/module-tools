ifneq ($(filter iml_%,$(MAKECMDGOALS)),)
  COPR_CONFIG := --config ~/.config/copr-mfl
  OWNER_PROJECT = managerforlustre/manager-for-lustre
else
  # local settings
  -include copr-local.mk

  ifneq ($(filter copr_%,$(MAKECMDGOALS)),)
    ifndef COPR_OWNER
      $(error COPR_OWNER needs to be set in copr-local.mk)
    endif
    ifndef COPR_PROJECT
      $(error COPR_PROJECT needs to be set in copr-local.mk)
    endif
  endif
  OWNER_PROJECT = $(COPR_OWNER)/$(COPR_PROJECT)
endif

ifeq ($(BUILD_METHOD),PyPI)
#copr_build:
# https://pagure.io/copr/copr/issue/207
copr_build iml_copr_build: $(RPM_SPEC)
	# buildpypi is pretty useless right now:
	# https://pagure.io/copr/copr/issue/207
	#copr-cli buildpypi --packagename $(NAME)
	#$(COPR_OWNER)/$(COPR_PROJECT)
	copr-cli $(COPR_CONFIG) build $(OWNER_PROJECT) $^
else
copr_build iml_copr_build:
	copr-cli $(COPR_CONFIG) buildscm --clone-url                  \
			    https://github.com/intel-hpdd/$(NAME).git \
	                  --commit build-rpms                         \
		          --method make_srpm                          \
	                  $(OWNER_PROJECT) $<
endif

.PHONY: copr_build iml_copr_build
