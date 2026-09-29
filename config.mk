#
# Copyright (C) 2020 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Apps
PRODUCT_PACKAGES += \
    AccessibilityMenu \
    Multiuser \
    SafetyRegulatoryInfo

# Overlays
PRODUCT_PACKAGES += \
    SettingsGoogle \
    SystemUIGoogle

# Artifact path requirement allowlist
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/app/GoogleExtShared/GoogleExtShared.apk \
    system/app/GooglePrintRecommendationService/GooglePrintRecommendationService.apk \
    system/etc/default-permissions/default-permissions_googleprintrecommendationservice.xml \
    system/etc/permissions/privapp-permissions-google.xml \
    system/etc/sysconfig/preinstalled-packages-generic-system-google.xml \
    system/priv-app/GooglePackageInstaller/GooglePackageInstaller.apk \
    system/priv-app/TagGoogle/TagGoogle.apk

# Enable background blur for widget picker
PRODUCT_SYSTEM_EXT_PROPERTIES += \
    ro.launcher.depth.widget=true

# Use gestures by default
PRODUCT_PROPERTY_OVERRIDES += \
    ro.boot.vendor.overlay.theme=com.android.internal.systemui.navbar.gestural;com.google.android.systemui.gxoverlay

# CarrierSetup configuration
PRODUCT_PRODUCT_PROPERTIES += \
    ro.carriersetup.vzw_consent_page=true

# Gboard configuration
PRODUCT_PRODUCT_PROPERTIES += \
    ro.com.google.ime.theme_id=5 \
    ro.com.google.ime.system_lm_dir=/product/usr/share/ime/google/d3_lms

# Google Play services configuration
PRODUCT_PRODUCT_PROPERTIES += \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent

# OPA configuration
PRODUCT_PRODUCT_PROPERTIES += \
    ro.opa.eligible_device=true

# StorageManager configuration
PRODUCT_PRODUCT_PROPERTIES += \
    ro.storage_manager.enabled=false \
    ro.storage_manager.show_opt_in=false

# SUW configuration
PRODUCT_PRODUCT_PROPERTIES += \
    ro.setupwizard.enterprise_mode=1 \
    ro.setupwizard.esim_cid_ignore=00000001 \
    setupwizard.feature.baseline_setupwizard_enabled=true \
    setupwizard.feature.day_night_mode_enabled=true \
    setupwizard.feature.default_locale_enhancement_enabled=true \
    setupwizard.feature.device_info_icon_enabled=true \
    setupwizard.feature.enable_gil= \
    setupwizard.feature.enable_gil_logging=true \
    setupwizard.feature.enable_minors_setup_flow=true \
    setupwizard.feature.enable_parental_notice_activity=true \
    setupwizard.feature.enable_parental_setup=true \
    setupwizard.feature.enable_quick_start_flow=true \
    setupwizard.feature.enable_restore_anytime=true \
    setupwizard.feature.enable_wifi_tracker=true \
    setupwizard.feature.enhanced_setup_design_metrics=true \
    setupwizard.feature.is_suw_onboarding_contract_enabled=true \
    setupwizard.feature.joined_up_loading=true \
    setupwizard.feature.lifecycle_refactoring=true \
    setupwizard.feature.locale_agnostic_enabled=true \
    setupwizard.feature.notification_refactoring=true \
    setupwizard.feature.osmigration=true \
    setupwizard.feature.portal_notification=true \
    setupwizard.feature.provisioning_profile_mode=true \
    setupwizard.feature.show_pai_screen_in_main_flow.carrier1839=false \
    setupwizard.feature.show_pixel_tos=true \
    setupwizard.feature.show_support_link_in_deferred_setup=false \
    setupwizard.feature.skip_button_use_mobile_data.carrier1839=true \
    setupwizard.personal_safety_suw_enabled=true \
    setupwizard.theme=glif_expressive

# WFC Activation
PRODUCT_PRODUCT_PROPERTIES += \
    ro.gwfcactivation.disabled_carriers=1492

$(call inherit-product, vendor/gms/common/common-vendor.mk)
$(call inherit-product, vendor/gms/mainline/config.mk)
$(call inherit-product, vendor/google/apps/ExtremeBatterySaver/config.mk)
$(call inherit-product, vendor/google/apps/TurboAdapter/config.mk)
