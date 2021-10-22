Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A46254371A7
	for <lists+linux-scsi@lfdr.de>; Fri, 22 Oct 2021 08:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbhJVGWh (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 22 Oct 2021 02:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbhJVGWg (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 22 Oct 2021 02:22:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12B0C061764;
        Thu, 21 Oct 2021 23:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=by5FHOGudU6D9wNZ++K7iAltqizPl9h0mvkIUGLn+mY=; b=D6ImLu20/OLUf4EC4Ypuu0pAjj
        7EDI7kKPqsHYKEe+sq0VBSGpEkXPE9CmVXQb4dHBwxr2UA1vNOAf3uptCBLzmjSkcZr4Ngnwwch+8
        OzedfELr9uU2GHOy4YHYSnLXg1sIFCFZq2VndNaek6zbzQnLZx6jKf9OgSUuiV5D5E0KDn/3Tapit
        69dXfuPM2KkzkF7Lh+MRGzBcGlTnxobddtJHgZzCBhNcemwiwa5bVwR5alJWtCxE7fCF1P1dEYKWX
        zksyAHvsnl6w/Q8fjP/+dt/sCoyxKIoYma9Pa6CqA9VNoD5JL7INcLwQqKzFnQcvmjWFsC8vJTANh
        30ohK82g==;
Received: from [2001:4bb8:180:8777:e63c:b910:fdc3:8340] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdnuZ-009nPW-Fv; Fri, 22 Oct 2021 06:20:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     martin.petersen@oracle.com, axboe@kernel.dk
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH] scsi: ufs: revert HPB support
Date:   Fri, 22 Oct 2021 08:20:11 +0200
Message-Id: <20211022062011.1262184-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The HPB support added this merge window is fundanetally flawed as it
uses blk_insert_cloned_request to insert a cloned request onto the same
queue as the one that the original request came from, leading to all
kinds of issues in blk-mq accounting (in addition to this API being
a special case for dm-mpath that should not see other users).

This reverts commits:

65ef27f7798b ("scsi: ufs: ufshpb: Remove unused parameters")
922ad26ebeaa ("scsi: ufs: ufshpb: Fix typo in comments")
6c9783e6296e ("scsi: ufs: ufshpb: Fix possible memory leak")
12bc2f13f381 ("scsi: ufs: ufshpb: Use scsi_cmd_to_rq() instead of scsi_cmnd.request")
10163cee1f06 ("scsi: ufs: ufshpb: Do not report victim error in HCM")
22aede9f48b6 ("scsi: ufs: ufshpb: Verify that 'num_inflight_map_req' is non-negative")
283e61c5a9be ("scsi: ufs: ufshpb: Rewind the read timeout on every read")
63522bf3aced ("scsi: ufs: core: Add L2P entry swap quirk for Micron UFS")
f95f59a2bb60 ("scsi: ufs: ufshpb: Make host mode parameters configurable")
5dea655a09e6 ("scsi: ufs: ufshpb: Add support for host control mode")
1afb7ddadcad ("scsi: ufs: ufshpb: Do not send umap_all in host control mode")
33845a2d844b ("scsi: ufs: ufshpb: Limit the number of in-flight map requests")
13c044e91678 ("scsi: ufs: ufshpb: Add "cold" regions timer")
67001ff171cb ("scsi: ufs: ufshpb: Add HPB dev reset response")
6f4ad14f0fb9 ("scsi: ufs: ufshpb: Region inactivation in host mode")
6c59cb501b86 ("scsi: ufs: ufshpb: Make eviction depend on region's reads")
c76a18885641 ("scsi: ufs: ufshpb: Add reads counter")
8becf4db1e01 ("scsi: ufs: ufshpb: Transform set_dirty to iterate_rgn")
3a2c1f680329 ("scsi: ufs: ufshpb: Add host control mode support to rsp_upiu")
119ee38c10fa ("scsi: ufs: ufshpb: Cache HPB Control mode on init")
07106f86ae13 ("scsi: ufs: ufshpb: Use a correct max multi chunk")
41d8a9333cc9 ("scsi: ufs: ufshpb: Add HPB 2.0 support")
2fff76f87542 ("scsi: ufs: ufshpb: Prepare HPB read for cached sub-region")
4b5f49079c52 ("scsi: ufs: ufshpb: L2P map management for HPB read")
f02bc9754a68 ("scsi: ufs: ufshpb: Introduce Host Performance Buffer feature")

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/ABI/testing/sysfs-driver-ufs |  236 --
 drivers/scsi/ufs/Kconfig                   |    9 -
 drivers/scsi/ufs/Makefile                  |    1 -
 drivers/scsi/ufs/ufs-sysfs.c               |   22 -
 drivers/scsi/ufs/ufs.h                     |   54 +-
 drivers/scsi/ufs/ufs_quirks.h              |    6 -
 drivers/scsi/ufs/ufshcd.c                  |   76 +-
 drivers/scsi/ufs/ufshcd.h                  |   32 -
 drivers/scsi/ufs/ufshpb.c                  | 2931 --------------------
 drivers/scsi/ufs/ufshpb.h                  |  323 ---
 10 files changed, 3 insertions(+), 3687 deletions(-)
 delete mode 100644 drivers/scsi/ufs/ufshpb.c
 delete mode 100644 drivers/scsi/ufs/ufshpb.h

diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
index ec3a7149ced59..b4a5d55fa19f8 100644
--- a/Documentation/ABI/testing/sysfs-driver-ufs
+++ b/Documentation/ABI/testing/sysfs-driver-ufs
@@ -1298,239 +1298,3 @@ Description:	This node is used to set or display whether UFS WriteBooster is
 		(if the platform supports UFSHCD_CAP_CLK_SCALING). For a
 		platform that doesn't support UFSHCD_CAP_CLK_SCALING, we can
 		disable/enable WriteBooster through this sysfs node.
-
-What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/hpb_version
-Date:		June 2021
-Contact:	Daejun Park <daejun7.park@samsung.com>
-Description:	This entry shows the HPB specification version.
-		The full information about the descriptor can be found in the UFS
-		HPB (Host Performance Booster) Extension specifications.
-		Example: version 1.2.3 = 0123h
-
-		The file is read only.
-
-What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/hpb_control
-Date:		June 2021
-Contact:	Daejun Park <daejun7.park@samsung.com>
-Description:	This entry shows an indication of the HPB control mode.
-		00h: Host control mode
-		01h: Device control mode
-
-		The file is read only.
-
-What:		/sys/bus/platform/drivers/ufshcd/*/geometry_descriptor/hpb_region_size
-Date:		June 2021
-Contact:	Daejun Park <daejun7.park@samsung.com>
-Description:	This entry shows the bHPBRegionSize which can be calculated
-		as in the following (in bytes):
-		HPB Region size = 512B * 2^bHPBRegionSize
-
-		The file is read only.
-
-What:		/sys/bus/platform/drivers/ufshcd/*/geometry_descriptor/hpb_number_lu
-Date:		June 2021
-Contact:	Daejun Park <daejun7.park@samsung.com>
-Description:	This entry shows the maximum number of HPB LU supported	by
-		the device.
-		00h: HPB is not supported by the device.
-		01h ~ 20h: Maximum number of HPB LU supported by the device
-
-		The file is read only.
-
-What:		/sys/bus/platform/drivers/ufshcd/*/geometry_descriptor/hpb_subregion_size
-Date:		June 2021
-Contact:	Daejun Park <daejun7.park@samsung.com>
-Description:	This entry shows the bHPBSubRegionSize, which can be
-		calculated as in the following (in bytes) and shall be a multiple of
-		logical block size:
-		HPB Sub-Region size = 512B x 2^bHPBSubRegionSize
-		bHPBSubRegionSize shall not exceed bHPBRegionSize.
-
-		The file is read only.
-
-What:		/sys/bus/platform/drivers/ufshcd/*/geometry_descriptor/hpb_max_active_regions
-Date:		June 2021
-Contact:	Daejun Park <daejun7.park@samsung.com>
-Description:	This entry shows the maximum number of active HPB regions that
-		is supported by the device.
-
-		The file is read only.
-
-What:		/sys/class/scsi_device/*/device/unit_descriptor/hpb_lu_max_active_regions
-Date:		June 2021
-Contact:	Daejun Park <daejun7.park@samsung.com>
-Description:	This entry shows the maximum number of HPB regions assigned to
-		the HPB logical unit.
-
-		The file is read only.
-
-What:		/sys/class/scsi_device/*/device/unit_descriptor/hpb_pinned_region_start_offset
-Date:		June 2021
-Contact:	Daejun Park <daejun7.park@samsung.com>
-Description:	This entry shows the start offset of HPB pinned region.
-
-		The file is read only.
-
-What:		/sys/class/scsi_device/*/device/unit_descriptor/hpb_number_pinned_regions
-Date:		June 2021
-Contact:	Daejun Park <daejun7.park@samsung.com>
-Description:	This entry shows the number of HPB pinned regions assigned to
-		the HPB logical unit.
-
-		The file is read only.
-
-What:		/sys/class/scsi_device/*/device/hpb_stats/hit_cnt
-Date:		June 2021
-Contact:	Daejun Park <daejun7.park@samsung.com>
-Description:	This entry shows the number of reads that changed to HPB read.
-
-		The file is read only.
-
-What:		/sys/class/scsi_device/*/device/hpb_stats/miss_cnt
-Date:		June 2021
-Contact:	Daejun Park <daejun7.park@samsung.com>
-Description:	This entry shows the number of reads that cannot be changed to
-		HPB read.
-
-		The file is read only.
-
-What:		/sys/class/scsi_device/*/device/hpb_stats/rb_noti_cnt
-Date:		June 2021
-Contact:	Daejun Park <daejun7.park@samsung.com>
-Description:	This entry shows the number of response UPIUs that has
-		recommendations for activating sub-regions and/or inactivating region.
-
-		The file is read only.
-
-What:		/sys/class/scsi_device/*/device/hpb_stats/rb_active_cnt
-Date:		June 2021
-Contact:	Daejun Park <daejun7.park@samsung.com>
-Description:	This entry shows the number of active sub-regions recommended by
-		response UPIUs.
-
-		The file is read only.
-
-What:		/sys/class/scsi_device/*/device/hpb_stats/rb_inactive_cnt
-Date:		June 2021
-Contact:	Daejun Park <daejun7.park@samsung.com>
-Description:	This entry shows the number of inactive regions recommended by
-		response UPIUs.
-
-		The file is read only.
-
-What:		/sys/class/scsi_device/*/device/hpb_stats/map_req_cnt
-Date:		June 2021
-Contact:	Daejun Park <daejun7.park@samsung.com>
-Description:	This entry shows the number of read buffer commands for
-		activating sub-regions recommended by response UPIUs.
-
-		The file is read only.
-
-What:		/sys/class/scsi_device/*/device/hpb_params/requeue_timeout_ms
-Date:		June 2021
-Contact:	Daejun Park <daejun7.park@samsung.com>
-Description:	This entry shows the requeue timeout threshold for write buffer
-		command in ms. The value can be changed by writing an integer to
-		this entry.
-
-What:		/sys/bus/platform/drivers/ufshcd/*/attributes/max_data_size_hpb_single_cmd
-Date:		June 2021
-Contact:	Daejun Park <daejun7.park@samsung.com>
-Description:	This entry shows the maximum HPB data size for using a single HPB
-		command.
-
-		===  ========
-		00h  4KB
-		01h  8KB
-		02h  12KB
-		...
-		FFh  1024KB
-		===  ========
-
-		The file is read only.
-
-What:		/sys/bus/platform/drivers/ufshcd/*/flags/hpb_enable
-Date:		June 2021
-Contact:	Daejun Park <daejun7.park@samsung.com>
-Description:	This entry shows the status of HPB.
-
-		== ============================
-		0  HPB is not enabled.
-		1  HPB is enabled
-		== ============================
-
-		The file is read only.
-
-What:		/sys/class/scsi_device/*/device/hpb_param_sysfs/activation_thld
-Date:		February 2021
-Contact:	Avri Altman <avri.altman@wdc.com>
-Description:	In host control mode, reads are the major source of activation
-		trials.  Once this threshold hs met, the region is added to the
-		"to-be-activated" list.  Since we reset the read counter upon
-		write, this include sending a rb command updating the region
-		ppn as well.
-
-What:		/sys/class/scsi_device/*/device/hpb_param_sysfs/normalization_factor
-Date:		February 2021
-Contact:	Avri Altman <avri.altman@wdc.com>
-Description:	In host control mode, we think of the regions as "buckets".
-		Those buckets are being filled with reads, and emptied on write.
-		We use entries_per_srgn - the amount of blocks in a subregion as
-		our bucket size.  This applies because HPB1.0 only handles
-		single-block reads.  Once the bucket size is crossed, we trigger
-		a normalization work - not only to avoid overflow, but mainly
-		because we want to keep those counters normalized, as we are
-		using those reads as a comparative score, to make various decisions.
-		The normalization is dividing (shift right) the read counter by
-		the normalization_factor. If during consecutive normalizations
-		an active region has exhausted its reads - inactivate it.
-
-What:		/sys/class/scsi_device/*/device/hpb_param_sysfs/eviction_thld_enter
-Date:		February 2021
-Contact:	Avri Altman <avri.altman@wdc.com>
-Description:	Region deactivation is often due to the fact that eviction took
-		place: A region becomes active at the expense of another. This is
-		happening when the max-active-regions limit has been crossed.
-		In host mode, eviction is considered an extreme measure. We
-		want to verify that the entering region has enough reads, and
-		the exiting region has much fewer reads.  eviction_thld_enter is
-		the min reads that a region must have in order to be considered
-		a candidate for evicting another region.
-
-What:		/sys/class/scsi_device/*/device/hpb_param_sysfs/eviction_thld_exit
-Date:		February 2021
-Contact:	Avri Altman <avri.altman@wdc.com>
-Description:	Same as above for the exiting region. A region is considered to
-		be a candidate for eviction only if it has fewer reads than
-		eviction_thld_exit.
-
-What:		/sys/class/scsi_device/*/device/hpb_param_sysfs/read_timeout_ms
-Date:		February 2021
-Contact:	Avri Altman <avri.altman@wdc.com>
-Description:	In order not to hang on to "cold" regions, we inactivate
-		a region that has no READ access for a predefined amount of
-		time - read_timeout_ms. If read_timeout_ms has expired, and the
-		region is dirty, it is less likely that we can make any use of
-		HPB reading it so we inactivate it.  Still, deactivation has
-		its overhead, and we may still benefit from HPB reading this
-		region if it is clean - see read_timeout_expiries.
-
-What:		/sys/class/scsi_device/*/device/hpb_param_sysfs/read_timeout_expiries
-Date:		February 2021
-Contact:	Avri Altman <avri.altman@wdc.com>
-Description:	If the region read timeout has expired, but the region is clean,
-		just re-wind its timer for another spin.  Do that as long as it
-		is clean and did not exhaust its read_timeout_expiries threshold.
-
-What:		/sys/class/scsi_device/*/device/hpb_param_sysfs/timeout_polling_interval_ms
-Date:		February 2021
-Contact:	Avri Altman <avri.altman@wdc.com>
-Description:	The frequency with which the delayed worker that checks the
-		read_timeouts is awakened.
-
-What:		/sys/class/scsi_device/*/device/hpb_param_sysfs/inflight_map_req
-Date:		February 2021
-Contact:	Avri Altman <avri.altman@wdc.com>
-Description:	In host control mode the host is the originator of map requests.
-		To avoid flooding the device with map requests, use a simple throttling
-		mechanism that limits the number of inflight map requests.
diff --git a/drivers/scsi/ufs/Kconfig b/drivers/scsi/ufs/Kconfig
index 432df76e6318a..3d777375416c9 100644
--- a/drivers/scsi/ufs/Kconfig
+++ b/drivers/scsi/ufs/Kconfig
@@ -184,15 +184,6 @@ config SCSI_UFS_CRYPTO
 	  capabilities of the UFS device (if present) to perform crypto
 	  operations on data being transferred to/from the device.
 
-config SCSI_UFS_HPB
-	bool "Support UFS Host Performance Booster"
-	depends on SCSI_UFSHCD
-	help
-	  The UFS HPB feature improves random read performance. It caches
-	  L2P (logical to physical) map of UFS to host DRAM. The driver uses HPB
-	  read command by piggybacking physical page number for bypassing FTL (flash
-	  translation layer)'s L2P address translation.
-
 config SCSI_UFS_FAULT_INJECTION
 	bool "UFS Fault Injection Support"
 	depends on SCSI_UFSHCD && FAULT_INJECTION
diff --git a/drivers/scsi/ufs/Makefile b/drivers/scsi/ufs/Makefile
index c407da9b51713..006d502360791 100644
--- a/drivers/scsi/ufs/Makefile
+++ b/drivers/scsi/ufs/Makefile
@@ -8,7 +8,6 @@ ufshcd-core-y				+= ufshcd.o ufs-sysfs.o
 ufshcd-core-$(CONFIG_DEBUG_FS)		+= ufs-debugfs.o
 ufshcd-core-$(CONFIG_SCSI_UFS_BSG)	+= ufs_bsg.o
 ufshcd-core-$(CONFIG_SCSI_UFS_CRYPTO)	+= ufshcd-crypto.o
-ufshcd-core-$(CONFIG_SCSI_UFS_HPB)	+= ufshpb.o
 ufshcd-core-$(CONFIG_SCSI_UFS_FAULT_INJECTION) += ufs-fault-injection.o
 
 obj-$(CONFIG_SCSI_UFS_DWC_TC_PCI) += tc-dwc-g210-pci.o ufshcd-dwc.o tc-dwc-g210.o
diff --git a/drivers/scsi/ufs/ufs-sysfs.c b/drivers/scsi/ufs/ufs-sysfs.c
index 5c405ff7b6eaa..386f3569b9ce8 100644
--- a/drivers/scsi/ufs/ufs-sysfs.c
+++ b/drivers/scsi/ufs/ufs-sysfs.c
@@ -604,8 +604,6 @@ UFS_DEVICE_DESC_PARAM(device_version, _DEV_VER, 2);
 UFS_DEVICE_DESC_PARAM(number_of_secure_wpa, _NUM_SEC_WPA, 1);
 UFS_DEVICE_DESC_PARAM(psa_max_data_size, _PSA_MAX_DATA, 4);
 UFS_DEVICE_DESC_PARAM(psa_state_timeout, _PSA_TMT, 1);
-UFS_DEVICE_DESC_PARAM(hpb_version, _HPB_VER, 2);
-UFS_DEVICE_DESC_PARAM(hpb_control, _HPB_CONTROL, 1);
 UFS_DEVICE_DESC_PARAM(ext_feature_sup, _EXT_UFS_FEATURE_SUP, 4);
 UFS_DEVICE_DESC_PARAM(wb_presv_us_en, _WB_PRESRV_USRSPC_EN, 1);
 UFS_DEVICE_DESC_PARAM(wb_type, _WB_TYPE, 1);
@@ -638,8 +636,6 @@ static struct attribute *ufs_sysfs_device_descriptor[] = {
 	&dev_attr_number_of_secure_wpa.attr,
 	&dev_attr_psa_max_data_size.attr,
 	&dev_attr_psa_state_timeout.attr,
-	&dev_attr_hpb_version.attr,
-	&dev_attr_hpb_control.attr,
 	&dev_attr_ext_feature_sup.attr,
 	&dev_attr_wb_presv_us_en.attr,
 	&dev_attr_wb_type.attr,
@@ -713,10 +709,6 @@ UFS_GEOMETRY_DESC_PARAM(enh4_memory_max_alloc_units,
 	_ENM4_MAX_NUM_UNITS, 4);
 UFS_GEOMETRY_DESC_PARAM(enh4_memory_capacity_adjustment_factor,
 	_ENM4_CAP_ADJ_FCTR, 2);
-UFS_GEOMETRY_DESC_PARAM(hpb_region_size, _HPB_REGION_SIZE, 1);
-UFS_GEOMETRY_DESC_PARAM(hpb_number_lu, _HPB_NUMBER_LU, 1);
-UFS_GEOMETRY_DESC_PARAM(hpb_subregion_size, _HPB_SUBREGION_SIZE, 1);
-UFS_GEOMETRY_DESC_PARAM(hpb_max_active_regions, _HPB_MAX_ACTIVE_REGS, 2);
 UFS_GEOMETRY_DESC_PARAM(wb_max_alloc_units, _WB_MAX_ALLOC_UNITS, 4);
 UFS_GEOMETRY_DESC_PARAM(wb_max_wb_luns, _WB_MAX_WB_LUNS, 1);
 UFS_GEOMETRY_DESC_PARAM(wb_buff_cap_adj, _WB_BUFF_CAP_ADJ, 1);
@@ -754,10 +746,6 @@ static struct attribute *ufs_sysfs_geometry_descriptor[] = {
 	&dev_attr_enh3_memory_capacity_adjustment_factor.attr,
 	&dev_attr_enh4_memory_max_alloc_units.attr,
 	&dev_attr_enh4_memory_capacity_adjustment_factor.attr,
-	&dev_attr_hpb_region_size.attr,
-	&dev_attr_hpb_number_lu.attr,
-	&dev_attr_hpb_subregion_size.attr,
-	&dev_attr_hpb_max_active_regions.attr,
 	&dev_attr_wb_max_alloc_units.attr,
 	&dev_attr_wb_max_wb_luns.attr,
 	&dev_attr_wb_buff_cap_adj.attr,
@@ -1018,7 +1006,6 @@ UFS_FLAG(disable_fw_update, _PERMANENTLY_DISABLE_FW_UPDATE);
 UFS_FLAG(wb_enable, _WB_EN);
 UFS_FLAG(wb_flush_en, _WB_BUFF_FLUSH_EN);
 UFS_FLAG(wb_flush_during_h8, _WB_BUFF_FLUSH_DURING_HIBERN8);
-UFS_FLAG(hpb_enable, _HPB_EN);
 
 static struct attribute *ufs_sysfs_device_flags[] = {
 	&dev_attr_device_init.attr,
@@ -1032,7 +1019,6 @@ static struct attribute *ufs_sysfs_device_flags[] = {
 	&dev_attr_wb_enable.attr,
 	&dev_attr_wb_flush_en.attr,
 	&dev_attr_wb_flush_during_h8.attr,
-	&dev_attr_hpb_enable.attr,
 	NULL,
 };
 
@@ -1079,7 +1065,6 @@ out:									\
 static DEVICE_ATTR_RO(_name)
 
 UFS_ATTRIBUTE(boot_lun_enabled, _BOOT_LU_EN);
-UFS_ATTRIBUTE(max_data_size_hpb_single_cmd, _MAX_HPB_SINGLE_CMD);
 UFS_ATTRIBUTE(current_power_mode, _POWER_MODE);
 UFS_ATTRIBUTE(active_icc_level, _ACTIVE_ICC_LVL);
 UFS_ATTRIBUTE(ooo_data_enabled, _OOO_DATA_EN);
@@ -1103,7 +1088,6 @@ UFS_ATTRIBUTE(wb_cur_buf, _CURR_WB_BUFF_SIZE);
 
 static struct attribute *ufs_sysfs_attributes[] = {
 	&dev_attr_boot_lun_enabled.attr,
-	&dev_attr_max_data_size_hpb_single_cmd.attr,
 	&dev_attr_current_power_mode.attr,
 	&dev_attr_active_icc_level.attr,
 	&dev_attr_ooo_data_enabled.attr,
@@ -1177,9 +1161,6 @@ UFS_UNIT_DESC_PARAM(provisioning_type, _PROVISIONING_TYPE, 1);
 UFS_UNIT_DESC_PARAM(physical_memory_resourse_count, _PHY_MEM_RSRC_CNT, 8);
 UFS_UNIT_DESC_PARAM(context_capabilities, _CTX_CAPABILITIES, 2);
 UFS_UNIT_DESC_PARAM(large_unit_granularity, _LARGE_UNIT_SIZE_M1, 1);
-UFS_UNIT_DESC_PARAM(hpb_lu_max_active_regions, _HPB_LU_MAX_ACTIVE_RGNS, 2);
-UFS_UNIT_DESC_PARAM(hpb_pinned_region_start_offset, _HPB_PIN_RGN_START_OFF, 2);
-UFS_UNIT_DESC_PARAM(hpb_number_pinned_regions, _HPB_NUM_PIN_RGNS, 2);
 UFS_UNIT_DESC_PARAM(wb_buf_alloc_units, _WB_BUF_ALLOC_UNITS, 4);
 
 static struct attribute *ufs_sysfs_unit_descriptor[] = {
@@ -1197,9 +1178,6 @@ static struct attribute *ufs_sysfs_unit_descriptor[] = {
 	&dev_attr_physical_memory_resourse_count.attr,
 	&dev_attr_context_capabilities.attr,
 	&dev_attr_large_unit_granularity.attr,
-	&dev_attr_hpb_lu_max_active_regions.attr,
-	&dev_attr_hpb_pinned_region_start_offset.attr,
-	&dev_attr_hpb_number_pinned_regions.attr,
 	&dev_attr_wb_buf_alloc_units.attr,
 	NULL,
 };
diff --git a/drivers/scsi/ufs/ufs.h b/drivers/scsi/ufs/ufs.h
index 8c6b38b1b1422..cb80b9670bfe8 100644
--- a/drivers/scsi/ufs/ufs.h
+++ b/drivers/scsi/ufs/ufs.h
@@ -122,14 +122,12 @@ enum flag_idn {
 	QUERY_FLAG_IDN_WB_EN                            = 0x0E,
 	QUERY_FLAG_IDN_WB_BUFF_FLUSH_EN                 = 0x0F,
 	QUERY_FLAG_IDN_WB_BUFF_FLUSH_DURING_HIBERN8     = 0x10,
-	QUERY_FLAG_IDN_HPB_RESET                        = 0x11,
-	QUERY_FLAG_IDN_HPB_EN				= 0x12,
 };
 
 /* Attribute idn for Query requests */
 enum attr_idn {
 	QUERY_ATTR_IDN_BOOT_LU_EN		= 0x00,
-	QUERY_ATTR_IDN_MAX_HPB_SINGLE_CMD	= 0x01,
+	QUERY_ATTR_IDN_RESERVED			= 0x01,
 	QUERY_ATTR_IDN_POWER_MODE		= 0x02,
 	QUERY_ATTR_IDN_ACTIVE_ICC_LVL		= 0x03,
 	QUERY_ATTR_IDN_OOO_DATA_EN		= 0x04,
@@ -197,9 +195,6 @@ enum unit_desc_param {
 	UNIT_DESC_PARAM_PHY_MEM_RSRC_CNT	= 0x18,
 	UNIT_DESC_PARAM_CTX_CAPABILITIES	= 0x20,
 	UNIT_DESC_PARAM_LARGE_UNIT_SIZE_M1	= 0x22,
-	UNIT_DESC_PARAM_HPB_LU_MAX_ACTIVE_RGNS	= 0x23,
-	UNIT_DESC_PARAM_HPB_PIN_RGN_START_OFF	= 0x25,
-	UNIT_DESC_PARAM_HPB_NUM_PIN_RGNS	= 0x27,
 	UNIT_DESC_PARAM_WB_BUF_ALLOC_UNITS	= 0x29,
 };
 
@@ -240,8 +235,6 @@ enum device_desc_param {
 	DEVICE_DESC_PARAM_PSA_MAX_DATA		= 0x25,
 	DEVICE_DESC_PARAM_PSA_TMT		= 0x29,
 	DEVICE_DESC_PARAM_PRDCT_REV		= 0x2A,
-	DEVICE_DESC_PARAM_HPB_VER		= 0x40,
-	DEVICE_DESC_PARAM_HPB_CONTROL		= 0x42,
 	DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP	= 0x4F,
 	DEVICE_DESC_PARAM_WB_PRESRV_USRSPC_EN	= 0x53,
 	DEVICE_DESC_PARAM_WB_TYPE		= 0x54,
@@ -290,10 +283,6 @@ enum geometry_desc_param {
 	GEOMETRY_DESC_PARAM_ENM4_MAX_NUM_UNITS	= 0x3E,
 	GEOMETRY_DESC_PARAM_ENM4_CAP_ADJ_FCTR	= 0x42,
 	GEOMETRY_DESC_PARAM_OPT_LOG_BLK_SIZE	= 0x44,
-	GEOMETRY_DESC_PARAM_HPB_REGION_SIZE	= 0x48,
-	GEOMETRY_DESC_PARAM_HPB_NUMBER_LU	= 0x49,
-	GEOMETRY_DESC_PARAM_HPB_SUBREGION_SIZE	= 0x4A,
-	GEOMETRY_DESC_PARAM_HPB_MAX_ACTIVE_REGS	= 0x4B,
 	GEOMETRY_DESC_PARAM_WB_MAX_ALLOC_UNITS	= 0x4F,
 	GEOMETRY_DESC_PARAM_WB_MAX_WB_LUNS	= 0x53,
 	GEOMETRY_DESC_PARAM_WB_BUFF_CAP_ADJ	= 0x54,
@@ -338,10 +327,8 @@ enum {
 
 /* Possible values for dExtendedUFSFeaturesSupport */
 enum {
-	UFS_DEV_HPB_SUPPORT		= BIT(7),
 	UFS_DEV_WRITE_BOOSTER_SUP	= BIT(8),
 };
-#define UFS_DEV_HPB_SUPPORT_VERSION		0x310
 
 #define POWER_DESC_MAX_ACTV_ICC_LVLS		16
 
@@ -479,41 +466,6 @@ struct utp_cmd_rsp {
 	u8 sense_data[UFS_SENSE_SIZE];
 };
 
-struct ufshpb_active_field {
-	__be16 active_rgn;
-	__be16 active_srgn;
-};
-#define HPB_ACT_FIELD_SIZE 4
-
-/**
- * struct utp_hpb_rsp - Response UPIU structure
- * @residual_transfer_count: Residual transfer count DW-3
- * @reserved1: Reserved double words DW-4 to DW-7
- * @sense_data_len: Sense data length DW-8 U16
- * @desc_type: Descriptor type of sense data
- * @additional_len: Additional length of sense data
- * @hpb_op: HPB operation type
- * @lun: LUN of response UPIU
- * @active_rgn_cnt: Active region count
- * @inactive_rgn_cnt: Inactive region count
- * @hpb_active_field: Recommended to read HPB region and subregion
- * @hpb_inactive_field: To be inactivated HPB region and subregion
- */
-struct utp_hpb_rsp {
-	__be32 residual_transfer_count;
-	__be32 reserved1[4];
-	__be16 sense_data_len;
-	u8 desc_type;
-	u8 additional_len;
-	u8 hpb_op;
-	u8 lun;
-	u8 active_rgn_cnt;
-	u8 inactive_rgn_cnt;
-	struct ufshpb_active_field hpb_active_field[2];
-	__be16 hpb_inactive_field[2];
-};
-#define UTP_HPB_RSP_SIZE 40
-
 /**
  * struct utp_upiu_rsp - general upiu response structure
  * @header: UPIU header structure DW-0 to DW-2
@@ -524,7 +476,6 @@ struct utp_upiu_rsp {
 	struct utp_upiu_header header;
 	union {
 		struct utp_cmd_rsp sr;
-		struct utp_hpb_rsp hr;
 		struct utp_upiu_query qr;
 	};
 };
@@ -593,9 +544,6 @@ struct ufs_dev_info {
 	u16	wspecversion;
 	u32	clk_gating_wait_us;
 
-	/* UFS HPB related flag */
-	bool	hpb_enabled;
-
 	/* UFS WB related flags */
 	bool    wb_enabled;
 	bool    wb_buf_flush_enabled;
diff --git a/drivers/scsi/ufs/ufs_quirks.h b/drivers/scsi/ufs/ufs_quirks.h
index 35ec9ea79869a..07f559ac5883a 100644
--- a/drivers/scsi/ufs/ufs_quirks.h
+++ b/drivers/scsi/ufs/ufs_quirks.h
@@ -116,10 +116,4 @@ struct ufs_dev_fix {
  */
 #define UFS_DEVICE_QUIRK_DELAY_AFTER_LPM        (1 << 11)
 
-/*
- * Some UFS devices require L2P entry should be swapped before being sent to the
- * UFS device for HPB READ command.
- */
-#define UFS_DEVICE_QUIRK_SWAP_L2P_ENTRY_FOR_HPB_READ (1 << 12)
-
 #endif /* UFS_QUIRKS_H_ */
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 95be7ecdfe10b..c9d2ea0a024ac 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -25,7 +25,6 @@
 #include "ufs-fault-injection.h"
 #include "ufs_bsg.h"
 #include "ufshcd-crypto.h"
-#include "ufshpb.h"
 #include <asm/unaligned.h>
 
 #define CREATE_TRACE_POINTS
@@ -197,8 +196,7 @@ ufs_get_desired_pm_lvl_for_dev_link_state(enum ufs_dev_pwr_mode dev_state,
 static struct ufs_dev_fix ufs_fixups[] = {
 	/* UFS cards deviations table */
 	UFS_FIX(UFS_VENDOR_MICRON, UFS_ANY_MODEL,
-		UFS_DEVICE_QUIRK_DELAY_BEFORE_LPM |
-		UFS_DEVICE_QUIRK_SWAP_L2P_ENTRY_FOR_HPB_READ),
+		UFS_DEVICE_QUIRK_DELAY_BEFORE_LPM),
 	UFS_FIX(UFS_VENDOR_SAMSUNG, UFS_ANY_MODEL,
 		UFS_DEVICE_QUIRK_DELAY_BEFORE_LPM |
 		UFS_DEVICE_QUIRK_HOST_PA_TACTIVATE |
@@ -2737,13 +2735,6 @@ static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 
 	lrbp->req_abort_skip = false;
 
-	err = ufshpb_prep(hba, lrbp);
-	if (err == -EAGAIN) {
-		lrbp->cmd = NULL;
-		ufshcd_release(hba);
-		goto out;
-	}
-
 	ufshcd_comp_scsi_upiu(hba, lrbp);
 
 	err = ufshcd_map_sg(hba, lrbp);
@@ -3149,7 +3140,7 @@ int ufshcd_query_attr(struct ufs_hba *hba, enum query_opcode opcode,
  *
  * Returns 0 for success, non-zero in case of failure
 */
-int ufshcd_query_attr_retry(struct ufs_hba *hba,
+static int ufshcd_query_attr_retry(struct ufs_hba *hba,
 	enum query_opcode opcode, enum attr_idn idn, u8 index, u8 selector,
 	u32 *attr_val)
 {
@@ -4943,26 +4934,6 @@ static int ufshcd_change_queue_depth(struct scsi_device *sdev, int depth)
 	return scsi_change_queue_depth(sdev, depth);
 }
 
-static void ufshcd_hpb_destroy(struct ufs_hba *hba, struct scsi_device *sdev)
-{
-	/* skip well-known LU */
-	if ((sdev->lun >= UFS_UPIU_MAX_UNIT_NUM_ID) ||
-	    !(hba->dev_info.hpb_enabled) || !ufshpb_is_allowed(hba))
-		return;
-
-	ufshpb_destroy_lu(hba, sdev);
-}
-
-static void ufshcd_hpb_configure(struct ufs_hba *hba, struct scsi_device *sdev)
-{
-	/* skip well-known LU */
-	if ((sdev->lun >= UFS_UPIU_MAX_UNIT_NUM_ID) ||
-	    !(hba->dev_info.hpb_enabled) || !ufshpb_is_allowed(hba))
-		return;
-
-	ufshpb_init_hpb_lu(hba, sdev);
-}
-
 /**
  * ufshcd_slave_configure - adjust SCSI device configurations
  * @sdev: pointer to SCSI device
@@ -4972,8 +4943,6 @@ static int ufshcd_slave_configure(struct scsi_device *sdev)
 	struct ufs_hba *hba = shost_priv(sdev->host);
 	struct request_queue *q = sdev->request_queue;
 
-	ufshcd_hpb_configure(hba, sdev);
-
 	blk_queue_update_dma_pad(q, PRDT_DATA_BYTE_COUNT_PAD - 1);
 	if (hba->quirks & UFSHCD_QUIRK_ALIGN_SG_WITH_PAGE_SIZE)
 		blk_queue_update_dma_alignment(q, PAGE_SIZE - 1);
@@ -5001,9 +4970,6 @@ static void ufshcd_slave_destroy(struct scsi_device *sdev)
 	unsigned long flags;
 
 	hba = shost_priv(sdev->host);
-
-	ufshcd_hpb_destroy(hba, sdev);
-
 	/* Drop the reference as it won't be needed anymore */
 	if (ufshcd_scsi_to_upiu_lun(sdev->lun) == UFS_UPIU_UFS_DEVICE_WLUN) {
 		spin_lock_irqsave(hba->host->host_lock, flags);
@@ -5124,9 +5090,6 @@ ufshcd_transfer_rsp_status(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
 			    ufshcd_is_exception_event(lrbp->ucd_rsp_ptr))
 				/* Flushed in suspend */
 				schedule_work(&hba->eeh_work);
-
-			if (scsi_status == SAM_STAT_GOOD)
-				ufshpb_rsp_upiu(hba, lrbp);
 			break;
 		case UPIU_TRANSACTION_REJECT_UPIU:
 			/* TODO: handle Reject UPIU Response */
@@ -7075,7 +7038,6 @@ static int ufshcd_host_reset_and_restore(struct ufs_hba *hba)
 	 * Stop the host controller and complete the requests
 	 * cleared by h/w
 	 */
-	ufshpb_reset_host(hba);
 	ufshcd_hba_stop(hba);
 	hba->silence_err_logs = true;
 	ufshcd_retry_aborted_requests(hba);
@@ -7474,7 +7436,6 @@ static int ufs_get_device_desc(struct ufs_hba *hba)
 {
 	int err;
 	u8 model_index;
-	u8 b_ufs_feature_sup;
 	u8 *desc_buf;
 	struct ufs_dev_info *dev_info = &hba->dev_info;
 
@@ -7502,26 +7463,9 @@ static int ufs_get_device_desc(struct ufs_hba *hba)
 	/* getting Specification Version in big endian format */
 	dev_info->wspecversion = desc_buf[DEVICE_DESC_PARAM_SPEC_VER] << 8 |
 				      desc_buf[DEVICE_DESC_PARAM_SPEC_VER + 1];
-	b_ufs_feature_sup = desc_buf[DEVICE_DESC_PARAM_UFS_FEAT];
 
 	model_index = desc_buf[DEVICE_DESC_PARAM_PRDCT_NAME];
 
-	if (dev_info->wspecversion >= UFS_DEV_HPB_SUPPORT_VERSION &&
-	    (b_ufs_feature_sup & UFS_DEV_HPB_SUPPORT)) {
-		bool hpb_en = false;
-
-		ufshpb_get_dev_info(hba, desc_buf);
-
-		if (!ufshpb_is_legacy(hba))
-			err = ufshcd_query_flag_retry(hba,
-						      UPIU_QUERY_OPCODE_READ_FLAG,
-						      QUERY_FLAG_IDN_HPB_EN, 0,
-						      &hpb_en);
-
-		if (ufshpb_is_legacy(hba) || (!err && hpb_en))
-			dev_info->hpb_enabled = true;
-	}
-
 	err = ufshcd_read_string_desc(hba, model_index,
 				      &dev_info->model, SD_ASCII_STD);
 	if (err < 0) {
@@ -7753,10 +7697,6 @@ static int ufshcd_device_geo_params_init(struct ufs_hba *hba)
 	else if (desc_buf[GEOMETRY_DESC_PARAM_MAX_NUM_LUN] == 0)
 		hba->dev_info.max_lu_supported = 8;
 
-	if (hba->desc_size[QUERY_DESC_IDN_GEOMETRY] >=
-		GEOMETRY_DESC_PARAM_HPB_MAX_ACTIVE_REGS)
-		ufshpb_get_geo_info(hba, desc_buf);
-
 out:
 	kfree(desc_buf);
 	return err;
@@ -7899,7 +7839,6 @@ static int ufshcd_add_lus(struct ufs_hba *hba)
 	}
 
 	ufs_bsg_probe(hba);
-	ufshpb_init(hba);
 	scsi_scan_host(hba->host);
 	pm_runtime_put_sync(hba->dev);
 
@@ -8101,7 +8040,6 @@ static int ufshcd_probe_hba(struct ufs_hba *hba, bool init_dev_params)
 	/* Enable Auto-Hibernate if configured */
 	ufshcd_auto_hibern8_enable(hba);
 
-	ufshpb_reset(hba);
 out:
 	spin_lock_irqsave(hba->host->host_lock, flags);
 	if (ret)
@@ -8149,10 +8087,6 @@ static void ufshcd_async_scan(void *data, async_cookie_t cookie)
 static const struct attribute_group *ufshcd_driver_groups[] = {
 	&ufs_sysfs_unit_descriptor_group,
 	&ufs_sysfs_lun_attributes_group,
-#ifdef CONFIG_SCSI_UFS_HPB
-	&ufs_sysfs_hpb_stat_group,
-	&ufs_sysfs_hpb_param_group,
-#endif
 	NULL,
 };
 
@@ -8827,8 +8761,6 @@ static int __ufshcd_wl_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 		req_link_state = UIC_LINK_OFF_STATE;
 	}
 
-	ufshpb_suspend(hba);
-
 	/*
 	 * If we can't transition into any of the low power modes
 	 * just gate the clocks.
@@ -8952,7 +8884,6 @@ static int __ufshcd_wl_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 		ufshcd_update_evt_hist(hba, UFS_EVT_WL_SUSP_ERR, (u32)ret);
 		hba->clk_gating.is_suspended = false;
 		ufshcd_release(hba);
-		ufshpb_resume(hba);
 	}
 	hba->pm_op_in_progress = false;
 	return ret;
@@ -9031,8 +8962,6 @@ static int __ufshcd_wl_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 
 	/* Enable Auto-Hibernate if configured */
 	ufshcd_auto_hibern8_enable(hba);
-
-	ufshpb_resume(hba);
 	goto out;
 
 set_old_link_state:
@@ -9384,7 +9313,6 @@ void ufshcd_remove(struct ufs_hba *hba)
 	if (hba->sdev_ufs_device)
 		ufshcd_rpm_get_sync(hba);
 	ufs_bsg_remove(hba);
-	ufshpb_remove(hba);
 	ufs_sysfs_remove_nodes(hba->dev);
 	blk_cleanup_queue(hba->tmf_queue);
 	blk_mq_free_tag_set(&hba->tmf_tag_set);
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 41f6e06f91856..69f810b8c27ad 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -662,31 +662,6 @@ struct ufs_hba_variant_params {
 	u32 wb_flush_threshold;
 };
 
-#ifdef CONFIG_SCSI_UFS_HPB
-/**
- * struct ufshpb_dev_info - UFSHPB device related info
- * @num_lu: the number of user logical unit to check whether all lu finished
- *          initialization
- * @rgn_size: device reported HPB region size
- * @srgn_size: device reported HPB sub-region size
- * @slave_conf_cnt: counter to check all lu finished initialization
- * @hpb_disabled: flag to check if HPB is disabled
- * @max_hpb_single_cmd: device reported bMAX_DATA_SIZE_FOR_SINGLE_CMD value
- * @is_legacy: flag to check HPB 1.0
- * @control_mode: either host or device
- */
-struct ufshpb_dev_info {
-	int num_lu;
-	int rgn_size;
-	int srgn_size;
-	atomic_t slave_conf_cnt;
-	bool hpb_disabled;
-	u8 max_hpb_single_cmd;
-	bool is_legacy;
-	u8 control_mode;
-};
-#endif
-
 struct ufs_hba_monitor {
 	unsigned long chunk_size;
 
@@ -901,10 +876,6 @@ struct ufs_hba {
 	struct request_queue	*bsg_queue;
 	struct delayed_work rpm_dev_flush_recheck_work;
 
-#ifdef CONFIG_SCSI_UFS_HPB
-	struct ufshpb_dev_info ufshpb_dev;
-#endif
-
 	struct ufs_hba_monitor	monitor;
 
 #ifdef CONFIG_SCSI_UFS_CRYPTO
@@ -1145,9 +1116,6 @@ int ufshcd_read_desc_param(struct ufs_hba *hba,
 			   u8 param_offset,
 			   u8 *param_read_buf,
 			   u8 param_size);
-int ufshcd_query_attr_retry(struct ufs_hba *hba, enum query_opcode opcode,
-			    enum attr_idn idn, u8 index, u8 selector,
-			    u32 *attr_val);
 int ufshcd_query_attr(struct ufs_hba *hba, enum query_opcode opcode,
 		      enum attr_idn idn, u8 index, u8 selector, u32 *attr_val);
 int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
diff --git a/drivers/scsi/ufs/ufshpb.c b/drivers/scsi/ufs/ufshpb.c
deleted file mode 100644
index 589af5f6b940a..0000000000000
--- a/drivers/scsi/ufs/ufshpb.c
+++ /dev/null
@@ -1,2931 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Universal Flash Storage Host Performance Booster
- *
- * Copyright (C) 2017-2021 Samsung Electronics Co., Ltd.
- *
- * Authors:
- *	Yongmyung Lee <ymhungry.lee@samsung.com>
- *	Jinyoung Choi <j-young.choi@samsung.com>
- */
-
-#include <asm/unaligned.h>
-#include <linux/async.h>
-
-#include "ufshcd.h"
-#include "ufshpb.h"
-#include "../sd.h"
-
-#define ACTIVATION_THRESHOLD 8 /* 8 IOs */
-#define READ_TO_MS 1000
-#define READ_TO_EXPIRIES 100
-#define POLLING_INTERVAL_MS 200
-#define THROTTLE_MAP_REQ_DEFAULT 1
-
-/* memory management */
-static struct kmem_cache *ufshpb_mctx_cache;
-static mempool_t *ufshpb_mctx_pool;
-static mempool_t *ufshpb_page_pool;
-/* A cache size of 2MB can cache ppn in the 1GB range. */
-static unsigned int ufshpb_host_map_kbytes = 2048;
-static int tot_active_srgn_pages;
-
-static struct workqueue_struct *ufshpb_wq;
-
-static void ufshpb_update_active_info(struct ufshpb_lu *hpb, int rgn_idx,
-				      int srgn_idx);
-
-bool ufshpb_is_allowed(struct ufs_hba *hba)
-{
-	return !(hba->ufshpb_dev.hpb_disabled);
-}
-
-/* HPB version 1.0 is called as legacy version. */
-bool ufshpb_is_legacy(struct ufs_hba *hba)
-{
-	return hba->ufshpb_dev.is_legacy;
-}
-
-static struct ufshpb_lu *ufshpb_get_hpb_data(struct scsi_device *sdev)
-{
-	return sdev->hostdata;
-}
-
-static int ufshpb_get_state(struct ufshpb_lu *hpb)
-{
-	return atomic_read(&hpb->hpb_state);
-}
-
-static void ufshpb_set_state(struct ufshpb_lu *hpb, int state)
-{
-	atomic_set(&hpb->hpb_state, state);
-}
-
-static int ufshpb_is_valid_srgn(struct ufshpb_region *rgn,
-				struct ufshpb_subregion *srgn)
-{
-	return rgn->rgn_state != HPB_RGN_INACTIVE &&
-		srgn->srgn_state == HPB_SRGN_VALID;
-}
-
-static bool ufshpb_is_read_cmd(struct scsi_cmnd *cmd)
-{
-	return req_op(scsi_cmd_to_rq(cmd)) == REQ_OP_READ;
-}
-
-static bool ufshpb_is_write_or_discard(struct scsi_cmnd *cmd)
-{
-	return op_is_write(req_op(scsi_cmd_to_rq(cmd))) ||
-	       op_is_discard(req_op(scsi_cmd_to_rq(cmd)));
-}
-
-static bool ufshpb_is_supported_chunk(struct ufshpb_lu *hpb, int transfer_len)
-{
-	return transfer_len <= hpb->pre_req_max_tr_len;
-}
-
-/*
- * In this driver, WRITE_BUFFER CMD support 36KB (len=9) ~ 1MB (len=256) as
- * default. It is possible to change range of transfer_len through sysfs.
- */
-static inline bool ufshpb_is_required_wb(struct ufshpb_lu *hpb, int len)
-{
-	return len > hpb->pre_req_min_tr_len &&
-	       len <= hpb->pre_req_max_tr_len;
-}
-
-static bool ufshpb_is_general_lun(int lun)
-{
-	return lun < UFS_UPIU_MAX_UNIT_NUM_ID;
-}
-
-static bool ufshpb_is_pinned_region(struct ufshpb_lu *hpb, int rgn_idx)
-{
-	if (hpb->lu_pinned_end != PINNED_NOT_SET &&
-	    rgn_idx >= hpb->lu_pinned_start &&
-	    rgn_idx <= hpb->lu_pinned_end)
-		return true;
-
-	return false;
-}
-
-static void ufshpb_kick_map_work(struct ufshpb_lu *hpb)
-{
-	bool ret = false;
-	unsigned long flags;
-
-	if (ufshpb_get_state(hpb) != HPB_PRESENT)
-		return;
-
-	spin_lock_irqsave(&hpb->rsp_list_lock, flags);
-	if (!list_empty(&hpb->lh_inact_rgn) || !list_empty(&hpb->lh_act_srgn))
-		ret = true;
-	spin_unlock_irqrestore(&hpb->rsp_list_lock, flags);
-
-	if (ret)
-		queue_work(ufshpb_wq, &hpb->map_work);
-}
-
-static bool ufshpb_is_hpb_rsp_valid(struct ufs_hba *hba,
-				    struct ufshcd_lrb *lrbp,
-				    struct utp_hpb_rsp *rsp_field)
-{
-	/* Check HPB_UPDATE_ALERT */
-	if (!(lrbp->ucd_rsp_ptr->header.dword_2 &
-	      UPIU_HEADER_DWORD(0, 2, 0, 0)))
-		return false;
-
-	if (be16_to_cpu(rsp_field->sense_data_len) != DEV_SENSE_SEG_LEN ||
-	    rsp_field->desc_type != DEV_DES_TYPE ||
-	    rsp_field->additional_len != DEV_ADDITIONAL_LEN ||
-	    rsp_field->active_rgn_cnt > MAX_ACTIVE_NUM ||
-	    rsp_field->inactive_rgn_cnt > MAX_INACTIVE_NUM ||
-	    rsp_field->hpb_op == HPB_RSP_NONE ||
-	    (rsp_field->hpb_op == HPB_RSP_REQ_REGION_UPDATE &&
-	     !rsp_field->active_rgn_cnt && !rsp_field->inactive_rgn_cnt))
-		return false;
-
-	if (!ufshpb_is_general_lun(rsp_field->lun)) {
-		dev_warn(hba->dev, "ufshpb: lun(%d) not supported\n",
-			 lrbp->lun);
-		return false;
-	}
-
-	return true;
-}
-
-static void ufshpb_iterate_rgn(struct ufshpb_lu *hpb, int rgn_idx, int srgn_idx,
-			       int srgn_offset, int cnt, bool set_dirty)
-{
-	struct ufshpb_region *rgn;
-	struct ufshpb_subregion *srgn, *prev_srgn = NULL;
-	int set_bit_len;
-	int bitmap_len;
-	unsigned long flags;
-
-next_srgn:
-	rgn = hpb->rgn_tbl + rgn_idx;
-	srgn = rgn->srgn_tbl + srgn_idx;
-
-	if (likely(!srgn->is_last))
-		bitmap_len = hpb->entries_per_srgn;
-	else
-		bitmap_len = hpb->last_srgn_entries;
-
-	if ((srgn_offset + cnt) > bitmap_len)
-		set_bit_len = bitmap_len - srgn_offset;
-	else
-		set_bit_len = cnt;
-
-	spin_lock_irqsave(&hpb->rgn_state_lock, flags);
-	if (rgn->rgn_state != HPB_RGN_INACTIVE) {
-		if (set_dirty) {
-			if (srgn->srgn_state == HPB_SRGN_VALID)
-				bitmap_set(srgn->mctx->ppn_dirty, srgn_offset,
-					   set_bit_len);
-		} else if (hpb->is_hcm) {
-			 /* rewind the read timer for lru regions */
-			rgn->read_timeout = ktime_add_ms(ktime_get(),
-					rgn->hpb->params.read_timeout_ms);
-			rgn->read_timeout_expiries =
-				rgn->hpb->params.read_timeout_expiries;
-		}
-	}
-	spin_unlock_irqrestore(&hpb->rgn_state_lock, flags);
-
-	if (hpb->is_hcm && prev_srgn != srgn) {
-		bool activate = false;
-
-		spin_lock(&rgn->rgn_lock);
-		if (set_dirty) {
-			rgn->reads -= srgn->reads;
-			srgn->reads = 0;
-			set_bit(RGN_FLAG_DIRTY, &rgn->rgn_flags);
-		} else {
-			srgn->reads++;
-			rgn->reads++;
-			if (srgn->reads == hpb->params.activation_thld)
-				activate = true;
-		}
-		spin_unlock(&rgn->rgn_lock);
-
-		if (activate ||
-		    test_and_clear_bit(RGN_FLAG_UPDATE, &rgn->rgn_flags)) {
-			spin_lock_irqsave(&hpb->rsp_list_lock, flags);
-			ufshpb_update_active_info(hpb, rgn_idx, srgn_idx);
-			spin_unlock_irqrestore(&hpb->rsp_list_lock, flags);
-			dev_dbg(&hpb->sdev_ufs_lu->sdev_dev,
-				"activate region %d-%d\n", rgn_idx, srgn_idx);
-		}
-
-		prev_srgn = srgn;
-	}
-
-	srgn_offset = 0;
-	if (++srgn_idx == hpb->srgns_per_rgn) {
-		srgn_idx = 0;
-		rgn_idx++;
-	}
-
-	cnt -= set_bit_len;
-	if (cnt > 0)
-		goto next_srgn;
-}
-
-static bool ufshpb_test_ppn_dirty(struct ufshpb_lu *hpb, int rgn_idx,
-				  int srgn_idx, int srgn_offset, int cnt)
-{
-	struct ufshpb_region *rgn;
-	struct ufshpb_subregion *srgn;
-	int bitmap_len;
-	int bit_len;
-
-next_srgn:
-	rgn = hpb->rgn_tbl + rgn_idx;
-	srgn = rgn->srgn_tbl + srgn_idx;
-
-	if (likely(!srgn->is_last))
-		bitmap_len = hpb->entries_per_srgn;
-	else
-		bitmap_len = hpb->last_srgn_entries;
-
-	if (!ufshpb_is_valid_srgn(rgn, srgn))
-		return true;
-
-	/*
-	 * If the region state is active, mctx must be allocated.
-	 * In this case, check whether the region is evicted or
-	 * mctx allocation fail.
-	 */
-	if (unlikely(!srgn->mctx)) {
-		dev_err(&hpb->sdev_ufs_lu->sdev_dev,
-			"no mctx in region %d subregion %d.\n",
-			srgn->rgn_idx, srgn->srgn_idx);
-		return true;
-	}
-
-	if ((srgn_offset + cnt) > bitmap_len)
-		bit_len = bitmap_len - srgn_offset;
-	else
-		bit_len = cnt;
-
-	if (find_next_bit(srgn->mctx->ppn_dirty, bit_len + srgn_offset,
-			  srgn_offset) < bit_len + srgn_offset)
-		return true;
-
-	srgn_offset = 0;
-	if (++srgn_idx == hpb->srgns_per_rgn) {
-		srgn_idx = 0;
-		rgn_idx++;
-	}
-
-	cnt -= bit_len;
-	if (cnt > 0)
-		goto next_srgn;
-
-	return false;
-}
-
-static inline bool is_rgn_dirty(struct ufshpb_region *rgn)
-{
-	return test_bit(RGN_FLAG_DIRTY, &rgn->rgn_flags);
-}
-
-static int ufshpb_fill_ppn_from_page(struct ufshpb_lu *hpb,
-				     struct ufshpb_map_ctx *mctx, int pos,
-				     int len, __be64 *ppn_buf)
-{
-	struct page *page;
-	int index, offset;
-	int copied;
-
-	index = pos / (PAGE_SIZE / HPB_ENTRY_SIZE);
-	offset = pos % (PAGE_SIZE / HPB_ENTRY_SIZE);
-
-	if ((offset + len) <= (PAGE_SIZE / HPB_ENTRY_SIZE))
-		copied = len;
-	else
-		copied = (PAGE_SIZE / HPB_ENTRY_SIZE) - offset;
-
-	page = mctx->m_page[index];
-	if (unlikely(!page)) {
-		dev_err(&hpb->sdev_ufs_lu->sdev_dev,
-			"error. cannot find page in mctx\n");
-		return -ENOMEM;
-	}
-
-	memcpy(ppn_buf, page_address(page) + (offset * HPB_ENTRY_SIZE),
-	       copied * HPB_ENTRY_SIZE);
-
-	return copied;
-}
-
-static void
-ufshpb_get_pos_from_lpn(struct ufshpb_lu *hpb, unsigned long lpn, int *rgn_idx,
-			int *srgn_idx, int *offset)
-{
-	int rgn_offset;
-
-	*rgn_idx = lpn >> hpb->entries_per_rgn_shift;
-	rgn_offset = lpn & hpb->entries_per_rgn_mask;
-	*srgn_idx = rgn_offset >> hpb->entries_per_srgn_shift;
-	*offset = rgn_offset & hpb->entries_per_srgn_mask;
-}
-
-static void
-ufshpb_set_hpb_read_to_upiu(struct ufs_hba *hba, struct ufshcd_lrb *lrbp,
-			    __be64 ppn, u8 transfer_len, int read_id)
-{
-	unsigned char *cdb = lrbp->cmd->cmnd;
-	__be64 ppn_tmp = ppn;
-	cdb[0] = UFSHPB_READ;
-
-	if (hba->dev_quirks & UFS_DEVICE_QUIRK_SWAP_L2P_ENTRY_FOR_HPB_READ)
-		ppn_tmp = swab64(ppn);
-
-	/* ppn value is stored as big-endian in the host memory */
-	memcpy(&cdb[6], &ppn_tmp, sizeof(__be64));
-	cdb[14] = transfer_len;
-	cdb[15] = read_id;
-
-	lrbp->cmd->cmd_len = UFS_CDB_SIZE;
-}
-
-static inline void ufshpb_set_write_buf_cmd(unsigned char *cdb,
-					    unsigned long lpn, unsigned int len,
-					    int read_id)
-{
-	cdb[0] = UFSHPB_WRITE_BUFFER;
-	cdb[1] = UFSHPB_WRITE_BUFFER_PREFETCH_ID;
-
-	put_unaligned_be32(lpn, &cdb[2]);
-	cdb[6] = read_id;
-	put_unaligned_be16(len * HPB_ENTRY_SIZE, &cdb[7]);
-
-	cdb[9] = 0x00;	/* Control = 0x00 */
-}
-
-static struct ufshpb_req *ufshpb_get_pre_req(struct ufshpb_lu *hpb)
-{
-	struct ufshpb_req *pre_req;
-
-	if (hpb->num_inflight_pre_req >= hpb->throttle_pre_req) {
-		dev_info(&hpb->sdev_ufs_lu->sdev_dev,
-			 "pre_req throttle. inflight %d throttle %d",
-			 hpb->num_inflight_pre_req, hpb->throttle_pre_req);
-		return NULL;
-	}
-
-	pre_req = list_first_entry_or_null(&hpb->lh_pre_req_free,
-					   struct ufshpb_req, list_req);
-	if (!pre_req) {
-		dev_info(&hpb->sdev_ufs_lu->sdev_dev, "There is no pre_req");
-		return NULL;
-	}
-
-	list_del_init(&pre_req->list_req);
-	hpb->num_inflight_pre_req++;
-
-	return pre_req;
-}
-
-static inline void ufshpb_put_pre_req(struct ufshpb_lu *hpb,
-				      struct ufshpb_req *pre_req)
-{
-	pre_req->req = NULL;
-	bio_reset(pre_req->bio);
-	list_add_tail(&pre_req->list_req, &hpb->lh_pre_req_free);
-	hpb->num_inflight_pre_req--;
-}
-
-static void ufshpb_pre_req_compl_fn(struct request *req, blk_status_t error)
-{
-	struct ufshpb_req *pre_req = (struct ufshpb_req *)req->end_io_data;
-	struct ufshpb_lu *hpb = pre_req->hpb;
-	unsigned long flags;
-
-	if (error) {
-		struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(req);
-		struct scsi_sense_hdr sshdr;
-
-		dev_err(&hpb->sdev_ufs_lu->sdev_dev, "block status %d", error);
-		scsi_command_normalize_sense(cmd, &sshdr);
-		dev_err(&hpb->sdev_ufs_lu->sdev_dev,
-			"code %x sense_key %x asc %x ascq %x",
-			sshdr.response_code,
-			sshdr.sense_key, sshdr.asc, sshdr.ascq);
-		dev_err(&hpb->sdev_ufs_lu->sdev_dev,
-			"byte4 %x byte5 %x byte6 %x additional_len %x",
-			sshdr.byte4, sshdr.byte5,
-			sshdr.byte6, sshdr.additional_length);
-	}
-
-	blk_mq_free_request(req);
-	spin_lock_irqsave(&hpb->rgn_state_lock, flags);
-	ufshpb_put_pre_req(pre_req->hpb, pre_req);
-	spin_unlock_irqrestore(&hpb->rgn_state_lock, flags);
-}
-
-static int ufshpb_prep_entry(struct ufshpb_req *pre_req, struct page *page)
-{
-	struct ufshpb_lu *hpb = pre_req->hpb;
-	struct ufshpb_region *rgn;
-	struct ufshpb_subregion *srgn;
-	__be64 *addr;
-	int offset = 0;
-	int copied;
-	unsigned long lpn = pre_req->wb.lpn;
-	int rgn_idx, srgn_idx, srgn_offset;
-	unsigned long flags;
-
-	addr = page_address(page);
-	ufshpb_get_pos_from_lpn(hpb, lpn, &rgn_idx, &srgn_idx, &srgn_offset);
-
-	spin_lock_irqsave(&hpb->rgn_state_lock, flags);
-
-next_offset:
-	rgn = hpb->rgn_tbl + rgn_idx;
-	srgn = rgn->srgn_tbl + srgn_idx;
-
-	if (!ufshpb_is_valid_srgn(rgn, srgn))
-		goto mctx_error;
-
-	if (!srgn->mctx)
-		goto mctx_error;
-
-	copied = ufshpb_fill_ppn_from_page(hpb, srgn->mctx, srgn_offset,
-					   pre_req->wb.len - offset,
-					   &addr[offset]);
-
-	if (copied < 0)
-		goto mctx_error;
-
-	offset += copied;
-	srgn_offset += copied;
-
-	if (srgn_offset == hpb->entries_per_srgn) {
-		srgn_offset = 0;
-
-		if (++srgn_idx == hpb->srgns_per_rgn) {
-			srgn_idx = 0;
-			rgn_idx++;
-		}
-	}
-
-	if (offset < pre_req->wb.len)
-		goto next_offset;
-
-	spin_unlock_irqrestore(&hpb->rgn_state_lock, flags);
-	return 0;
-mctx_error:
-	spin_unlock_irqrestore(&hpb->rgn_state_lock, flags);
-	return -ENOMEM;
-}
-
-static int ufshpb_pre_req_add_bio_page(struct ufshpb_lu *hpb,
-				       struct request_queue *q,
-				       struct ufshpb_req *pre_req)
-{
-	struct page *page = pre_req->wb.m_page;
-	struct bio *bio = pre_req->bio;
-	int entries_bytes, ret;
-
-	if (!page)
-		return -ENOMEM;
-
-	if (ufshpb_prep_entry(pre_req, page))
-		return -ENOMEM;
-
-	entries_bytes = pre_req->wb.len * sizeof(__be64);
-
-	ret = bio_add_pc_page(q, bio, page, entries_bytes, 0);
-	if (ret != entries_bytes) {
-		dev_err(&hpb->sdev_ufs_lu->sdev_dev,
-			"bio_add_pc_page fail: %d", ret);
-		return -ENOMEM;
-	}
-	return 0;
-}
-
-static inline int ufshpb_get_read_id(struct ufshpb_lu *hpb)
-{
-	if (++hpb->cur_read_id >= MAX_HPB_READ_ID)
-		hpb->cur_read_id = 1;
-	return hpb->cur_read_id;
-}
-
-static int ufshpb_execute_pre_req(struct ufshpb_lu *hpb, struct scsi_cmnd *cmd,
-				  struct ufshpb_req *pre_req, int read_id)
-{
-	struct scsi_device *sdev = cmd->device;
-	struct request_queue *q = sdev->request_queue;
-	struct request *req;
-	struct scsi_request *rq;
-	struct bio *bio = pre_req->bio;
-
-	pre_req->hpb = hpb;
-	pre_req->wb.lpn = sectors_to_logical(cmd->device,
-					     blk_rq_pos(scsi_cmd_to_rq(cmd)));
-	pre_req->wb.len = sectors_to_logical(cmd->device,
-					     blk_rq_sectors(scsi_cmd_to_rq(cmd)));
-	if (ufshpb_pre_req_add_bio_page(hpb, q, pre_req))
-		return -ENOMEM;
-
-	req = pre_req->req;
-
-	/* 1. request setup */
-	blk_rq_append_bio(req, bio);
-	req->rq_disk = NULL;
-	req->end_io_data = (void *)pre_req;
-	req->end_io = ufshpb_pre_req_compl_fn;
-
-	/* 2. scsi_request setup */
-	rq = scsi_req(req);
-	rq->retries = 1;
-
-	ufshpb_set_write_buf_cmd(rq->cmd, pre_req->wb.lpn, pre_req->wb.len,
-				 read_id);
-	rq->cmd_len = scsi_command_size(rq->cmd);
-
-	if (blk_insert_cloned_request(q, req) != BLK_STS_OK)
-		return -EAGAIN;
-
-	hpb->stats.pre_req_cnt++;
-
-	return 0;
-}
-
-static int ufshpb_issue_pre_req(struct ufshpb_lu *hpb, struct scsi_cmnd *cmd,
-				int *read_id)
-{
-	struct ufshpb_req *pre_req;
-	struct request *req = NULL;
-	unsigned long flags;
-	int _read_id;
-	int ret = 0;
-
-	req = blk_get_request(cmd->device->request_queue,
-			      REQ_OP_DRV_OUT | REQ_SYNC, BLK_MQ_REQ_NOWAIT);
-	if (IS_ERR(req))
-		return -EAGAIN;
-
-	spin_lock_irqsave(&hpb->rgn_state_lock, flags);
-	pre_req = ufshpb_get_pre_req(hpb);
-	if (!pre_req) {
-		ret = -EAGAIN;
-		goto unlock_out;
-	}
-	_read_id = ufshpb_get_read_id(hpb);
-	spin_unlock_irqrestore(&hpb->rgn_state_lock, flags);
-
-	pre_req->req = req;
-
-	ret = ufshpb_execute_pre_req(hpb, cmd, pre_req, _read_id);
-	if (ret)
-		goto free_pre_req;
-
-	*read_id = _read_id;
-
-	return ret;
-free_pre_req:
-	spin_lock_irqsave(&hpb->rgn_state_lock, flags);
-	ufshpb_put_pre_req(hpb, pre_req);
-unlock_out:
-	spin_unlock_irqrestore(&hpb->rgn_state_lock, flags);
-	blk_put_request(req);
-	return ret;
-}
-
-/*
- * This function will set up HPB read command using host-side L2P map data.
- */
-int ufshpb_prep(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
-{
-	struct ufshpb_lu *hpb;
-	struct ufshpb_region *rgn;
-	struct ufshpb_subregion *srgn;
-	struct scsi_cmnd *cmd = lrbp->cmd;
-	u32 lpn;
-	__be64 ppn;
-	unsigned long flags;
-	int transfer_len, rgn_idx, srgn_idx, srgn_offset;
-	int read_id = 0;
-	int err = 0;
-
-	hpb = ufshpb_get_hpb_data(cmd->device);
-	if (!hpb)
-		return -ENODEV;
-
-	if (ufshpb_get_state(hpb) == HPB_INIT)
-		return -ENODEV;
-
-	if (ufshpb_get_state(hpb) != HPB_PRESENT) {
-		dev_notice(&hpb->sdev_ufs_lu->sdev_dev,
-			   "%s: ufshpb state is not PRESENT", __func__);
-		return -ENODEV;
-	}
-
-	if (blk_rq_is_passthrough(scsi_cmd_to_rq(cmd)) ||
-	    (!ufshpb_is_write_or_discard(cmd) &&
-	     !ufshpb_is_read_cmd(cmd)))
-		return 0;
-
-	transfer_len = sectors_to_logical(cmd->device,
-					  blk_rq_sectors(scsi_cmd_to_rq(cmd)));
-	if (unlikely(!transfer_len))
-		return 0;
-
-	lpn = sectors_to_logical(cmd->device, blk_rq_pos(scsi_cmd_to_rq(cmd)));
-	ufshpb_get_pos_from_lpn(hpb, lpn, &rgn_idx, &srgn_idx, &srgn_offset);
-	rgn = hpb->rgn_tbl + rgn_idx;
-	srgn = rgn->srgn_tbl + srgn_idx;
-
-	/* If command type is WRITE or DISCARD, set bitmap as drity */
-	if (ufshpb_is_write_or_discard(cmd)) {
-		ufshpb_iterate_rgn(hpb, rgn_idx, srgn_idx, srgn_offset,
-				   transfer_len, true);
-		return 0;
-	}
-
-	if (!ufshpb_is_supported_chunk(hpb, transfer_len))
-		return 0;
-
-	WARN_ON_ONCE(transfer_len > HPB_MULTI_CHUNK_HIGH);
-
-	if (hpb->is_hcm) {
-		/*
-		 * in host control mode, reads are the main source for
-		 * activation trials.
-		 */
-		ufshpb_iterate_rgn(hpb, rgn_idx, srgn_idx, srgn_offset,
-				   transfer_len, false);
-
-		/* keep those counters normalized */
-		if (rgn->reads > hpb->entries_per_srgn)
-			schedule_work(&hpb->ufshpb_normalization_work);
-	}
-
-	spin_lock_irqsave(&hpb->rgn_state_lock, flags);
-	if (ufshpb_test_ppn_dirty(hpb, rgn_idx, srgn_idx, srgn_offset,
-				   transfer_len)) {
-		hpb->stats.miss_cnt++;
-		spin_unlock_irqrestore(&hpb->rgn_state_lock, flags);
-		return 0;
-	}
-
-	err = ufshpb_fill_ppn_from_page(hpb, srgn->mctx, srgn_offset, 1, &ppn);
-	spin_unlock_irqrestore(&hpb->rgn_state_lock, flags);
-	if (unlikely(err < 0)) {
-		/*
-		 * In this case, the region state is active,
-		 * but the ppn table is not allocated.
-		 * Make sure that ppn table must be allocated on
-		 * active state.
-		 */
-		dev_err(hba->dev, "get ppn failed. err %d\n", err);
-		return err;
-	}
-	if (!ufshpb_is_legacy(hba) &&
-	    ufshpb_is_required_wb(hpb, transfer_len)) {
-		err = ufshpb_issue_pre_req(hpb, cmd, &read_id);
-		if (err) {
-			unsigned long timeout;
-
-			timeout = cmd->jiffies_at_alloc + msecs_to_jiffies(
-				  hpb->params.requeue_timeout_ms);
-
-			if (time_before(jiffies, timeout))
-				return -EAGAIN;
-
-			hpb->stats.miss_cnt++;
-			return 0;
-		}
-	}
-
-	ufshpb_set_hpb_read_to_upiu(hba, lrbp, ppn, transfer_len, read_id);
-
-	hpb->stats.hit_cnt++;
-	return 0;
-}
-
-static struct ufshpb_req *ufshpb_get_req(struct ufshpb_lu *hpb,
-					 int rgn_idx, enum req_opf dir,
-					 bool atomic)
-{
-	struct ufshpb_req *rq;
-	struct request *req;
-	int retries = HPB_MAP_REQ_RETRIES;
-
-	rq = kmem_cache_alloc(hpb->map_req_cache, GFP_KERNEL);
-	if (!rq)
-		return NULL;
-
-retry:
-	req = blk_get_request(hpb->sdev_ufs_lu->request_queue, dir,
-			      BLK_MQ_REQ_NOWAIT);
-
-	if (!atomic && (PTR_ERR(req) == -EWOULDBLOCK) && (--retries > 0)) {
-		usleep_range(3000, 3100);
-		goto retry;
-	}
-
-	if (IS_ERR(req))
-		goto free_rq;
-
-	rq->hpb = hpb;
-	rq->req = req;
-	rq->rb.rgn_idx = rgn_idx;
-
-	return rq;
-
-free_rq:
-	kmem_cache_free(hpb->map_req_cache, rq);
-	return NULL;
-}
-
-static void ufshpb_put_req(struct ufshpb_lu *hpb, struct ufshpb_req *rq)
-{
-	blk_put_request(rq->req);
-	kmem_cache_free(hpb->map_req_cache, rq);
-}
-
-static struct ufshpb_req *ufshpb_get_map_req(struct ufshpb_lu *hpb,
-					     struct ufshpb_subregion *srgn)
-{
-	struct ufshpb_req *map_req;
-	struct bio *bio;
-	unsigned long flags;
-
-	if (hpb->is_hcm &&
-	    hpb->num_inflight_map_req >= hpb->params.inflight_map_req) {
-		dev_info(&hpb->sdev_ufs_lu->sdev_dev,
-			 "map_req throttle. inflight %d throttle %d",
-			 hpb->num_inflight_map_req,
-			 hpb->params.inflight_map_req);
-		return NULL;
-	}
-
-	map_req = ufshpb_get_req(hpb, srgn->rgn_idx, REQ_OP_DRV_IN, false);
-	if (!map_req)
-		return NULL;
-
-	bio = bio_alloc(GFP_KERNEL, hpb->pages_per_srgn);
-	if (!bio) {
-		ufshpb_put_req(hpb, map_req);
-		return NULL;
-	}
-
-	map_req->bio = bio;
-
-	map_req->rb.srgn_idx = srgn->srgn_idx;
-	map_req->rb.mctx = srgn->mctx;
-
-	spin_lock_irqsave(&hpb->param_lock, flags);
-	hpb->num_inflight_map_req++;
-	spin_unlock_irqrestore(&hpb->param_lock, flags);
-
-	return map_req;
-}
-
-static void ufshpb_put_map_req(struct ufshpb_lu *hpb,
-			       struct ufshpb_req *map_req)
-{
-	unsigned long flags;
-
-	bio_put(map_req->bio);
-	ufshpb_put_req(hpb, map_req);
-
-	spin_lock_irqsave(&hpb->param_lock, flags);
-	hpb->num_inflight_map_req--;
-	spin_unlock_irqrestore(&hpb->param_lock, flags);
-}
-
-static int ufshpb_clear_dirty_bitmap(struct ufshpb_lu *hpb,
-				     struct ufshpb_subregion *srgn)
-{
-	struct ufshpb_region *rgn;
-	u32 num_entries = hpb->entries_per_srgn;
-
-	if (!srgn->mctx) {
-		dev_err(&hpb->sdev_ufs_lu->sdev_dev,
-			"no mctx in region %d subregion %d.\n",
-			srgn->rgn_idx, srgn->srgn_idx);
-		return -1;
-	}
-
-	if (unlikely(srgn->is_last))
-		num_entries = hpb->last_srgn_entries;
-
-	bitmap_zero(srgn->mctx->ppn_dirty, num_entries);
-
-	rgn = hpb->rgn_tbl + srgn->rgn_idx;
-	clear_bit(RGN_FLAG_DIRTY, &rgn->rgn_flags);
-
-	return 0;
-}
-
-static void ufshpb_update_active_info(struct ufshpb_lu *hpb, int rgn_idx,
-				      int srgn_idx)
-{
-	struct ufshpb_region *rgn;
-	struct ufshpb_subregion *srgn;
-
-	rgn = hpb->rgn_tbl + rgn_idx;
-	srgn = rgn->srgn_tbl + srgn_idx;
-
-	list_del_init(&rgn->list_inact_rgn);
-
-	if (list_empty(&srgn->list_act_srgn))
-		list_add_tail(&srgn->list_act_srgn, &hpb->lh_act_srgn);
-
-	hpb->stats.rb_active_cnt++;
-}
-
-static void ufshpb_update_inactive_info(struct ufshpb_lu *hpb, int rgn_idx)
-{
-	struct ufshpb_region *rgn;
-	struct ufshpb_subregion *srgn;
-	int srgn_idx;
-
-	rgn = hpb->rgn_tbl + rgn_idx;
-
-	for_each_sub_region(rgn, srgn_idx, srgn)
-		list_del_init(&srgn->list_act_srgn);
-
-	if (list_empty(&rgn->list_inact_rgn))
-		list_add_tail(&rgn->list_inact_rgn, &hpb->lh_inact_rgn);
-
-	hpb->stats.rb_inactive_cnt++;
-}
-
-static void ufshpb_activate_subregion(struct ufshpb_lu *hpb,
-				      struct ufshpb_subregion *srgn)
-{
-	struct ufshpb_region *rgn;
-
-	/*
-	 * If there is no mctx in subregion
-	 * after I/O progress for HPB_READ_BUFFER, the region to which the
-	 * subregion belongs was evicted.
-	 * Make sure the region must not evict in I/O progress
-	 */
-	if (!srgn->mctx) {
-		dev_err(&hpb->sdev_ufs_lu->sdev_dev,
-			"no mctx in region %d subregion %d.\n",
-			srgn->rgn_idx, srgn->srgn_idx);
-		srgn->srgn_state = HPB_SRGN_INVALID;
-		return;
-	}
-
-	rgn = hpb->rgn_tbl + srgn->rgn_idx;
-
-	if (unlikely(rgn->rgn_state == HPB_RGN_INACTIVE)) {
-		dev_err(&hpb->sdev_ufs_lu->sdev_dev,
-			"region %d subregion %d evicted\n",
-			srgn->rgn_idx, srgn->srgn_idx);
-		srgn->srgn_state = HPB_SRGN_INVALID;
-		return;
-	}
-	srgn->srgn_state = HPB_SRGN_VALID;
-}
-
-static void ufshpb_umap_req_compl_fn(struct request *req, blk_status_t error)
-{
-	struct ufshpb_req *umap_req = (struct ufshpb_req *)req->end_io_data;
-
-	ufshpb_put_req(umap_req->hpb, umap_req);
-}
-
-static void ufshpb_map_req_compl_fn(struct request *req, blk_status_t error)
-{
-	struct ufshpb_req *map_req = (struct ufshpb_req *) req->end_io_data;
-	struct ufshpb_lu *hpb = map_req->hpb;
-	struct ufshpb_subregion *srgn;
-	unsigned long flags;
-
-	srgn = hpb->rgn_tbl[map_req->rb.rgn_idx].srgn_tbl +
-		map_req->rb.srgn_idx;
-
-	ufshpb_clear_dirty_bitmap(hpb, srgn);
-	spin_lock_irqsave(&hpb->rgn_state_lock, flags);
-	ufshpb_activate_subregion(hpb, srgn);
-	spin_unlock_irqrestore(&hpb->rgn_state_lock, flags);
-
-	ufshpb_put_map_req(map_req->hpb, map_req);
-}
-
-static void ufshpb_set_unmap_cmd(unsigned char *cdb, struct ufshpb_region *rgn)
-{
-	cdb[0] = UFSHPB_WRITE_BUFFER;
-	cdb[1] = rgn ? UFSHPB_WRITE_BUFFER_INACT_SINGLE_ID :
-			  UFSHPB_WRITE_BUFFER_INACT_ALL_ID;
-	if (rgn)
-		put_unaligned_be16(rgn->rgn_idx, &cdb[2]);
-	cdb[9] = 0x00;
-}
-
-static void ufshpb_set_read_buf_cmd(unsigned char *cdb, int rgn_idx,
-				    int srgn_idx, int srgn_mem_size)
-{
-	cdb[0] = UFSHPB_READ_BUFFER;
-	cdb[1] = UFSHPB_READ_BUFFER_ID;
-
-	put_unaligned_be16(rgn_idx, &cdb[2]);
-	put_unaligned_be16(srgn_idx, &cdb[4]);
-	put_unaligned_be24(srgn_mem_size, &cdb[6]);
-
-	cdb[9] = 0x00;
-}
-
-static void ufshpb_execute_umap_req(struct ufshpb_lu *hpb,
-				   struct ufshpb_req *umap_req,
-				   struct ufshpb_region *rgn)
-{
-	struct request *req;
-	struct scsi_request *rq;
-
-	req = umap_req->req;
-	req->timeout = 0;
-	req->end_io_data = (void *)umap_req;
-	rq = scsi_req(req);
-	ufshpb_set_unmap_cmd(rq->cmd, rgn);
-	rq->cmd_len = HPB_WRITE_BUFFER_CMD_LENGTH;
-
-	blk_execute_rq_nowait(NULL, req, 1, ufshpb_umap_req_compl_fn);
-
-	hpb->stats.umap_req_cnt++;
-}
-
-static int ufshpb_execute_map_req(struct ufshpb_lu *hpb,
-				  struct ufshpb_req *map_req, bool last)
-{
-	struct request_queue *q;
-	struct request *req;
-	struct scsi_request *rq;
-	int mem_size = hpb->srgn_mem_size;
-	int ret = 0;
-	int i;
-
-	q = hpb->sdev_ufs_lu->request_queue;
-	for (i = 0; i < hpb->pages_per_srgn; i++) {
-		ret = bio_add_pc_page(q, map_req->bio, map_req->rb.mctx->m_page[i],
-				      PAGE_SIZE, 0);
-		if (ret != PAGE_SIZE) {
-			dev_err(&hpb->sdev_ufs_lu->sdev_dev,
-				   "bio_add_pc_page fail %d - %d\n",
-				   map_req->rb.rgn_idx, map_req->rb.srgn_idx);
-			return ret;
-		}
-	}
-
-	req = map_req->req;
-
-	blk_rq_append_bio(req, map_req->bio);
-
-	req->end_io_data = map_req;
-
-	rq = scsi_req(req);
-
-	if (unlikely(last))
-		mem_size = hpb->last_srgn_entries * HPB_ENTRY_SIZE;
-
-	ufshpb_set_read_buf_cmd(rq->cmd, map_req->rb.rgn_idx,
-				map_req->rb.srgn_idx, mem_size);
-	rq->cmd_len = HPB_READ_BUFFER_CMD_LENGTH;
-
-	blk_execute_rq_nowait(NULL, req, 1, ufshpb_map_req_compl_fn);
-
-	hpb->stats.map_req_cnt++;
-	return 0;
-}
-
-static struct ufshpb_map_ctx *ufshpb_get_map_ctx(struct ufshpb_lu *hpb,
-						 bool last)
-{
-	struct ufshpb_map_ctx *mctx;
-	u32 num_entries = hpb->entries_per_srgn;
-	int i, j;
-
-	mctx = mempool_alloc(ufshpb_mctx_pool, GFP_KERNEL);
-	if (!mctx)
-		return NULL;
-
-	mctx->m_page = kmem_cache_alloc(hpb->m_page_cache, GFP_KERNEL);
-	if (!mctx->m_page)
-		goto release_mctx;
-
-	if (unlikely(last))
-		num_entries = hpb->last_srgn_entries;
-
-	mctx->ppn_dirty = bitmap_zalloc(num_entries, GFP_KERNEL);
-	if (!mctx->ppn_dirty)
-		goto release_m_page;
-
-	for (i = 0; i < hpb->pages_per_srgn; i++) {
-		mctx->m_page[i] = mempool_alloc(ufshpb_page_pool, GFP_KERNEL);
-		if (!mctx->m_page[i]) {
-			for (j = 0; j < i; j++)
-				mempool_free(mctx->m_page[j], ufshpb_page_pool);
-			goto release_ppn_dirty;
-		}
-		clear_page(page_address(mctx->m_page[i]));
-	}
-
-	return mctx;
-
-release_ppn_dirty:
-	bitmap_free(mctx->ppn_dirty);
-release_m_page:
-	kmem_cache_free(hpb->m_page_cache, mctx->m_page);
-release_mctx:
-	mempool_free(mctx, ufshpb_mctx_pool);
-	return NULL;
-}
-
-static void ufshpb_put_map_ctx(struct ufshpb_lu *hpb,
-			       struct ufshpb_map_ctx *mctx)
-{
-	int i;
-
-	for (i = 0; i < hpb->pages_per_srgn; i++)
-		mempool_free(mctx->m_page[i], ufshpb_page_pool);
-
-	bitmap_free(mctx->ppn_dirty);
-	kmem_cache_free(hpb->m_page_cache, mctx->m_page);
-	mempool_free(mctx, ufshpb_mctx_pool);
-}
-
-static int ufshpb_check_srgns_issue_state(struct ufshpb_lu *hpb,
-					  struct ufshpb_region *rgn)
-{
-	struct ufshpb_subregion *srgn;
-	int srgn_idx;
-
-	for_each_sub_region(rgn, srgn_idx, srgn)
-		if (srgn->srgn_state == HPB_SRGN_ISSUED)
-			return -EPERM;
-
-	return 0;
-}
-
-static void ufshpb_read_to_handler(struct work_struct *work)
-{
-	struct ufshpb_lu *hpb = container_of(work, struct ufshpb_lu,
-					     ufshpb_read_to_work.work);
-	struct victim_select_info *lru_info = &hpb->lru_info;
-	struct ufshpb_region *rgn, *next_rgn;
-	unsigned long flags;
-	unsigned int poll;
-	LIST_HEAD(expired_list);
-
-	if (test_and_set_bit(TIMEOUT_WORK_RUNNING, &hpb->work_data_bits))
-		return;
-
-	spin_lock_irqsave(&hpb->rgn_state_lock, flags);
-
-	list_for_each_entry_safe(rgn, next_rgn, &lru_info->lh_lru_rgn,
-				 list_lru_rgn) {
-		bool timedout = ktime_after(ktime_get(), rgn->read_timeout);
-
-		if (timedout) {
-			rgn->read_timeout_expiries--;
-			if (is_rgn_dirty(rgn) ||
-			    rgn->read_timeout_expiries == 0)
-				list_add(&rgn->list_expired_rgn, &expired_list);
-			else
-				rgn->read_timeout = ktime_add_ms(ktime_get(),
-						hpb->params.read_timeout_ms);
-		}
-	}
-
-	spin_unlock_irqrestore(&hpb->rgn_state_lock, flags);
-
-	list_for_each_entry_safe(rgn, next_rgn, &expired_list,
-				 list_expired_rgn) {
-		list_del_init(&rgn->list_expired_rgn);
-		spin_lock_irqsave(&hpb->rsp_list_lock, flags);
-		ufshpb_update_inactive_info(hpb, rgn->rgn_idx);
-		spin_unlock_irqrestore(&hpb->rsp_list_lock, flags);
-	}
-
-	ufshpb_kick_map_work(hpb);
-
-	clear_bit(TIMEOUT_WORK_RUNNING, &hpb->work_data_bits);
-
-	poll = hpb->params.timeout_polling_interval_ms;
-	schedule_delayed_work(&hpb->ufshpb_read_to_work,
-			      msecs_to_jiffies(poll));
-}
-
-static void ufshpb_add_lru_info(struct victim_select_info *lru_info,
-				struct ufshpb_region *rgn)
-{
-	rgn->rgn_state = HPB_RGN_ACTIVE;
-	list_add_tail(&rgn->list_lru_rgn, &lru_info->lh_lru_rgn);
-	atomic_inc(&lru_info->active_cnt);
-	if (rgn->hpb->is_hcm) {
-		rgn->read_timeout =
-			ktime_add_ms(ktime_get(),
-				     rgn->hpb->params.read_timeout_ms);
-		rgn->read_timeout_expiries =
-			rgn->hpb->params.read_timeout_expiries;
-	}
-}
-
-static void ufshpb_hit_lru_info(struct victim_select_info *lru_info,
-				struct ufshpb_region *rgn)
-{
-	list_move_tail(&rgn->list_lru_rgn, &lru_info->lh_lru_rgn);
-}
-
-static struct ufshpb_region *ufshpb_victim_lru_info(struct ufshpb_lu *hpb)
-{
-	struct victim_select_info *lru_info = &hpb->lru_info;
-	struct ufshpb_region *rgn, *victim_rgn = NULL;
-
-	list_for_each_entry(rgn, &lru_info->lh_lru_rgn, list_lru_rgn) {
-		if (!rgn) {
-			dev_err(&hpb->sdev_ufs_lu->sdev_dev,
-				"%s: no region allocated\n",
-				__func__);
-			return NULL;
-		}
-		if (ufshpb_check_srgns_issue_state(hpb, rgn))
-			continue;
-
-		/*
-		 * in host control mode, verify that the exiting region
-		 * has fewer reads
-		 */
-		if (hpb->is_hcm &&
-		    rgn->reads > hpb->params.eviction_thld_exit)
-			continue;
-
-		victim_rgn = rgn;
-		break;
-	}
-
-	return victim_rgn;
-}
-
-static void ufshpb_cleanup_lru_info(struct victim_select_info *lru_info,
-				    struct ufshpb_region *rgn)
-{
-	list_del_init(&rgn->list_lru_rgn);
-	rgn->rgn_state = HPB_RGN_INACTIVE;
-	atomic_dec(&lru_info->active_cnt);
-}
-
-static void ufshpb_purge_active_subregion(struct ufshpb_lu *hpb,
-					  struct ufshpb_subregion *srgn)
-{
-	if (srgn->srgn_state != HPB_SRGN_UNUSED) {
-		ufshpb_put_map_ctx(hpb, srgn->mctx);
-		srgn->srgn_state = HPB_SRGN_UNUSED;
-		srgn->mctx = NULL;
-	}
-}
-
-static int ufshpb_issue_umap_req(struct ufshpb_lu *hpb,
-				 struct ufshpb_region *rgn,
-				 bool atomic)
-{
-	struct ufshpb_req *umap_req;
-	int rgn_idx = rgn ? rgn->rgn_idx : 0;
-
-	umap_req = ufshpb_get_req(hpb, rgn_idx, REQ_OP_DRV_OUT, atomic);
-	if (!umap_req)
-		return -ENOMEM;
-
-	ufshpb_execute_umap_req(hpb, umap_req, rgn);
-
-	return 0;
-}
-
-static int ufshpb_issue_umap_single_req(struct ufshpb_lu *hpb,
-					struct ufshpb_region *rgn)
-{
-	return ufshpb_issue_umap_req(hpb, rgn, true);
-}
-
-static int ufshpb_issue_umap_all_req(struct ufshpb_lu *hpb)
-{
-	return ufshpb_issue_umap_req(hpb, NULL, false);
-}
-
-static void __ufshpb_evict_region(struct ufshpb_lu *hpb,
-				 struct ufshpb_region *rgn)
-{
-	struct victim_select_info *lru_info;
-	struct ufshpb_subregion *srgn;
-	int srgn_idx;
-
-	lru_info = &hpb->lru_info;
-
-	dev_dbg(&hpb->sdev_ufs_lu->sdev_dev, "evict region %d\n", rgn->rgn_idx);
-
-	ufshpb_cleanup_lru_info(lru_info, rgn);
-
-	for_each_sub_region(rgn, srgn_idx, srgn)
-		ufshpb_purge_active_subregion(hpb, srgn);
-}
-
-static int ufshpb_evict_region(struct ufshpb_lu *hpb, struct ufshpb_region *rgn)
-{
-	unsigned long flags;
-	int ret = 0;
-
-	spin_lock_irqsave(&hpb->rgn_state_lock, flags);
-	if (rgn->rgn_state == HPB_RGN_PINNED) {
-		dev_warn(&hpb->sdev_ufs_lu->sdev_dev,
-			 "pinned region cannot drop-out. region %d\n",
-			 rgn->rgn_idx);
-		goto out;
-	}
-
-	if (!list_empty(&rgn->list_lru_rgn)) {
-		if (ufshpb_check_srgns_issue_state(hpb, rgn)) {
-			ret = -EBUSY;
-			goto out;
-		}
-
-		if (hpb->is_hcm) {
-			spin_unlock_irqrestore(&hpb->rgn_state_lock, flags);
-			ret = ufshpb_issue_umap_single_req(hpb, rgn);
-			spin_lock_irqsave(&hpb->rgn_state_lock, flags);
-			if (ret)
-				goto out;
-		}
-
-		__ufshpb_evict_region(hpb, rgn);
-	}
-out:
-	spin_unlock_irqrestore(&hpb->rgn_state_lock, flags);
-	return ret;
-}
-
-static int ufshpb_issue_map_req(struct ufshpb_lu *hpb,
-				struct ufshpb_region *rgn,
-				struct ufshpb_subregion *srgn)
-{
-	struct ufshpb_req *map_req;
-	unsigned long flags;
-	int ret;
-	int err = -EAGAIN;
-	bool alloc_required = false;
-	enum HPB_SRGN_STATE state = HPB_SRGN_INVALID;
-
-	spin_lock_irqsave(&hpb->rgn_state_lock, flags);
-
-	if (ufshpb_get_state(hpb) != HPB_PRESENT) {
-		dev_notice(&hpb->sdev_ufs_lu->sdev_dev,
-			   "%s: ufshpb state is not PRESENT\n", __func__);
-		goto unlock_out;
-	}
-
-	if ((rgn->rgn_state == HPB_RGN_INACTIVE) &&
-	    (srgn->srgn_state == HPB_SRGN_INVALID)) {
-		err = 0;
-		goto unlock_out;
-	}
-
-	if (srgn->srgn_state == HPB_SRGN_UNUSED)
-		alloc_required = true;
-
-	/*
-	 * If the subregion is already ISSUED state,
-	 * a specific event (e.g., GC or wear-leveling, etc.) occurs in
-	 * the device and HPB response for map loading is received.
-	 * In this case, after finishing the HPB_READ_BUFFER,
-	 * the next HPB_READ_BUFFER is performed again to obtain the latest
-	 * map data.
-	 */
-	if (srgn->srgn_state == HPB_SRGN_ISSUED)
-		goto unlock_out;
-
-	srgn->srgn_state = HPB_SRGN_ISSUED;
-	spin_unlock_irqrestore(&hpb->rgn_state_lock, flags);
-
-	if (alloc_required) {
-		srgn->mctx = ufshpb_get_map_ctx(hpb, srgn->is_last);
-		if (!srgn->mctx) {
-			dev_err(&hpb->sdev_ufs_lu->sdev_dev,
-			    "get map_ctx failed. region %d - %d\n",
-			    rgn->rgn_idx, srgn->srgn_idx);
-			state = HPB_SRGN_UNUSED;
-			goto change_srgn_state;
-		}
-	}
-
-	map_req = ufshpb_get_map_req(hpb, srgn);
-	if (!map_req)
-		goto change_srgn_state;
-
-
-	ret = ufshpb_execute_map_req(hpb, map_req, srgn->is_last);
-	if (ret) {
-		dev_err(&hpb->sdev_ufs_lu->sdev_dev,
-			   "%s: issue map_req failed: %d, region %d - %d\n",
-			   __func__, ret, srgn->rgn_idx, srgn->srgn_idx);
-		goto free_map_req;
-	}
-	return 0;
-
-free_map_req:
-	ufshpb_put_map_req(hpb, map_req);
-change_srgn_state:
-	spin_lock_irqsave(&hpb->rgn_state_lock, flags);
-	srgn->srgn_state = state;
-unlock_out:
-	spin_unlock_irqrestore(&hpb->rgn_state_lock, flags);
-	return err;
-}
-
-static int ufshpb_add_region(struct ufshpb_lu *hpb, struct ufshpb_region *rgn)
-{
-	struct ufshpb_region *victim_rgn = NULL;
-	struct victim_select_info *lru_info = &hpb->lru_info;
-	unsigned long flags;
-	int ret = 0;
-
-	spin_lock_irqsave(&hpb->rgn_state_lock, flags);
-	/*
-	 * If region belongs to lru_list, just move the region
-	 * to the front of lru list because the state of the region
-	 * is already active-state.
-	 */
-	if (!list_empty(&rgn->list_lru_rgn)) {
-		ufshpb_hit_lru_info(lru_info, rgn);
-		goto out;
-	}
-
-	if (rgn->rgn_state == HPB_RGN_INACTIVE) {
-		if (atomic_read(&lru_info->active_cnt) ==
-		    lru_info->max_lru_active_cnt) {
-			/*
-			 * If the maximum number of active regions
-			 * is exceeded, evict the least recently used region.
-			 * This case may occur when the device responds
-			 * to the eviction information late.
-			 * It is okay to evict the least recently used region,
-			 * because the device could detect this region
-			 * by not issuing HPB_READ
-			 *
-			 * in host control mode, verify that the entering
-			 * region has enough reads
-			 */
-			if (hpb->is_hcm &&
-			    rgn->reads < hpb->params.eviction_thld_enter) {
-				ret = -EACCES;
-				goto out;
-			}
-
-			victim_rgn = ufshpb_victim_lru_info(hpb);
-			if (!victim_rgn) {
-				dev_warn(&hpb->sdev_ufs_lu->sdev_dev,
-				    "cannot get victim region %s\n",
-				    hpb->is_hcm ? "" : "error");
-				ret = -ENOMEM;
-				goto out;
-			}
-
-			dev_dbg(&hpb->sdev_ufs_lu->sdev_dev,
-				"LRU full (%d), choose victim %d\n",
-				atomic_read(&lru_info->active_cnt),
-				victim_rgn->rgn_idx);
-
-			if (hpb->is_hcm) {
-				spin_unlock_irqrestore(&hpb->rgn_state_lock,
-						       flags);
-				ret = ufshpb_issue_umap_single_req(hpb,
-								victim_rgn);
-				spin_lock_irqsave(&hpb->rgn_state_lock,
-						  flags);
-				if (ret)
-					goto out;
-			}
-
-			__ufshpb_evict_region(hpb, victim_rgn);
-		}
-
-		/*
-		 * When a region is added to lru_info list_head,
-		 * it is guaranteed that the subregion has been
-		 * assigned all mctx. If failed, try to receive mctx again
-		 * without being added to lru_info list_head
-		 */
-		ufshpb_add_lru_info(lru_info, rgn);
-	}
-out:
-	spin_unlock_irqrestore(&hpb->rgn_state_lock, flags);
-	return ret;
-}
-
-static void ufshpb_rsp_req_region_update(struct ufshpb_lu *hpb,
-					 struct utp_hpb_rsp *rsp_field)
-{
-	struct ufshpb_region *rgn;
-	struct ufshpb_subregion *srgn;
-	int i, rgn_i, srgn_i;
-
-	BUILD_BUG_ON(sizeof(struct ufshpb_active_field) != HPB_ACT_FIELD_SIZE);
-	/*
-	 * If the active region and the inactive region are the same,
-	 * we will inactivate this region.
-	 * The device could check this (region inactivated) and
-	 * will response the proper active region information
-	 */
-	for (i = 0; i < rsp_field->active_rgn_cnt; i++) {
-		rgn_i =
-			be16_to_cpu(rsp_field->hpb_active_field[i].active_rgn);
-		srgn_i =
-			be16_to_cpu(rsp_field->hpb_active_field[i].active_srgn);
-
-		rgn = hpb->rgn_tbl + rgn_i;
-		if (hpb->is_hcm &&
-		    (rgn->rgn_state != HPB_RGN_ACTIVE || is_rgn_dirty(rgn))) {
-			/*
-			 * in host control mode, subregion activation
-			 * recommendations are only allowed to active regions.
-			 * Also, ignore recommendations for dirty regions - the
-			 * host will make decisions concerning those by himself
-			 */
-			continue;
-		}
-
-		dev_dbg(&hpb->sdev_ufs_lu->sdev_dev,
-			"activate(%d) region %d - %d\n", i, rgn_i, srgn_i);
-
-		spin_lock(&hpb->rsp_list_lock);
-		ufshpb_update_active_info(hpb, rgn_i, srgn_i);
-		spin_unlock(&hpb->rsp_list_lock);
-
-		srgn = rgn->srgn_tbl + srgn_i;
-
-		/* blocking HPB_READ */
-		spin_lock(&hpb->rgn_state_lock);
-		if (srgn->srgn_state == HPB_SRGN_VALID)
-			srgn->srgn_state = HPB_SRGN_INVALID;
-		spin_unlock(&hpb->rgn_state_lock);
-	}
-
-	if (hpb->is_hcm) {
-		/*
-		 * in host control mode the device is not allowed to inactivate
-		 * regions
-		 */
-		goto out;
-	}
-
-	for (i = 0; i < rsp_field->inactive_rgn_cnt; i++) {
-		rgn_i = be16_to_cpu(rsp_field->hpb_inactive_field[i]);
-		dev_dbg(&hpb->sdev_ufs_lu->sdev_dev,
-			"inactivate(%d) region %d\n", i, rgn_i);
-
-		spin_lock(&hpb->rsp_list_lock);
-		ufshpb_update_inactive_info(hpb, rgn_i);
-		spin_unlock(&hpb->rsp_list_lock);
-
-		rgn = hpb->rgn_tbl + rgn_i;
-
-		spin_lock(&hpb->rgn_state_lock);
-		if (rgn->rgn_state != HPB_RGN_INACTIVE) {
-			for (srgn_i = 0; srgn_i < rgn->srgn_cnt; srgn_i++) {
-				srgn = rgn->srgn_tbl + srgn_i;
-				if (srgn->srgn_state == HPB_SRGN_VALID)
-					srgn->srgn_state = HPB_SRGN_INVALID;
-			}
-		}
-		spin_unlock(&hpb->rgn_state_lock);
-
-	}
-
-out:
-	dev_dbg(&hpb->sdev_ufs_lu->sdev_dev, "Noti: #ACT %u #INACT %u\n",
-		rsp_field->active_rgn_cnt, rsp_field->inactive_rgn_cnt);
-
-	if (ufshpb_get_state(hpb) == HPB_PRESENT)
-		queue_work(ufshpb_wq, &hpb->map_work);
-}
-
-static void ufshpb_dev_reset_handler(struct ufshpb_lu *hpb)
-{
-	struct victim_select_info *lru_info = &hpb->lru_info;
-	struct ufshpb_region *rgn;
-	unsigned long flags;
-
-	spin_lock_irqsave(&hpb->rgn_state_lock, flags);
-
-	list_for_each_entry(rgn, &lru_info->lh_lru_rgn, list_lru_rgn)
-		set_bit(RGN_FLAG_UPDATE, &rgn->rgn_flags);
-
-	spin_unlock_irqrestore(&hpb->rgn_state_lock, flags);
-}
-
-/*
- * This function will parse recommended active subregion information in sense
- * data field of response UPIU with SAM_STAT_GOOD state.
- */
-void ufshpb_rsp_upiu(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
-{
-	struct ufshpb_lu *hpb = ufshpb_get_hpb_data(lrbp->cmd->device);
-	struct utp_hpb_rsp *rsp_field = &lrbp->ucd_rsp_ptr->hr;
-	int data_seg_len;
-
-	if (unlikely(lrbp->lun != rsp_field->lun)) {
-		struct scsi_device *sdev;
-		bool found = false;
-
-		__shost_for_each_device(sdev, hba->host) {
-			hpb = ufshpb_get_hpb_data(sdev);
-
-			if (!hpb)
-				continue;
-
-			if (rsp_field->lun == hpb->lun) {
-				found = true;
-				break;
-			}
-		}
-
-		if (!found)
-			return;
-	}
-
-	if (!hpb)
-		return;
-
-	if (ufshpb_get_state(hpb) == HPB_INIT)
-		return;
-
-	if ((ufshpb_get_state(hpb) != HPB_PRESENT) &&
-	    (ufshpb_get_state(hpb) != HPB_SUSPEND)) {
-		dev_notice(&hpb->sdev_ufs_lu->sdev_dev,
-			   "%s: ufshpb state is not PRESENT/SUSPEND\n",
-			   __func__);
-		return;
-	}
-
-	data_seg_len = be32_to_cpu(lrbp->ucd_rsp_ptr->header.dword_2)
-		& MASK_RSP_UPIU_DATA_SEG_LEN;
-
-	/* To flush remained rsp_list, we queue the map_work task */
-	if (!data_seg_len) {
-		if (!ufshpb_is_general_lun(hpb->lun))
-			return;
-
-		ufshpb_kick_map_work(hpb);
-		return;
-	}
-
-	BUILD_BUG_ON(sizeof(struct utp_hpb_rsp) != UTP_HPB_RSP_SIZE);
-
-	if (!ufshpb_is_hpb_rsp_valid(hba, lrbp, rsp_field))
-		return;
-
-	hpb->stats.rb_noti_cnt++;
-
-	switch (rsp_field->hpb_op) {
-	case HPB_RSP_REQ_REGION_UPDATE:
-		if (data_seg_len != DEV_DATA_SEG_LEN)
-			dev_warn(&hpb->sdev_ufs_lu->sdev_dev,
-				 "%s: data seg length is not same.\n",
-				 __func__);
-		ufshpb_rsp_req_region_update(hpb, rsp_field);
-		break;
-	case HPB_RSP_DEV_RESET:
-		dev_warn(&hpb->sdev_ufs_lu->sdev_dev,
-			 "UFS device lost HPB information during PM.\n");
-
-		if (hpb->is_hcm) {
-			struct scsi_device *sdev;
-
-			__shost_for_each_device(sdev, hba->host) {
-				struct ufshpb_lu *h = sdev->hostdata;
-
-				if (h)
-					ufshpb_dev_reset_handler(h);
-			}
-		}
-
-		break;
-	default:
-		dev_notice(&hpb->sdev_ufs_lu->sdev_dev,
-			   "hpb_op is not available: %d\n",
-			   rsp_field->hpb_op);
-		break;
-	}
-}
-
-static void ufshpb_add_active_list(struct ufshpb_lu *hpb,
-				   struct ufshpb_region *rgn,
-				   struct ufshpb_subregion *srgn)
-{
-	if (!list_empty(&rgn->list_inact_rgn))
-		return;
-
-	if (!list_empty(&srgn->list_act_srgn)) {
-		list_move(&srgn->list_act_srgn, &hpb->lh_act_srgn);
-		return;
-	}
-
-	list_add(&srgn->list_act_srgn, &hpb->lh_act_srgn);
-}
-
-static void ufshpb_add_pending_evict_list(struct ufshpb_lu *hpb,
-					  struct ufshpb_region *rgn,
-					  struct list_head *pending_list)
-{
-	struct ufshpb_subregion *srgn;
-	int srgn_idx;
-
-	if (!list_empty(&rgn->list_inact_rgn))
-		return;
-
-	for_each_sub_region(rgn, srgn_idx, srgn)
-		if (!list_empty(&srgn->list_act_srgn))
-			return;
-
-	list_add_tail(&rgn->list_inact_rgn, pending_list);
-}
-
-static void ufshpb_run_active_subregion_list(struct ufshpb_lu *hpb)
-{
-	struct ufshpb_region *rgn;
-	struct ufshpb_subregion *srgn;
-	unsigned long flags;
-	int ret = 0;
-
-	spin_lock_irqsave(&hpb->rsp_list_lock, flags);
-	while ((srgn = list_first_entry_or_null(&hpb->lh_act_srgn,
-						struct ufshpb_subregion,
-						list_act_srgn))) {
-		if (ufshpb_get_state(hpb) == HPB_SUSPEND)
-			break;
-
-		list_del_init(&srgn->list_act_srgn);
-		spin_unlock_irqrestore(&hpb->rsp_list_lock, flags);
-
-		rgn = hpb->rgn_tbl + srgn->rgn_idx;
-		ret = ufshpb_add_region(hpb, rgn);
-		if (ret)
-			goto active_failed;
-
-		ret = ufshpb_issue_map_req(hpb, rgn, srgn);
-		if (ret) {
-			dev_err(&hpb->sdev_ufs_lu->sdev_dev,
-			    "issue map_req failed. ret %d, region %d - %d\n",
-			    ret, rgn->rgn_idx, srgn->srgn_idx);
-			goto active_failed;
-		}
-		spin_lock_irqsave(&hpb->rsp_list_lock, flags);
-	}
-	spin_unlock_irqrestore(&hpb->rsp_list_lock, flags);
-	return;
-
-active_failed:
-	dev_err(&hpb->sdev_ufs_lu->sdev_dev, "failed to activate region %d - %d, will retry\n",
-		   rgn->rgn_idx, srgn->srgn_idx);
-	spin_lock_irqsave(&hpb->rsp_list_lock, flags);
-	ufshpb_add_active_list(hpb, rgn, srgn);
-	spin_unlock_irqrestore(&hpb->rsp_list_lock, flags);
-}
-
-static void ufshpb_run_inactive_region_list(struct ufshpb_lu *hpb)
-{
-	struct ufshpb_region *rgn;
-	unsigned long flags;
-	int ret;
-	LIST_HEAD(pending_list);
-
-	spin_lock_irqsave(&hpb->rsp_list_lock, flags);
-	while ((rgn = list_first_entry_or_null(&hpb->lh_inact_rgn,
-					       struct ufshpb_region,
-					       list_inact_rgn))) {
-		if (ufshpb_get_state(hpb) == HPB_SUSPEND)
-			break;
-
-		list_del_init(&rgn->list_inact_rgn);
-		spin_unlock_irqrestore(&hpb->rsp_list_lock, flags);
-
-		ret = ufshpb_evict_region(hpb, rgn);
-		if (ret) {
-			spin_lock_irqsave(&hpb->rsp_list_lock, flags);
-			ufshpb_add_pending_evict_list(hpb, rgn, &pending_list);
-			spin_unlock_irqrestore(&hpb->rsp_list_lock, flags);
-		}
-
-		spin_lock_irqsave(&hpb->rsp_list_lock, flags);
-	}
-
-	list_splice(&pending_list, &hpb->lh_inact_rgn);
-	spin_unlock_irqrestore(&hpb->rsp_list_lock, flags);
-}
-
-static void ufshpb_normalization_work_handler(struct work_struct *work)
-{
-	struct ufshpb_lu *hpb = container_of(work, struct ufshpb_lu,
-					     ufshpb_normalization_work);
-	int rgn_idx;
-	u8 factor = hpb->params.normalization_factor;
-
-	for (rgn_idx = 0; rgn_idx < hpb->rgns_per_lu; rgn_idx++) {
-		struct ufshpb_region *rgn = hpb->rgn_tbl + rgn_idx;
-		int srgn_idx;
-
-		spin_lock(&rgn->rgn_lock);
-		rgn->reads = 0;
-		for (srgn_idx = 0; srgn_idx < hpb->srgns_per_rgn; srgn_idx++) {
-			struct ufshpb_subregion *srgn = rgn->srgn_tbl + srgn_idx;
-
-			srgn->reads >>= factor;
-			rgn->reads += srgn->reads;
-		}
-		spin_unlock(&rgn->rgn_lock);
-
-		if (rgn->rgn_state != HPB_RGN_ACTIVE || rgn->reads)
-			continue;
-
-		/* if region is active but has no reads - inactivate it */
-		spin_lock(&hpb->rsp_list_lock);
-		ufshpb_update_inactive_info(hpb, rgn->rgn_idx);
-		spin_unlock(&hpb->rsp_list_lock);
-	}
-}
-
-static void ufshpb_map_work_handler(struct work_struct *work)
-{
-	struct ufshpb_lu *hpb = container_of(work, struct ufshpb_lu, map_work);
-
-	if (ufshpb_get_state(hpb) != HPB_PRESENT) {
-		dev_notice(&hpb->sdev_ufs_lu->sdev_dev,
-			   "%s: ufshpb state is not PRESENT\n", __func__);
-		return;
-	}
-
-	ufshpb_run_inactive_region_list(hpb);
-	ufshpb_run_active_subregion_list(hpb);
-}
-
-/*
- * this function doesn't need to hold lock due to be called in init.
- * (rgn_state_lock, rsp_list_lock, etc..)
- */
-static int ufshpb_init_pinned_active_region(struct ufs_hba *hba,
-					    struct ufshpb_lu *hpb,
-					    struct ufshpb_region *rgn)
-{
-	struct ufshpb_subregion *srgn;
-	int srgn_idx, i;
-	int err = 0;
-
-	for_each_sub_region(rgn, srgn_idx, srgn) {
-		srgn->mctx = ufshpb_get_map_ctx(hpb, srgn->is_last);
-		srgn->srgn_state = HPB_SRGN_INVALID;
-		if (!srgn->mctx) {
-			err = -ENOMEM;
-			dev_err(hba->dev,
-				"alloc mctx for pinned region failed\n");
-			goto release;
-		}
-
-		list_add_tail(&srgn->list_act_srgn, &hpb->lh_act_srgn);
-	}
-
-	rgn->rgn_state = HPB_RGN_PINNED;
-	return 0;
-
-release:
-	for (i = 0; i < srgn_idx; i++) {
-		srgn = rgn->srgn_tbl + i;
-		ufshpb_put_map_ctx(hpb, srgn->mctx);
-	}
-	return err;
-}
-
-static void ufshpb_init_subregion_tbl(struct ufshpb_lu *hpb,
-				      struct ufshpb_region *rgn, bool last)
-{
-	int srgn_idx;
-	struct ufshpb_subregion *srgn;
-
-	for_each_sub_region(rgn, srgn_idx, srgn) {
-		INIT_LIST_HEAD(&srgn->list_act_srgn);
-
-		srgn->rgn_idx = rgn->rgn_idx;
-		srgn->srgn_idx = srgn_idx;
-		srgn->srgn_state = HPB_SRGN_UNUSED;
-	}
-
-	if (unlikely(last && hpb->last_srgn_entries))
-		srgn->is_last = true;
-}
-
-static int ufshpb_alloc_subregion_tbl(struct ufshpb_lu *hpb,
-				      struct ufshpb_region *rgn, int srgn_cnt)
-{
-	rgn->srgn_tbl = kvcalloc(srgn_cnt, sizeof(struct ufshpb_subregion),
-				 GFP_KERNEL);
-	if (!rgn->srgn_tbl)
-		return -ENOMEM;
-
-	rgn->srgn_cnt = srgn_cnt;
-	return 0;
-}
-
-static void ufshpb_lu_parameter_init(struct ufs_hba *hba,
-				     struct ufshpb_lu *hpb,
-				     struct ufshpb_dev_info *hpb_dev_info,
-				     struct ufshpb_lu_info *hpb_lu_info)
-{
-	u32 entries_per_rgn;
-	u64 rgn_mem_size, tmp;
-
-	/* for pre_req */
-	hpb->pre_req_min_tr_len = hpb_dev_info->max_hpb_single_cmd + 1;
-
-	if (ufshpb_is_legacy(hba))
-		hpb->pre_req_max_tr_len = HPB_LEGACY_CHUNK_HIGH;
-	else
-		hpb->pre_req_max_tr_len = HPB_MULTI_CHUNK_HIGH;
-
-	hpb->cur_read_id = 0;
-
-	hpb->lu_pinned_start = hpb_lu_info->pinned_start;
-	hpb->lu_pinned_end = hpb_lu_info->num_pinned ?
-		(hpb_lu_info->pinned_start + hpb_lu_info->num_pinned - 1)
-		: PINNED_NOT_SET;
-	hpb->lru_info.max_lru_active_cnt =
-		hpb_lu_info->max_active_rgns - hpb_lu_info->num_pinned;
-
-	rgn_mem_size = (1ULL << hpb_dev_info->rgn_size) * HPB_RGN_SIZE_UNIT
-			* HPB_ENTRY_SIZE;
-	do_div(rgn_mem_size, HPB_ENTRY_BLOCK_SIZE);
-	hpb->srgn_mem_size = (1ULL << hpb_dev_info->srgn_size)
-		* HPB_RGN_SIZE_UNIT / HPB_ENTRY_BLOCK_SIZE * HPB_ENTRY_SIZE;
-
-	tmp = rgn_mem_size;
-	do_div(tmp, HPB_ENTRY_SIZE);
-	entries_per_rgn = (u32)tmp;
-	hpb->entries_per_rgn_shift = ilog2(entries_per_rgn);
-	hpb->entries_per_rgn_mask = entries_per_rgn - 1;
-
-	hpb->entries_per_srgn = hpb->srgn_mem_size / HPB_ENTRY_SIZE;
-	hpb->entries_per_srgn_shift = ilog2(hpb->entries_per_srgn);
-	hpb->entries_per_srgn_mask = hpb->entries_per_srgn - 1;
-
-	tmp = rgn_mem_size;
-	do_div(tmp, hpb->srgn_mem_size);
-	hpb->srgns_per_rgn = (int)tmp;
-
-	hpb->rgns_per_lu = DIV_ROUND_UP(hpb_lu_info->num_blocks,
-				entries_per_rgn);
-	hpb->srgns_per_lu = DIV_ROUND_UP(hpb_lu_info->num_blocks,
-				(hpb->srgn_mem_size / HPB_ENTRY_SIZE));
-	hpb->last_srgn_entries = hpb_lu_info->num_blocks
-				 % (hpb->srgn_mem_size / HPB_ENTRY_SIZE);
-
-	hpb->pages_per_srgn = DIV_ROUND_UP(hpb->srgn_mem_size, PAGE_SIZE);
-
-	if (hpb_dev_info->control_mode == HPB_HOST_CONTROL)
-		hpb->is_hcm = true;
-}
-
-static int ufshpb_alloc_region_tbl(struct ufs_hba *hba, struct ufshpb_lu *hpb)
-{
-	struct ufshpb_region *rgn_table, *rgn;
-	int rgn_idx, i;
-	int ret = 0;
-
-	rgn_table = kvcalloc(hpb->rgns_per_lu, sizeof(struct ufshpb_region),
-			    GFP_KERNEL);
-	if (!rgn_table)
-		return -ENOMEM;
-
-	for (rgn_idx = 0; rgn_idx < hpb->rgns_per_lu; rgn_idx++) {
-		int srgn_cnt = hpb->srgns_per_rgn;
-		bool last_srgn = false;
-
-		rgn = rgn_table + rgn_idx;
-		rgn->rgn_idx = rgn_idx;
-
-		spin_lock_init(&rgn->rgn_lock);
-
-		INIT_LIST_HEAD(&rgn->list_inact_rgn);
-		INIT_LIST_HEAD(&rgn->list_lru_rgn);
-		INIT_LIST_HEAD(&rgn->list_expired_rgn);
-
-		if (rgn_idx == hpb->rgns_per_lu - 1) {
-			srgn_cnt = ((hpb->srgns_per_lu - 1) %
-				    hpb->srgns_per_rgn) + 1;
-			last_srgn = true;
-		}
-
-		ret = ufshpb_alloc_subregion_tbl(hpb, rgn, srgn_cnt);
-		if (ret)
-			goto release_srgn_table;
-		ufshpb_init_subregion_tbl(hpb, rgn, last_srgn);
-
-		if (ufshpb_is_pinned_region(hpb, rgn_idx)) {
-			ret = ufshpb_init_pinned_active_region(hba, hpb, rgn);
-			if (ret)
-				goto release_srgn_table;
-		} else {
-			rgn->rgn_state = HPB_RGN_INACTIVE;
-		}
-
-		rgn->rgn_flags = 0;
-		rgn->hpb = hpb;
-	}
-
-	hpb->rgn_tbl = rgn_table;
-
-	return 0;
-
-release_srgn_table:
-	for (i = 0; i <= rgn_idx; i++)
-		kvfree(rgn_table[i].srgn_tbl);
-
-	kvfree(rgn_table);
-	return ret;
-}
-
-static void ufshpb_destroy_subregion_tbl(struct ufshpb_lu *hpb,
-					 struct ufshpb_region *rgn)
-{
-	int srgn_idx;
-	struct ufshpb_subregion *srgn;
-
-	for_each_sub_region(rgn, srgn_idx, srgn)
-		if (srgn->srgn_state != HPB_SRGN_UNUSED) {
-			srgn->srgn_state = HPB_SRGN_UNUSED;
-			ufshpb_put_map_ctx(hpb, srgn->mctx);
-		}
-}
-
-static void ufshpb_destroy_region_tbl(struct ufshpb_lu *hpb)
-{
-	int rgn_idx;
-
-	for (rgn_idx = 0; rgn_idx < hpb->rgns_per_lu; rgn_idx++) {
-		struct ufshpb_region *rgn;
-
-		rgn = hpb->rgn_tbl + rgn_idx;
-		if (rgn->rgn_state != HPB_RGN_INACTIVE) {
-			rgn->rgn_state = HPB_RGN_INACTIVE;
-
-			ufshpb_destroy_subregion_tbl(hpb, rgn);
-		}
-
-		kvfree(rgn->srgn_tbl);
-	}
-
-	kvfree(hpb->rgn_tbl);
-}
-
-/* SYSFS functions */
-#define ufshpb_sysfs_attr_show_func(__name)				\
-static ssize_t __name##_show(struct device *dev,			\
-	struct device_attribute *attr, char *buf)			\
-{									\
-	struct scsi_device *sdev = to_scsi_device(dev);			\
-	struct ufshpb_lu *hpb = ufshpb_get_hpb_data(sdev);		\
-									\
-	if (!hpb)							\
-		return -ENODEV;						\
-									\
-	return sysfs_emit(buf, "%llu\n", hpb->stats.__name);		\
-}									\
-\
-static DEVICE_ATTR_RO(__name)
-
-ufshpb_sysfs_attr_show_func(hit_cnt);
-ufshpb_sysfs_attr_show_func(miss_cnt);
-ufshpb_sysfs_attr_show_func(rb_noti_cnt);
-ufshpb_sysfs_attr_show_func(rb_active_cnt);
-ufshpb_sysfs_attr_show_func(rb_inactive_cnt);
-ufshpb_sysfs_attr_show_func(map_req_cnt);
-ufshpb_sysfs_attr_show_func(umap_req_cnt);
-
-static struct attribute *hpb_dev_stat_attrs[] = {
-	&dev_attr_hit_cnt.attr,
-	&dev_attr_miss_cnt.attr,
-	&dev_attr_rb_noti_cnt.attr,
-	&dev_attr_rb_active_cnt.attr,
-	&dev_attr_rb_inactive_cnt.attr,
-	&dev_attr_map_req_cnt.attr,
-	&dev_attr_umap_req_cnt.attr,
-	NULL,
-};
-
-struct attribute_group ufs_sysfs_hpb_stat_group = {
-	.name = "hpb_stats",
-	.attrs = hpb_dev_stat_attrs,
-};
-
-/* SYSFS functions */
-#define ufshpb_sysfs_param_show_func(__name)				\
-static ssize_t __name##_show(struct device *dev,			\
-	struct device_attribute *attr, char *buf)			\
-{									\
-	struct scsi_device *sdev = to_scsi_device(dev);			\
-	struct ufshpb_lu *hpb = ufshpb_get_hpb_data(sdev);		\
-									\
-	if (!hpb)							\
-		return -ENODEV;						\
-									\
-	return sysfs_emit(buf, "%d\n", hpb->params.__name);		\
-}
-
-ufshpb_sysfs_param_show_func(requeue_timeout_ms);
-static ssize_t
-requeue_timeout_ms_store(struct device *dev, struct device_attribute *attr,
-			 const char *buf, size_t count)
-{
-	struct scsi_device *sdev = to_scsi_device(dev);
-	struct ufshpb_lu *hpb = ufshpb_get_hpb_data(sdev);
-	int val;
-
-	if (!hpb)
-		return -ENODEV;
-
-	if (kstrtouint(buf, 0, &val))
-		return -EINVAL;
-
-	if (val < 0)
-		return -EINVAL;
-
-	hpb->params.requeue_timeout_ms = val;
-
-	return count;
-}
-static DEVICE_ATTR_RW(requeue_timeout_ms);
-
-ufshpb_sysfs_param_show_func(activation_thld);
-static ssize_t
-activation_thld_store(struct device *dev, struct device_attribute *attr,
-		      const char *buf, size_t count)
-{
-	struct scsi_device *sdev = to_scsi_device(dev);
-	struct ufshpb_lu *hpb = ufshpb_get_hpb_data(sdev);
-	int val;
-
-	if (!hpb)
-		return -ENODEV;
-
-	if (!hpb->is_hcm)
-		return -EOPNOTSUPP;
-
-	if (kstrtouint(buf, 0, &val))
-		return -EINVAL;
-
-	if (val <= 0)
-		return -EINVAL;
-
-	hpb->params.activation_thld = val;
-
-	return count;
-}
-static DEVICE_ATTR_RW(activation_thld);
-
-ufshpb_sysfs_param_show_func(normalization_factor);
-static ssize_t
-normalization_factor_store(struct device *dev, struct device_attribute *attr,
-			   const char *buf, size_t count)
-{
-	struct scsi_device *sdev = to_scsi_device(dev);
-	struct ufshpb_lu *hpb = ufshpb_get_hpb_data(sdev);
-	int val;
-
-	if (!hpb)
-		return -ENODEV;
-
-	if (!hpb->is_hcm)
-		return -EOPNOTSUPP;
-
-	if (kstrtouint(buf, 0, &val))
-		return -EINVAL;
-
-	if (val <= 0 || val > ilog2(hpb->entries_per_srgn))
-		return -EINVAL;
-
-	hpb->params.normalization_factor = val;
-
-	return count;
-}
-static DEVICE_ATTR_RW(normalization_factor);
-
-ufshpb_sysfs_param_show_func(eviction_thld_enter);
-static ssize_t
-eviction_thld_enter_store(struct device *dev, struct device_attribute *attr,
-			  const char *buf, size_t count)
-{
-	struct scsi_device *sdev = to_scsi_device(dev);
-	struct ufshpb_lu *hpb = ufshpb_get_hpb_data(sdev);
-	int val;
-
-	if (!hpb)
-		return -ENODEV;
-
-	if (!hpb->is_hcm)
-		return -EOPNOTSUPP;
-
-	if (kstrtouint(buf, 0, &val))
-		return -EINVAL;
-
-	if (val <= hpb->params.eviction_thld_exit)
-		return -EINVAL;
-
-	hpb->params.eviction_thld_enter = val;
-
-	return count;
-}
-static DEVICE_ATTR_RW(eviction_thld_enter);
-
-ufshpb_sysfs_param_show_func(eviction_thld_exit);
-static ssize_t
-eviction_thld_exit_store(struct device *dev, struct device_attribute *attr,
-			 const char *buf, size_t count)
-{
-	struct scsi_device *sdev = to_scsi_device(dev);
-	struct ufshpb_lu *hpb = ufshpb_get_hpb_data(sdev);
-	int val;
-
-	if (!hpb)
-		return -ENODEV;
-
-	if (!hpb->is_hcm)
-		return -EOPNOTSUPP;
-
-	if (kstrtouint(buf, 0, &val))
-		return -EINVAL;
-
-	if (val <= hpb->params.activation_thld)
-		return -EINVAL;
-
-	hpb->params.eviction_thld_exit = val;
-
-	return count;
-}
-static DEVICE_ATTR_RW(eviction_thld_exit);
-
-ufshpb_sysfs_param_show_func(read_timeout_ms);
-static ssize_t
-read_timeout_ms_store(struct device *dev, struct device_attribute *attr,
-		      const char *buf, size_t count)
-{
-	struct scsi_device *sdev = to_scsi_device(dev);
-	struct ufshpb_lu *hpb = ufshpb_get_hpb_data(sdev);
-	int val;
-
-	if (!hpb)
-		return -ENODEV;
-
-	if (!hpb->is_hcm)
-		return -EOPNOTSUPP;
-
-	if (kstrtouint(buf, 0, &val))
-		return -EINVAL;
-
-	/* read_timeout >> timeout_polling_interval */
-	if (val < hpb->params.timeout_polling_interval_ms * 2)
-		return -EINVAL;
-
-	hpb->params.read_timeout_ms = val;
-
-	return count;
-}
-static DEVICE_ATTR_RW(read_timeout_ms);
-
-ufshpb_sysfs_param_show_func(read_timeout_expiries);
-static ssize_t
-read_timeout_expiries_store(struct device *dev, struct device_attribute *attr,
-			    const char *buf, size_t count)
-{
-	struct scsi_device *sdev = to_scsi_device(dev);
-	struct ufshpb_lu *hpb = ufshpb_get_hpb_data(sdev);
-	int val;
-
-	if (!hpb)
-		return -ENODEV;
-
-	if (!hpb->is_hcm)
-		return -EOPNOTSUPP;
-
-	if (kstrtouint(buf, 0, &val))
-		return -EINVAL;
-
-	if (val <= 0)
-		return -EINVAL;
-
-	hpb->params.read_timeout_expiries = val;
-
-	return count;
-}
-static DEVICE_ATTR_RW(read_timeout_expiries);
-
-ufshpb_sysfs_param_show_func(timeout_polling_interval_ms);
-static ssize_t
-timeout_polling_interval_ms_store(struct device *dev,
-				  struct device_attribute *attr,
-				  const char *buf, size_t count)
-{
-	struct scsi_device *sdev = to_scsi_device(dev);
-	struct ufshpb_lu *hpb = ufshpb_get_hpb_data(sdev);
-	int val;
-
-	if (!hpb)
-		return -ENODEV;
-
-	if (!hpb->is_hcm)
-		return -EOPNOTSUPP;
-
-	if (kstrtouint(buf, 0, &val))
-		return -EINVAL;
-
-	/* timeout_polling_interval << read_timeout */
-	if (val <= 0 || val > hpb->params.read_timeout_ms / 2)
-		return -EINVAL;
-
-	hpb->params.timeout_polling_interval_ms = val;
-
-	return count;
-}
-static DEVICE_ATTR_RW(timeout_polling_interval_ms);
-
-ufshpb_sysfs_param_show_func(inflight_map_req);
-static ssize_t inflight_map_req_store(struct device *dev,
-				      struct device_attribute *attr,
-				      const char *buf, size_t count)
-{
-	struct scsi_device *sdev = to_scsi_device(dev);
-	struct ufshpb_lu *hpb = ufshpb_get_hpb_data(sdev);
-	int val;
-
-	if (!hpb)
-		return -ENODEV;
-
-	if (!hpb->is_hcm)
-		return -EOPNOTSUPP;
-
-	if (kstrtouint(buf, 0, &val))
-		return -EINVAL;
-
-	if (val <= 0 || val > hpb->sdev_ufs_lu->queue_depth - 1)
-		return -EINVAL;
-
-	hpb->params.inflight_map_req = val;
-
-	return count;
-}
-static DEVICE_ATTR_RW(inflight_map_req);
-
-static void ufshpb_hcm_param_init(struct ufshpb_lu *hpb)
-{
-	hpb->params.activation_thld = ACTIVATION_THRESHOLD;
-	hpb->params.normalization_factor = 1;
-	hpb->params.eviction_thld_enter = (ACTIVATION_THRESHOLD << 5);
-	hpb->params.eviction_thld_exit = (ACTIVATION_THRESHOLD << 4);
-	hpb->params.read_timeout_ms = READ_TO_MS;
-	hpb->params.read_timeout_expiries = READ_TO_EXPIRIES;
-	hpb->params.timeout_polling_interval_ms = POLLING_INTERVAL_MS;
-	hpb->params.inflight_map_req = THROTTLE_MAP_REQ_DEFAULT;
-}
-
-static struct attribute *hpb_dev_param_attrs[] = {
-	&dev_attr_requeue_timeout_ms.attr,
-	&dev_attr_activation_thld.attr,
-	&dev_attr_normalization_factor.attr,
-	&dev_attr_eviction_thld_enter.attr,
-	&dev_attr_eviction_thld_exit.attr,
-	&dev_attr_read_timeout_ms.attr,
-	&dev_attr_read_timeout_expiries.attr,
-	&dev_attr_timeout_polling_interval_ms.attr,
-	&dev_attr_inflight_map_req.attr,
-	NULL,
-};
-
-struct attribute_group ufs_sysfs_hpb_param_group = {
-	.name = "hpb_params",
-	.attrs = hpb_dev_param_attrs,
-};
-
-static int ufshpb_pre_req_mempool_init(struct ufshpb_lu *hpb)
-{
-	struct ufshpb_req *pre_req = NULL, *t;
-	int qd = hpb->sdev_ufs_lu->queue_depth / 2;
-	int i;
-
-	INIT_LIST_HEAD(&hpb->lh_pre_req_free);
-
-	hpb->pre_req = kcalloc(qd, sizeof(struct ufshpb_req), GFP_KERNEL);
-	hpb->throttle_pre_req = qd;
-	hpb->num_inflight_pre_req = 0;
-
-	if (!hpb->pre_req)
-		goto release_mem;
-
-	for (i = 0; i < qd; i++) {
-		pre_req = hpb->pre_req + i;
-		INIT_LIST_HEAD(&pre_req->list_req);
-		pre_req->req = NULL;
-
-		pre_req->bio = bio_alloc(GFP_KERNEL, 1);
-		if (!pre_req->bio)
-			goto release_mem;
-
-		pre_req->wb.m_page = alloc_page(GFP_KERNEL | __GFP_ZERO);
-		if (!pre_req->wb.m_page) {
-			bio_put(pre_req->bio);
-			goto release_mem;
-		}
-
-		list_add_tail(&pre_req->list_req, &hpb->lh_pre_req_free);
-	}
-
-	return 0;
-release_mem:
-	list_for_each_entry_safe(pre_req, t, &hpb->lh_pre_req_free, list_req) {
-		list_del_init(&pre_req->list_req);
-		bio_put(pre_req->bio);
-		__free_page(pre_req->wb.m_page);
-	}
-
-	kfree(hpb->pre_req);
-	return -ENOMEM;
-}
-
-static void ufshpb_pre_req_mempool_destroy(struct ufshpb_lu *hpb)
-{
-	struct ufshpb_req *pre_req = NULL;
-	int i;
-
-	for (i = 0; i < hpb->throttle_pre_req; i++) {
-		pre_req = hpb->pre_req + i;
-		bio_put(hpb->pre_req[i].bio);
-		if (!pre_req->wb.m_page)
-			__free_page(hpb->pre_req[i].wb.m_page);
-		list_del_init(&pre_req->list_req);
-	}
-
-	kfree(hpb->pre_req);
-}
-
-static void ufshpb_stat_init(struct ufshpb_lu *hpb)
-{
-	hpb->stats.hit_cnt = 0;
-	hpb->stats.miss_cnt = 0;
-	hpb->stats.rb_noti_cnt = 0;
-	hpb->stats.rb_active_cnt = 0;
-	hpb->stats.rb_inactive_cnt = 0;
-	hpb->stats.map_req_cnt = 0;
-	hpb->stats.umap_req_cnt = 0;
-}
-
-static void ufshpb_param_init(struct ufshpb_lu *hpb)
-{
-	hpb->params.requeue_timeout_ms = HPB_REQUEUE_TIME_MS;
-	if (hpb->is_hcm)
-		ufshpb_hcm_param_init(hpb);
-}
-
-static int ufshpb_lu_hpb_init(struct ufs_hba *hba, struct ufshpb_lu *hpb)
-{
-	int ret;
-
-	spin_lock_init(&hpb->rgn_state_lock);
-	spin_lock_init(&hpb->rsp_list_lock);
-	spin_lock_init(&hpb->param_lock);
-
-	INIT_LIST_HEAD(&hpb->lru_info.lh_lru_rgn);
-	INIT_LIST_HEAD(&hpb->lh_act_srgn);
-	INIT_LIST_HEAD(&hpb->lh_inact_rgn);
-	INIT_LIST_HEAD(&hpb->list_hpb_lu);
-
-	INIT_WORK(&hpb->map_work, ufshpb_map_work_handler);
-	if (hpb->is_hcm) {
-		INIT_WORK(&hpb->ufshpb_normalization_work,
-			  ufshpb_normalization_work_handler);
-		INIT_DELAYED_WORK(&hpb->ufshpb_read_to_work,
-				  ufshpb_read_to_handler);
-	}
-
-	hpb->map_req_cache = kmem_cache_create("ufshpb_req_cache",
-			  sizeof(struct ufshpb_req), 0, 0, NULL);
-	if (!hpb->map_req_cache) {
-		dev_err(hba->dev, "ufshpb(%d) ufshpb_req_cache create fail",
-			hpb->lun);
-		return -ENOMEM;
-	}
-
-	hpb->m_page_cache = kmem_cache_create("ufshpb_m_page_cache",
-			  sizeof(struct page *) * hpb->pages_per_srgn,
-			  0, 0, NULL);
-	if (!hpb->m_page_cache) {
-		dev_err(hba->dev, "ufshpb(%d) ufshpb_m_page_cache create fail",
-			hpb->lun);
-		ret = -ENOMEM;
-		goto release_req_cache;
-	}
-
-	ret = ufshpb_pre_req_mempool_init(hpb);
-	if (ret) {
-		dev_err(hba->dev, "ufshpb(%d) pre_req_mempool init fail",
-			hpb->lun);
-		goto release_m_page_cache;
-	}
-
-	ret = ufshpb_alloc_region_tbl(hba, hpb);
-	if (ret)
-		goto release_pre_req_mempool;
-
-	ufshpb_stat_init(hpb);
-	ufshpb_param_init(hpb);
-
-	if (hpb->is_hcm) {
-		unsigned int poll;
-
-		poll = hpb->params.timeout_polling_interval_ms;
-		schedule_delayed_work(&hpb->ufshpb_read_to_work,
-				      msecs_to_jiffies(poll));
-	}
-
-	return 0;
-
-release_pre_req_mempool:
-	ufshpb_pre_req_mempool_destroy(hpb);
-release_m_page_cache:
-	kmem_cache_destroy(hpb->m_page_cache);
-release_req_cache:
-	kmem_cache_destroy(hpb->map_req_cache);
-	return ret;
-}
-
-static struct ufshpb_lu *
-ufshpb_alloc_hpb_lu(struct ufs_hba *hba, struct scsi_device *sdev,
-		    struct ufshpb_dev_info *hpb_dev_info,
-		    struct ufshpb_lu_info *hpb_lu_info)
-{
-	struct ufshpb_lu *hpb;
-	int ret;
-
-	hpb = kzalloc(sizeof(struct ufshpb_lu), GFP_KERNEL);
-	if (!hpb)
-		return NULL;
-
-	hpb->lun = sdev->lun;
-	hpb->sdev_ufs_lu = sdev;
-
-	ufshpb_lu_parameter_init(hba, hpb, hpb_dev_info, hpb_lu_info);
-
-	ret = ufshpb_lu_hpb_init(hba, hpb);
-	if (ret) {
-		dev_err(hba->dev, "hpb lu init failed. ret %d", ret);
-		goto release_hpb;
-	}
-
-	sdev->hostdata = hpb;
-	return hpb;
-
-release_hpb:
-	kfree(hpb);
-	return NULL;
-}
-
-static void ufshpb_discard_rsp_lists(struct ufshpb_lu *hpb)
-{
-	struct ufshpb_region *rgn, *next_rgn;
-	struct ufshpb_subregion *srgn, *next_srgn;
-	unsigned long flags;
-
-	/*
-	 * If the device reset occurred, the remaining HPB region information
-	 * may be stale. Therefore, by discarding the lists of HPB response
-	 * that remained after reset, we prevent unnecessary work.
-	 */
-	spin_lock_irqsave(&hpb->rsp_list_lock, flags);
-	list_for_each_entry_safe(rgn, next_rgn, &hpb->lh_inact_rgn,
-				 list_inact_rgn)
-		list_del_init(&rgn->list_inact_rgn);
-
-	list_for_each_entry_safe(srgn, next_srgn, &hpb->lh_act_srgn,
-				 list_act_srgn)
-		list_del_init(&srgn->list_act_srgn);
-	spin_unlock_irqrestore(&hpb->rsp_list_lock, flags);
-}
-
-static void ufshpb_cancel_jobs(struct ufshpb_lu *hpb)
-{
-	if (hpb->is_hcm) {
-		cancel_delayed_work_sync(&hpb->ufshpb_read_to_work);
-		cancel_work_sync(&hpb->ufshpb_normalization_work);
-	}
-	cancel_work_sync(&hpb->map_work);
-}
-
-static bool ufshpb_check_hpb_reset_query(struct ufs_hba *hba)
-{
-	int err = 0;
-	bool flag_res = true;
-	int try;
-
-	/* wait for the device to complete HPB reset query */
-	for (try = 0; try < HPB_RESET_REQ_RETRIES; try++) {
-		dev_dbg(hba->dev,
-			"%s start flag reset polling %d times\n",
-			__func__, try);
-
-		/* Poll fHpbReset flag to be cleared */
-		err = ufshcd_query_flag(hba, UPIU_QUERY_OPCODE_READ_FLAG,
-				QUERY_FLAG_IDN_HPB_RESET, 0, &flag_res);
-
-		if (err) {
-			dev_err(hba->dev,
-				"%s reading fHpbReset flag failed with error %d\n",
-				__func__, err);
-			return flag_res;
-		}
-
-		if (!flag_res)
-			goto out;
-
-		usleep_range(1000, 1100);
-	}
-	if (flag_res) {
-		dev_err(hba->dev,
-			"%s fHpbReset was not cleared by the device\n",
-			__func__);
-	}
-out:
-	return flag_res;
-}
-
-void ufshpb_reset(struct ufs_hba *hba)
-{
-	struct ufshpb_lu *hpb;
-	struct scsi_device *sdev;
-
-	shost_for_each_device(sdev, hba->host) {
-		hpb = ufshpb_get_hpb_data(sdev);
-		if (!hpb)
-			continue;
-
-		if (ufshpb_get_state(hpb) != HPB_RESET)
-			continue;
-
-		ufshpb_set_state(hpb, HPB_PRESENT);
-	}
-}
-
-void ufshpb_reset_host(struct ufs_hba *hba)
-{
-	struct ufshpb_lu *hpb;
-	struct scsi_device *sdev;
-
-	shost_for_each_device(sdev, hba->host) {
-		hpb = ufshpb_get_hpb_data(sdev);
-		if (!hpb)
-			continue;
-
-		if (ufshpb_get_state(hpb) != HPB_PRESENT)
-			continue;
-		ufshpb_set_state(hpb, HPB_RESET);
-		ufshpb_cancel_jobs(hpb);
-		ufshpb_discard_rsp_lists(hpb);
-	}
-}
-
-void ufshpb_suspend(struct ufs_hba *hba)
-{
-	struct ufshpb_lu *hpb;
-	struct scsi_device *sdev;
-
-	shost_for_each_device(sdev, hba->host) {
-		hpb = ufshpb_get_hpb_data(sdev);
-		if (!hpb)
-			continue;
-
-		if (ufshpb_get_state(hpb) != HPB_PRESENT)
-			continue;
-		ufshpb_set_state(hpb, HPB_SUSPEND);
-		ufshpb_cancel_jobs(hpb);
-	}
-}
-
-void ufshpb_resume(struct ufs_hba *hba)
-{
-	struct ufshpb_lu *hpb;
-	struct scsi_device *sdev;
-
-	shost_for_each_device(sdev, hba->host) {
-		hpb = ufshpb_get_hpb_data(sdev);
-		if (!hpb)
-			continue;
-
-		if ((ufshpb_get_state(hpb) != HPB_PRESENT) &&
-		    (ufshpb_get_state(hpb) != HPB_SUSPEND))
-			continue;
-		ufshpb_set_state(hpb, HPB_PRESENT);
-		ufshpb_kick_map_work(hpb);
-		if (hpb->is_hcm) {
-			unsigned int poll =
-				hpb->params.timeout_polling_interval_ms;
-
-			schedule_delayed_work(&hpb->ufshpb_read_to_work,
-				msecs_to_jiffies(poll));
-		}
-	}
-}
-
-static int ufshpb_get_lu_info(struct ufs_hba *hba, int lun,
-			      struct ufshpb_lu_info *hpb_lu_info)
-{
-	u16 max_active_rgns;
-	u8 lu_enable;
-	int size;
-	int ret;
-	char desc_buf[QUERY_DESC_MAX_SIZE];
-
-	ufshcd_map_desc_id_to_length(hba, QUERY_DESC_IDN_UNIT, &size);
-
-	pm_runtime_get_sync(hba->dev);
-	ret = ufshcd_query_descriptor_retry(hba, UPIU_QUERY_OPCODE_READ_DESC,
-					    QUERY_DESC_IDN_UNIT, lun, 0,
-					    desc_buf, &size);
-	pm_runtime_put_sync(hba->dev);
-
-	if (ret) {
-		dev_err(hba->dev,
-			"%s: idn: %d lun: %d  query request failed",
-			__func__, QUERY_DESC_IDN_UNIT, lun);
-		return ret;
-	}
-
-	lu_enable = desc_buf[UNIT_DESC_PARAM_LU_ENABLE];
-	if (lu_enable != LU_ENABLED_HPB_FUNC)
-		return -ENODEV;
-
-	max_active_rgns = get_unaligned_be16(
-			desc_buf + UNIT_DESC_PARAM_HPB_LU_MAX_ACTIVE_RGNS);
-	if (!max_active_rgns) {
-		dev_err(hba->dev,
-			"lun %d wrong number of max active regions\n", lun);
-		return -ENODEV;
-	}
-
-	hpb_lu_info->num_blocks = get_unaligned_be64(
-			desc_buf + UNIT_DESC_PARAM_LOGICAL_BLK_COUNT);
-	hpb_lu_info->pinned_start = get_unaligned_be16(
-			desc_buf + UNIT_DESC_PARAM_HPB_PIN_RGN_START_OFF);
-	hpb_lu_info->num_pinned = get_unaligned_be16(
-			desc_buf + UNIT_DESC_PARAM_HPB_NUM_PIN_RGNS);
-	hpb_lu_info->max_active_rgns = max_active_rgns;
-
-	return 0;
-}
-
-void ufshpb_destroy_lu(struct ufs_hba *hba, struct scsi_device *sdev)
-{
-	struct ufshpb_lu *hpb = ufshpb_get_hpb_data(sdev);
-
-	if (!hpb)
-		return;
-
-	ufshpb_set_state(hpb, HPB_FAILED);
-
-	sdev = hpb->sdev_ufs_lu;
-	sdev->hostdata = NULL;
-
-	ufshpb_cancel_jobs(hpb);
-
-	ufshpb_pre_req_mempool_destroy(hpb);
-	ufshpb_destroy_region_tbl(hpb);
-
-	kmem_cache_destroy(hpb->map_req_cache);
-	kmem_cache_destroy(hpb->m_page_cache);
-
-	list_del_init(&hpb->list_hpb_lu);
-
-	kfree(hpb);
-}
-
-static void ufshpb_hpb_lu_prepared(struct ufs_hba *hba)
-{
-	int pool_size;
-	struct ufshpb_lu *hpb;
-	struct scsi_device *sdev;
-	bool init_success;
-
-	if (tot_active_srgn_pages == 0) {
-		ufshpb_remove(hba);
-		return;
-	}
-
-	init_success = !ufshpb_check_hpb_reset_query(hba);
-
-	pool_size = PAGE_ALIGN(ufshpb_host_map_kbytes * 1024) / PAGE_SIZE;
-	if (pool_size > tot_active_srgn_pages) {
-		mempool_resize(ufshpb_mctx_pool, tot_active_srgn_pages);
-		mempool_resize(ufshpb_page_pool, tot_active_srgn_pages);
-	}
-
-	shost_for_each_device(sdev, hba->host) {
-		hpb = ufshpb_get_hpb_data(sdev);
-		if (!hpb)
-			continue;
-
-		if (init_success) {
-			ufshpb_set_state(hpb, HPB_PRESENT);
-			if ((hpb->lu_pinned_end - hpb->lu_pinned_start) > 0)
-				queue_work(ufshpb_wq, &hpb->map_work);
-			if (!hpb->is_hcm)
-				ufshpb_issue_umap_all_req(hpb);
-		} else {
-			dev_err(hba->dev, "destroy HPB lu %d\n", hpb->lun);
-			ufshpb_destroy_lu(hba, sdev);
-		}
-	}
-
-	if (!init_success)
-		ufshpb_remove(hba);
-}
-
-void ufshpb_init_hpb_lu(struct ufs_hba *hba, struct scsi_device *sdev)
-{
-	struct ufshpb_lu *hpb;
-	int ret;
-	struct ufshpb_lu_info hpb_lu_info = { 0 };
-	int lun = sdev->lun;
-
-	if (lun >= hba->dev_info.max_lu_supported)
-		goto out;
-
-	ret = ufshpb_get_lu_info(hba, lun, &hpb_lu_info);
-	if (ret)
-		goto out;
-
-	hpb = ufshpb_alloc_hpb_lu(hba, sdev, &hba->ufshpb_dev,
-				  &hpb_lu_info);
-	if (!hpb)
-		goto out;
-
-	tot_active_srgn_pages += hpb_lu_info.max_active_rgns *
-			hpb->srgns_per_rgn * hpb->pages_per_srgn;
-
-out:
-	/* All LUs are initialized */
-	if (atomic_dec_and_test(&hba->ufshpb_dev.slave_conf_cnt))
-		ufshpb_hpb_lu_prepared(hba);
-}
-
-static int ufshpb_init_mem_wq(struct ufs_hba *hba)
-{
-	int ret;
-	unsigned int pool_size;
-
-	ufshpb_mctx_cache = kmem_cache_create("ufshpb_mctx_cache",
-					sizeof(struct ufshpb_map_ctx),
-					0, 0, NULL);
-	if (!ufshpb_mctx_cache) {
-		dev_err(hba->dev, "ufshpb: cannot init mctx cache\n");
-		return -ENOMEM;
-	}
-
-	pool_size = PAGE_ALIGN(ufshpb_host_map_kbytes * 1024) / PAGE_SIZE;
-	dev_info(hba->dev, "%s:%d ufshpb_host_map_kbytes %u pool_size %u\n",
-	       __func__, __LINE__, ufshpb_host_map_kbytes, pool_size);
-
-	ufshpb_mctx_pool = mempool_create_slab_pool(pool_size,
-						    ufshpb_mctx_cache);
-	if (!ufshpb_mctx_pool) {
-		dev_err(hba->dev, "ufshpb: cannot init mctx pool\n");
-		ret = -ENOMEM;
-		goto release_mctx_cache;
-	}
-
-	ufshpb_page_pool = mempool_create_page_pool(pool_size, 0);
-	if (!ufshpb_page_pool) {
-		dev_err(hba->dev, "ufshpb: cannot init page pool\n");
-		ret = -ENOMEM;
-		goto release_mctx_pool;
-	}
-
-	ufshpb_wq = alloc_workqueue("ufshpb-wq",
-					WQ_UNBOUND | WQ_MEM_RECLAIM, 0);
-	if (!ufshpb_wq) {
-		dev_err(hba->dev, "ufshpb: alloc workqueue failed\n");
-		ret = -ENOMEM;
-		goto release_page_pool;
-	}
-
-	return 0;
-
-release_page_pool:
-	mempool_destroy(ufshpb_page_pool);
-release_mctx_pool:
-	mempool_destroy(ufshpb_mctx_pool);
-release_mctx_cache:
-	kmem_cache_destroy(ufshpb_mctx_cache);
-	return ret;
-}
-
-void ufshpb_get_geo_info(struct ufs_hba *hba, u8 *geo_buf)
-{
-	struct ufshpb_dev_info *hpb_info = &hba->ufshpb_dev;
-	int max_active_rgns = 0;
-	int hpb_num_lu;
-
-	hpb_num_lu = geo_buf[GEOMETRY_DESC_PARAM_HPB_NUMBER_LU];
-	if (hpb_num_lu == 0) {
-		dev_err(hba->dev, "No HPB LU supported\n");
-		hpb_info->hpb_disabled = true;
-		return;
-	}
-
-	hpb_info->rgn_size = geo_buf[GEOMETRY_DESC_PARAM_HPB_REGION_SIZE];
-	hpb_info->srgn_size = geo_buf[GEOMETRY_DESC_PARAM_HPB_SUBREGION_SIZE];
-	max_active_rgns = get_unaligned_be16(geo_buf +
-			  GEOMETRY_DESC_PARAM_HPB_MAX_ACTIVE_REGS);
-
-	if (hpb_info->rgn_size == 0 || hpb_info->srgn_size == 0 ||
-	    max_active_rgns == 0) {
-		dev_err(hba->dev, "No HPB supported device\n");
-		hpb_info->hpb_disabled = true;
-		return;
-	}
-}
-
-void ufshpb_get_dev_info(struct ufs_hba *hba, u8 *desc_buf)
-{
-	struct ufshpb_dev_info *hpb_dev_info = &hba->ufshpb_dev;
-	int version, ret;
-	u32 max_hpb_single_cmd = HPB_MULTI_CHUNK_LOW;
-
-	hpb_dev_info->control_mode = desc_buf[DEVICE_DESC_PARAM_HPB_CONTROL];
-
-	version = get_unaligned_be16(desc_buf + DEVICE_DESC_PARAM_HPB_VER);
-	if ((version != HPB_SUPPORT_VERSION) &&
-	    (version != HPB_SUPPORT_LEGACY_VERSION)) {
-		dev_err(hba->dev, "%s: HPB %x version is not supported.\n",
-			__func__, version);
-		hpb_dev_info->hpb_disabled = true;
-		return;
-	}
-
-	if (version == HPB_SUPPORT_LEGACY_VERSION)
-		hpb_dev_info->is_legacy = true;
-
-	pm_runtime_get_sync(hba->dev);
-	ret = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_READ_ATTR,
-		QUERY_ATTR_IDN_MAX_HPB_SINGLE_CMD, 0, 0, &max_hpb_single_cmd);
-	pm_runtime_put_sync(hba->dev);
-
-	if (ret)
-		dev_err(hba->dev, "%s: idn: read max size of single hpb cmd query request failed",
-			__func__);
-	hpb_dev_info->max_hpb_single_cmd = max_hpb_single_cmd;
-
-	/*
-	 * Get the number of user logical unit to check whether all
-	 * scsi_device finish initialization
-	 */
-	hpb_dev_info->num_lu = desc_buf[DEVICE_DESC_PARAM_NUM_LU];
-}
-
-void ufshpb_init(struct ufs_hba *hba)
-{
-	struct ufshpb_dev_info *hpb_dev_info = &hba->ufshpb_dev;
-	int try;
-	int ret;
-
-	if (!ufshpb_is_allowed(hba) || !hba->dev_info.hpb_enabled)
-		return;
-
-	if (ufshpb_init_mem_wq(hba)) {
-		hpb_dev_info->hpb_disabled = true;
-		return;
-	}
-
-	atomic_set(&hpb_dev_info->slave_conf_cnt, hpb_dev_info->num_lu);
-	tot_active_srgn_pages = 0;
-	/* issue HPB reset query */
-	for (try = 0; try < HPB_RESET_REQ_RETRIES; try++) {
-		ret = ufshcd_query_flag(hba, UPIU_QUERY_OPCODE_SET_FLAG,
-					QUERY_FLAG_IDN_HPB_RESET, 0, NULL);
-		if (!ret)
-			break;
-	}
-}
-
-void ufshpb_remove(struct ufs_hba *hba)
-{
-	mempool_destroy(ufshpb_page_pool);
-	mempool_destroy(ufshpb_mctx_pool);
-	kmem_cache_destroy(ufshpb_mctx_cache);
-
-	destroy_workqueue(ufshpb_wq);
-}
-
-module_param(ufshpb_host_map_kbytes, uint, 0644);
-MODULE_PARM_DESC(ufshpb_host_map_kbytes,
-	"ufshpb host mapping memory kilo-bytes for ufshpb memory-pool");
diff --git a/drivers/scsi/ufs/ufshpb.h b/drivers/scsi/ufs/ufshpb.h
deleted file mode 100644
index a79e07398970c..0000000000000
--- a/drivers/scsi/ufs/ufshpb.h
+++ /dev/null
@@ -1,323 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Universal Flash Storage Host Performance Booster
- *
- * Copyright (C) 2017-2021 Samsung Electronics Co., Ltd.
- *
- * Authors:
- *	Yongmyung Lee <ymhungry.lee@samsung.com>
- *	Jinyoung Choi <j-young.choi@samsung.com>
- */
-
-#ifndef _UFSHPB_H_
-#define _UFSHPB_H_
-
-/* hpb response UPIU macro */
-#define HPB_RSP_NONE				0x0
-#define HPB_RSP_REQ_REGION_UPDATE		0x1
-#define HPB_RSP_DEV_RESET			0x2
-#define MAX_ACTIVE_NUM				2
-#define MAX_INACTIVE_NUM			2
-#define DEV_DATA_SEG_LEN			0x14
-#define DEV_SENSE_SEG_LEN			0x12
-#define DEV_DES_TYPE				0x80
-#define DEV_ADDITIONAL_LEN			0x10
-
-/* hpb map & entries macro */
-#define HPB_RGN_SIZE_UNIT			512
-#define HPB_ENTRY_BLOCK_SIZE			4096
-#define HPB_ENTRY_SIZE				0x8
-#define PINNED_NOT_SET				U32_MAX
-
-/* hpb support chunk size */
-#define HPB_LEGACY_CHUNK_HIGH			1
-#define HPB_MULTI_CHUNK_LOW			7
-#define HPB_MULTI_CHUNK_HIGH			255
-
-/* hpb vender defined opcode */
-#define UFSHPB_READ				0xF8
-#define UFSHPB_READ_BUFFER			0xF9
-#define UFSHPB_READ_BUFFER_ID			0x01
-#define UFSHPB_WRITE_BUFFER			0xFA
-#define UFSHPB_WRITE_BUFFER_INACT_SINGLE_ID	0x01
-#define UFSHPB_WRITE_BUFFER_PREFETCH_ID		0x02
-#define UFSHPB_WRITE_BUFFER_INACT_ALL_ID	0x03
-#define HPB_WRITE_BUFFER_CMD_LENGTH		10
-#define MAX_HPB_READ_ID				0x7F
-#define HPB_READ_BUFFER_CMD_LENGTH		10
-#define LU_ENABLED_HPB_FUNC			0x02
-
-#define HPB_RESET_REQ_RETRIES			10
-#define HPB_MAP_REQ_RETRIES			5
-#define HPB_REQUEUE_TIME_MS			0
-
-#define HPB_SUPPORT_VERSION			0x200
-#define HPB_SUPPORT_LEGACY_VERSION		0x100
-
-enum UFSHPB_MODE {
-	HPB_HOST_CONTROL,
-	HPB_DEVICE_CONTROL,
-};
-
-enum UFSHPB_STATE {
-	HPB_INIT = 0,
-	HPB_PRESENT = 1,
-	HPB_SUSPEND,
-	HPB_FAILED,
-	HPB_RESET,
-};
-
-enum HPB_RGN_STATE {
-	HPB_RGN_INACTIVE,
-	HPB_RGN_ACTIVE,
-	/* pinned regions are always active */
-	HPB_RGN_PINNED,
-};
-
-enum HPB_SRGN_STATE {
-	HPB_SRGN_UNUSED,
-	HPB_SRGN_INVALID,
-	HPB_SRGN_VALID,
-	HPB_SRGN_ISSUED,
-};
-
-/**
- * struct ufshpb_lu_info - UFSHPB logical unit related info
- * @num_blocks: the number of logical block
- * @pinned_start: the start region number of pinned region
- * @num_pinned: the number of pinned regions
- * @max_active_rgns: maximum number of active regions
- */
-struct ufshpb_lu_info {
-	int num_blocks;
-	int pinned_start;
-	int num_pinned;
-	int max_active_rgns;
-};
-
-struct ufshpb_map_ctx {
-	struct page **m_page;
-	unsigned long *ppn_dirty;
-};
-
-struct ufshpb_subregion {
-	struct ufshpb_map_ctx *mctx;
-	enum HPB_SRGN_STATE srgn_state;
-	int rgn_idx;
-	int srgn_idx;
-	bool is_last;
-
-	/* subregion reads - for host mode */
-	unsigned int reads;
-
-	/* below information is used by rsp_list */
-	struct list_head list_act_srgn;
-};
-
-struct ufshpb_region {
-	struct ufshpb_lu *hpb;
-	struct ufshpb_subregion *srgn_tbl;
-	enum HPB_RGN_STATE rgn_state;
-	int rgn_idx;
-	int srgn_cnt;
-
-	/* below information is used by rsp_list */
-	struct list_head list_inact_rgn;
-
-	/* below information is used by lru */
-	struct list_head list_lru_rgn;
-	unsigned long rgn_flags;
-#define RGN_FLAG_DIRTY 0
-#define RGN_FLAG_UPDATE 1
-
-	/* region reads - for host mode */
-	spinlock_t rgn_lock;
-	unsigned int reads;
-	/* region "cold" timer - for host mode */
-	ktime_t read_timeout;
-	unsigned int read_timeout_expiries;
-	struct list_head list_expired_rgn;
-};
-
-#define for_each_sub_region(rgn, i, srgn)				\
-	for ((i) = 0;							\
-	     ((i) < (rgn)->srgn_cnt) && ((srgn) = &(rgn)->srgn_tbl[i]); \
-	     (i)++)
-
-/**
- * struct ufshpb_req - HPB related request structure (write/read buffer)
- * @req: block layer request structure
- * @bio: bio for this request
- * @hpb: ufshpb_lu structure that related to
- * @list_req: ufshpb_req mempool list
- * @sense: store its sense data
- * @mctx: L2P map information
- * @rgn_idx: target region index
- * @srgn_idx: target sub-region index
- * @lun: target logical unit number
- * @m_page: L2P map information data for pre-request
- * @len: length of host-side cached L2P map in m_page
- * @lpn: start LPN of L2P map in m_page
- */
-struct ufshpb_req {
-	struct request *req;
-	struct bio *bio;
-	struct ufshpb_lu *hpb;
-	struct list_head list_req;
-	union {
-		struct {
-			struct ufshpb_map_ctx *mctx;
-			unsigned int rgn_idx;
-			unsigned int srgn_idx;
-			unsigned int lun;
-		} rb;
-		struct {
-			struct page *m_page;
-			unsigned int len;
-			unsigned long lpn;
-		} wb;
-	};
-};
-
-struct victim_select_info {
-	struct list_head lh_lru_rgn; /* LRU list of regions */
-	int max_lru_active_cnt; /* supported hpb #region - pinned #region */
-	atomic_t active_cnt;
-};
-
-/**
- * ufshpb_params - ufs hpb parameters
- * @requeue_timeout_ms - requeue threshold of wb command (0x2)
- * @activation_thld - min reads [IOs] to activate/update a region
- * @normalization_factor - shift right the region's reads
- * @eviction_thld_enter - min reads [IOs] for the entering region in eviction
- * @eviction_thld_exit - max reads [IOs] for the exiting region in eviction
- * @read_timeout_ms - timeout [ms] from the last read IO to the region
- * @read_timeout_expiries - amount of allowable timeout expireis
- * @timeout_polling_interval_ms - frequency in which timeouts are checked
- * @inflight_map_req - number of inflight map requests
- */
-struct ufshpb_params {
-	unsigned int requeue_timeout_ms;
-	unsigned int activation_thld;
-	unsigned int normalization_factor;
-	unsigned int eviction_thld_enter;
-	unsigned int eviction_thld_exit;
-	unsigned int read_timeout_ms;
-	unsigned int read_timeout_expiries;
-	unsigned int timeout_polling_interval_ms;
-	unsigned int inflight_map_req;
-};
-
-struct ufshpb_stats {
-	u64 hit_cnt;
-	u64 miss_cnt;
-	u64 rb_noti_cnt;
-	u64 rb_active_cnt;
-	u64 rb_inactive_cnt;
-	u64 map_req_cnt;
-	u64 pre_req_cnt;
-	u64 umap_req_cnt;
-};
-
-struct ufshpb_lu {
-	int lun;
-	struct scsi_device *sdev_ufs_lu;
-
-	spinlock_t rgn_state_lock; /* for protect rgn/srgn state */
-	struct ufshpb_region *rgn_tbl;
-
-	atomic_t hpb_state;
-
-	spinlock_t rsp_list_lock;
-	struct list_head lh_act_srgn; /* hold rsp_list_lock */
-	struct list_head lh_inact_rgn; /* hold rsp_list_lock */
-
-	/* pre request information */
-	struct ufshpb_req *pre_req;
-	int num_inflight_pre_req;
-	int throttle_pre_req;
-	int num_inflight_map_req; /* hold param_lock */
-	spinlock_t param_lock;
-
-	struct list_head lh_pre_req_free;
-	int cur_read_id;
-	int pre_req_min_tr_len;
-	int pre_req_max_tr_len;
-
-	/* cached L2P map management worker */
-	struct work_struct map_work;
-
-	/* for selecting victim */
-	struct victim_select_info lru_info;
-	struct work_struct ufshpb_normalization_work;
-	struct delayed_work ufshpb_read_to_work;
-	unsigned long work_data_bits;
-#define TIMEOUT_WORK_RUNNING 0
-
-	/* pinned region information */
-	u32 lu_pinned_start;
-	u32 lu_pinned_end;
-
-	/* HPB related configuration */
-	u32 rgns_per_lu;
-	u32 srgns_per_lu;
-	u32 last_srgn_entries;
-	int srgns_per_rgn;
-	u32 srgn_mem_size;
-	u32 entries_per_rgn_mask;
-	u32 entries_per_rgn_shift;
-	u32 entries_per_srgn;
-	u32 entries_per_srgn_mask;
-	u32 entries_per_srgn_shift;
-	u32 pages_per_srgn;
-
-	bool is_hcm;
-
-	struct ufshpb_stats stats;
-	struct ufshpb_params params;
-
-	struct kmem_cache *map_req_cache;
-	struct kmem_cache *m_page_cache;
-
-	struct list_head list_hpb_lu;
-};
-
-struct ufs_hba;
-struct ufshcd_lrb;
-
-#ifndef CONFIG_SCSI_UFS_HPB
-static int ufshpb_prep(struct ufs_hba *hba, struct ufshcd_lrb *lrbp) { return 0; }
-static void ufshpb_rsp_upiu(struct ufs_hba *hba, struct ufshcd_lrb *lrbp) {}
-static void ufshpb_resume(struct ufs_hba *hba) {}
-static void ufshpb_suspend(struct ufs_hba *hba) {}
-static void ufshpb_reset(struct ufs_hba *hba) {}
-static void ufshpb_reset_host(struct ufs_hba *hba) {}
-static void ufshpb_init(struct ufs_hba *hba) {}
-static void ufshpb_init_hpb_lu(struct ufs_hba *hba, struct scsi_device *sdev) {}
-static void ufshpb_destroy_lu(struct ufs_hba *hba, struct scsi_device *sdev) {}
-static void ufshpb_remove(struct ufs_hba *hba) {}
-static bool ufshpb_is_allowed(struct ufs_hba *hba) { return false; }
-static void ufshpb_get_geo_info(struct ufs_hba *hba, u8 *geo_buf) {}
-static void ufshpb_get_dev_info(struct ufs_hba *hba, u8 *desc_buf) {}
-static bool ufshpb_is_legacy(struct ufs_hba *hba) { return false; }
-#else
-int ufshpb_prep(struct ufs_hba *hba, struct ufshcd_lrb *lrbp);
-void ufshpb_rsp_upiu(struct ufs_hba *hba, struct ufshcd_lrb *lrbp);
-void ufshpb_resume(struct ufs_hba *hba);
-void ufshpb_suspend(struct ufs_hba *hba);
-void ufshpb_reset(struct ufs_hba *hba);
-void ufshpb_reset_host(struct ufs_hba *hba);
-void ufshpb_init(struct ufs_hba *hba);
-void ufshpb_init_hpb_lu(struct ufs_hba *hba, struct scsi_device *sdev);
-void ufshpb_destroy_lu(struct ufs_hba *hba, struct scsi_device *sdev);
-void ufshpb_remove(struct ufs_hba *hba);
-bool ufshpb_is_allowed(struct ufs_hba *hba);
-void ufshpb_get_geo_info(struct ufs_hba *hba, u8 *geo_buf);
-void ufshpb_get_dev_info(struct ufs_hba *hba, u8 *desc_buf);
-bool ufshpb_is_legacy(struct ufs_hba *hba);
-extern struct attribute_group ufs_sysfs_hpb_stat_group;
-extern struct attribute_group ufs_sysfs_hpb_param_group;
-#endif
-
-#endif /* End of Header */
-- 
2.30.2

