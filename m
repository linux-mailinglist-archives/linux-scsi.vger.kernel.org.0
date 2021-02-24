Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDA132367B
	for <lists+linux-scsi@lfdr.de>; Wed, 24 Feb 2021 05:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbhBXEzB (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 23 Feb 2021 23:55:01 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:49749 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbhBXEyz (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 23 Feb 2021 23:54:55 -0500
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210224045409epoutp0352f63f435a725e961351710051c7f4b6~mlgFeXZwb0454804548epoutp03x
        for <linux-scsi@vger.kernel.org>; Wed, 24 Feb 2021 04:54:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210224045409epoutp0352f63f435a725e961351710051c7f4b6~mlgFeXZwb0454804548epoutp03x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1614142449;
        bh=wL5xZPXwhLRfVi1/hgHN+tgbFr1jHIJ52UZnGj1Bk3M=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=kXGqTLgJRCJN8Mb6C9ceUJuQewKZF/PiKtnIq06lEl/oVP3uB6dxcD+fVKZmvLdFH
         rt/oCO9hGhASu4cZMkRSNPtFQTJjXAORf7UDPgPTppBBrR0u3Gjx8eGh0ENLaJ9Roo
         e3RseWgNsJbfG95a8ufjyEcFhhWaFfDsE2YLfjHc=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20210224045408epcas2p44bfd4a4d79646ede25a9b70d7a951717~mlgEoQNrq1065210652epcas2p4V;
        Wed, 24 Feb 2021 04:54:08 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.40.188]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Dlk8t0YhFz4x9QD; Wed, 24 Feb
        2021 04:54:06 +0000 (GMT)
X-AuditID: b6c32a45-34dff7000001297d-2a-6035dbed314f
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        65.8A.10621.DEBD5306; Wed, 24 Feb 2021 13:54:05 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v24 1/4] scsi: ufs: Introduce HPB feature
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From:   Daejun Park <daejun7.park@samsung.com>
To:     Daejun Park <daejun7.park@samsung.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "huobean@gmail.com" <huobean@gmail.com>,
        ALIM AKHTAR <alim.akhtar@samsung.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        JinHwan Park <jh.i.park@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>,
        SEUNGUK SHIN <seunguk.shin@samsung.com>,
        Sung-Jun Park <sungjun07.park@samsung.com>,
        yongmyung lee <ymhungry.lee@samsung.com>,
        Jinyoung CHOI <j-young.choi@samsung.com>,
        BoRam Shin <boram.shin@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20210224045323epcms2p66cc6a4b73086621e050da37f12f432f0@epcms2p6>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20210224045405epcms2p2d05f8563b1f121d2c2cc79b343e5af77@epcms2p2>
Date:   Wed, 24 Feb 2021 13:54:05 +0900
X-CMS-MailID: 20210224045405epcms2p2d05f8563b1f121d2c2cc79b343e5af77
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGJsWRmVeSWpSXmKPExsWy7bCmqe7b26YJBsunWFo8mLeNzWJv2wl2
        i5c/r7JZHL79jt1i2oefzBaf1i9jtXh5SNNi1YNwi+bF69ks5pxtYLLo7d/KZvH4zmd2i0U3
        tjFZ9P9rZ7G4vGsOm0X39R1sFsuP/2OyuL2Fy2Lp1puMFp3T17BYLFq4m8VB1OPyFW+Py329
        TB47Z91l95iw6ACjx/65a9g9Wk7uZ/H4+PQWi0ffllWMHp83yXm0H+hmCuCKyrHJSE1MSS1S
        SM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAfpQSaEsMacUKBSQWFys
        pG9nU5RfWpKqkJFfXGKrlFqQklNgaFigV5yYW1yal66XnJ9rZWhgYGQKVJmQk7H4bg9bQd9R
        por56w4zNTCe6WHqYuTkkBAwkZj8rI21i5GLQ0hgB6PE0XUPWboYOTh4BQQl/u4QBqkRFrCU
        ePK5lxXEFhJQklh/cRY7RFxP4tbDNYwgNpuAjsT0E/fZQeaICLSySCw6u5wJxGEWWMossfpp
        AzPENl6JGe1PWSBsaYnty7eCdXMK+EksXtrABhHXkPixrBeqXlTi5uq37DD2+2PzGSFsEYnW
        e2ehagQlHvzcDRWXlDi2+wPUZ/USW+/8YgQ5QkKgh1Hi8M5brBAJfYlrHRvBjuAV8JX40rkQ
        zGYRUJX4/W4m1CAXiav/L4DZzALyEtvfzmEGhQqzgKbE+l36IKaEgLLEkVssMG81bPzNjs5m
        FuCT6Dj8Fy6+Y94TqNPUJNb9XM80gVF5FiKoZyHZNQth1wJG5lWMYqkFxbnpqcVGBYbI8buJ
        EZzgtVx3ME5++0HvECMTB+MhRgkOZiURXra7RglCvCmJlVWpRfnxRaU5qcWHGE2BvpzILCWa
        nA/MMXkl8YamRmZmBpamFqZmRhZK4rzFBg/ihQTSE0tSs1NTC1KLYPqYODilGph2Cizzc47w
        CKrpP3/4O2vtRhbRzQLLnqR/1X0tWvVgn40MQ82h2svu3bwzXJr0lWo+TQmuMIvf1nUh9+GD
        Z8pzPoTfXFiwS/Rtpt3sU1k/g8xWXN32TeHAN5uVZa7cq4+0yzzf6MVvkmQosad8mtWPA7fu
        Hgt88vjVnVrxS/diNFbkPQm3LK3+kT2JV3mf49KHXu52kkfi+lh8V9a8ZZQ7lru1y/1BnETx
        0bnuCl9ePnPhSP+yLI7Ttn9jwO8SmWczu6OjfrN5n9xhuW7SaU6rR65MaaqChcWi149xdGZG
        fj/9LsC8TDXmwGvfiTwXF5l1ihvLtvNfq6/P23Xr9NPrn+4uUtXtibinzVwQnazEUpyRaKjF
        XFScCAAOVNKjeQQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210224045323epcms2p66cc6a4b73086621e050da37f12f432f0
References: <20210224045323epcms2p66cc6a4b73086621e050da37f12f432f0@epcms2p6>
        <CGME20210224045323epcms2p66cc6a4b73086621e050da37f12f432f0@epcms2p2>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This is a patch for the HPB initialization and adds HPB function calls to
UFS core driver.

NAND flash-based storage devices, including UFS, have mechanisms to
translate logical addresses of IO requests to the corresponding physical
addresses of the flash storage.
In UFS, Logical-address-to-Physical-address (L2P) map data, which is
required to identify the physical address for the requested IOs, can only
be partially stored in SRAM from NAND flash. Due to this partial loading,
accessing the flash address area where the L2P information for that address
is not loaded in the SRAM can result in serious performance degradation.

The basic concept of HPB is to cache L2P mapping entries in host system
memory so that both physical block address (PBA) and logical block address
(LBA) can be delivered in HPB read command.
The HPB READ command allows to read data faster than a read command in UFS
since it provides the physical address (HPB Entry) of the desired logical
block in addition to its logical address. The UFS device can access the
physical block in NAND directly without searching and uploading L2P mapping
table. This improves read performance because the NAND read operation for
uploading L2P mapping table is removed.

In HPB initialization, the host checks if the UFS device supports HPB
feature and retrieves related device capabilities. Then, some HPB
parameters are configured in the device.

We measured the total start-up time of popular applications and observed
the difference by enabling the HPB.
Popular applications are 12 game apps and 24 non-game apps. Each target
applications were launched in order. The cycle consists of running 36
applications in sequence. We repeated the cycle for observing performance
improvement by L2P mapping cache hit in HPB.

The Following is experiment environment:
 - kernel version: 4.4.0
 - RAM: 8GB
 - UFS 2.1 (64GB)

Result:
+-------+----------+----------+-------+
| cycle | baseline | with HPB | diff  |
+-------+----------+----------+-------+
| 1     | 272.4    | 264.9    | -7.5  |
| 2     | 250.4    | 248.2    | -2.2  |
| 3     | 226.2    | 215.6    | -10.6 |
| 4     | 230.6    | 214.8    | -15.8 |
| 5     | 232.0    | 218.1    | -13.9 |
| 6     | 231.9    | 212.6    | -19.3 |
+-------+----------+----------+-------+

We also measured HPB performance using iozone.
Here is my iozone script:
iozone -r 4k -+n -i2 -ecI -t 16 -l 16 -u 16
-s $IO_RANGE/16 -F mnt/tmp_1 mnt/tmp_2 mnt/tmp_3 mnt/tmp_4 mnt/tmp_5
mnt/tmp_6 mnt/tmp_7 mnt/tmp_8 mnt/tmp_9 mnt/tmp_10 mnt/tmp_11 mnt/tmp_12
mnt/tmp_13 mnt/tmp_14 mnt/tmp_15 mnt/tmp_16

Result:
+----------+--------+---------+
| IO range | HPB on | HPB off |
+----------+--------+---------+
|   1 GB   | 294.8  | 300.87  |
|   4 GB   | 293.51 | 179.35  |
|   8 GB   | 294.85 | 162.52  |
|  16 GB   | 293.45 | 156.26  |
|  32 GB   | 277.4  | 153.25  |
+----------+--------+---------+

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Can Guo <cang@codeaurora.org>
Acked-by: Avri Altman <Avri.Altman@wdc.com>
Tested-by: Bean Huo <beanhuo@micron.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Daejun Park <daejun7.park@samsung.com>
---
 Documentation/ABI/testing/sysfs-driver-ufs | 127 +++++
 drivers/scsi/ufs/Kconfig                   |   9 +
 drivers/scsi/ufs/Makefile                  |   1 +
 drivers/scsi/ufs/ufs-sysfs.c               |  18 +
 drivers/scsi/ufs/ufs.h                     |  15 +
 drivers/scsi/ufs/ufshcd.c                  |  49 ++
 drivers/scsi/ufs/ufshcd.h                  |  22 +
 drivers/scsi/ufs/ufshpb.c                  | 569 +++++++++++++++++++++
 drivers/scsi/ufs/ufshpb.h                  | 166 ++++++
 9 files changed, 976 insertions(+)
 create mode 100644 drivers/scsi/ufs/ufshpb.c
 create mode 100644 drivers/scsi/ufs/ufshpb.h

diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
index d1bc23cb6a9d..bf5cb8846de1 100644
--- a/Documentation/ABI/testing/sysfs-driver-ufs
+++ b/Documentation/ABI/testing/sysfs-driver-ufs
@@ -1172,3 +1172,130 @@ Description:	This node is used to set or display whether UFS WriteBooster is
 		(if the platform supports UFSHCD_CAP_CLK_SCALING). For a
 		platform that doesn't support UFSHCD_CAP_CLK_SCALING, we can
 		disable/enable WriteBooster through this sysfs node.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/hpb_version
+Date:		February 2021
+Contact:	Daejun Park <daejun7.park@samsung.com>
+Description:	This entry shows the HPB specification version.
+		The full information about the descriptor could be found at UFS
+		HPB (Host Performance Booster) Extension specifications.
+		Example: version 1.2.3 = 0123h
+
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/hpb_control
+Date:		February 2021
+Contact:	Daejun Park <daejun7.park@samsung.com>
+Description:	This entry shows an indication of the HPB control mode.
+		00h: Host control mode
+		01h: Device control mode
+
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/geometry_descriptor/hpb_region_size
+Date:		February 2021
+Contact:	Daejun Park <daejun7.park@samsung.com>
+Description:	This entry shows the bHPBRegionSize which can be calculated
+		as in the following (in bytes):
+		HPB Region size = 512B * 2^bHPBRegionSize
+
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/geometry_descriptor/hpb_number_lu
+Date:		February 2021
+Contact:	Daejun Park <daejun7.park@samsung.com>
+Description:	This entry shows the maximum number of HPB LU supported	by
+		the device.
+		00h: HPB is not supported by the device.
+		01h ~ 20h: Maximum number of HPB LU supported by the device
+
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/geometry_descriptor/hpb_subregion_size
+Date:		February 2021
+Contact:	Daejun Park <daejun7.park@samsung.com>
+Description:	This entry shows the bHPBSubRegionSize, which can be
+		calculated as in the following (in bytes) and shall be a multiple of
+		logical block size:
+		HPB Sub-Region size = 512B x 2^bHPBSubRegionSize
+		bHPBSubRegionSize shall not exceed bHPBRegionSize.
+
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/geometry_descriptor/hpb_max_active_regions
+Date:		February 2021
+Contact:	Daejun Park <daejun7.park@samsung.com>
+Description:	This entry shows the maximum number of active HPB regions that
+		is supported by the device.
+
+		The file is read only.
+
+What:		/sys/class/scsi_device/*/device/unit_descriptor/hpb_lu_max_active_regions
+Date:		February 2021
+Contact:	Daejun Park <daejun7.park@samsung.com>
+Description:	This entry shows the maximum number of HPB regions assigned to
+		the HPB logical unit.
+
+		The file is read only.
+
+What:		/sys/class/scsi_device/*/device/unit_descriptor/hpb_pinned_region_start_offset
+Date:		February 2021
+Contact:	Daejun Park <daejun7.park@samsung.com>
+Description:	This entry shows the start offset of HPB pinned region.
+
+		The file is read only.
+
+What:		/sys/class/scsi_device/*/device/unit_descriptor/hpb_number_pinned_regions
+Date:		February 2021
+Contact:	Daejun Park <daejun7.park@samsung.com>
+Description:	This entry shows the number of HPB pinned regions assigned to
+		the HPB logical unit.
+
+		The file is read only.
+
+What:		/sys/class/scsi_device/*/device/hpb_sysfs/hit_cnt
+Date:		February 2021
+Contact:	Daejun Park <daejun7.park@samsung.com>
+Description:	This entry shows the number of reads that changed to HPB read.
+
+		The file is read only.
+
+What:		/sys/class/scsi_device/*/device/hpb_sysfs/miss_cnt
+Date:		February 2021
+Contact:	Daejun Park <daejun7.park@samsung.com>
+Description:	This entry shows the number of reads that cannot be changed to
+		HPB read.
+
+		The file is read only.
+
+What:		/sys/class/scsi_device/*/device/hpb_sysfs/rb_noti_cnt
+Date:		February 2021
+Contact:	Daejun Park <daejun7.park@samsung.com>
+Description:	This entry shows the number of response UPIUs that has
+		recommendations for activating sub-regions and/or inactivating region.
+
+		The file is read only.
+
+What:		/sys/class/scsi_device/*/device/hpb_sysfs/rb_active_cnt
+Date:		February 2021
+Contact:	Daejun Park <daejun7.park@samsung.com>
+Description:	This entry shows the number of active sub-regions recommended by
+		response UPIUs.
+
+		The file is read only.
+
+What:		/sys/class/scsi_device/*/device/hpb_sysfs/rb_inactive_cnt
+Date:		February 2021
+Contact:	Daejun Park <daejun7.park@samsung.com>
+Description:	This entry shows the number of inactive regions recommended by
+		response UPIUs.
+
+		The file is read only.
+
+What:		/sys/class/scsi_device/*/device/hpb_sysfs/map_req_cnt
+Date:		February 2021
+Contact:	Daejun Park <daejun7.park@samsung.com>
+Description:	This entry shows the number of read buffer commands for
+		activating sub-regions recommended by response UPIUs.
+
+		The file is read only.
diff --git a/drivers/scsi/ufs/Kconfig b/drivers/scsi/ufs/Kconfig
index 07cf415367b4..29ec6e4a87bd 100644
--- a/drivers/scsi/ufs/Kconfig
+++ b/drivers/scsi/ufs/Kconfig
@@ -182,3 +182,12 @@ config SCSI_UFS_CRYPTO
 	  Enabling this makes it possible for the kernel to use the crypto
 	  capabilities of the UFS device (if present) to perform crypto
 	  operations on data being transferred to/from the device.
+
+config SCSI_UFS_HPB
+	bool "Support UFS Host Performance Booster"
+	depends on SCSI_UFSHCD
+	help
+	  The UFS HPB feature improves random read performance. It caches
+	  L2P (logical to physical) map of UFS to host DRAM. The driver uses HPB
+	  read command by piggybacking physical page number for bypassing FTL (flash
+	  translation layer)'s L2P address translation.
diff --git a/drivers/scsi/ufs/Makefile b/drivers/scsi/ufs/Makefile
index 06f3a3fe4a44..cce9b3916f5b 100644
--- a/drivers/scsi/ufs/Makefile
+++ b/drivers/scsi/ufs/Makefile
@@ -8,6 +8,7 @@ ufshcd-core-y				+= ufshcd.o ufs-sysfs.o
 ufshcd-core-$(CONFIG_DEBUG_FS)		+= ufs-debugfs.o
 ufshcd-core-$(CONFIG_SCSI_UFS_BSG)	+= ufs_bsg.o
 ufshcd-core-$(CONFIG_SCSI_UFS_CRYPTO)	+= ufshcd-crypto.o
+ufshcd-core-$(CONFIG_SCSI_UFS_HPB)	+= ufshpb.o
 
 obj-$(CONFIG_SCSI_UFS_DWC_TC_PCI) += tc-dwc-g210-pci.o ufshcd-dwc.o tc-dwc-g210.o
 obj-$(CONFIG_SCSI_UFS_DWC_TC_PLATFORM) += tc-dwc-g210-pltfrm.o ufshcd-dwc.o tc-dwc-g210.o
diff --git a/drivers/scsi/ufs/ufs-sysfs.c b/drivers/scsi/ufs/ufs-sysfs.c
index acc54f530f2d..2546e7a1ac4f 100644
--- a/drivers/scsi/ufs/ufs-sysfs.c
+++ b/drivers/scsi/ufs/ufs-sysfs.c
@@ -368,6 +368,8 @@ UFS_DEVICE_DESC_PARAM(device_version, _DEV_VER, 2);
 UFS_DEVICE_DESC_PARAM(number_of_secure_wpa, _NUM_SEC_WPA, 1);
 UFS_DEVICE_DESC_PARAM(psa_max_data_size, _PSA_MAX_DATA, 4);
 UFS_DEVICE_DESC_PARAM(psa_state_timeout, _PSA_TMT, 1);
+UFS_DEVICE_DESC_PARAM(hpb_version, _HPB_VER, 2);
+UFS_DEVICE_DESC_PARAM(hpb_control, _HPB_CONTROL, 1);
 UFS_DEVICE_DESC_PARAM(ext_feature_sup, _EXT_UFS_FEATURE_SUP, 4);
 UFS_DEVICE_DESC_PARAM(wb_presv_us_en, _WB_PRESRV_USRSPC_EN, 1);
 UFS_DEVICE_DESC_PARAM(wb_type, _WB_TYPE, 1);
@@ -400,6 +402,8 @@ static struct attribute *ufs_sysfs_device_descriptor[] = {
 	&dev_attr_number_of_secure_wpa.attr,
 	&dev_attr_psa_max_data_size.attr,
 	&dev_attr_psa_state_timeout.attr,
+	&dev_attr_hpb_version.attr,
+	&dev_attr_hpb_control.attr,
 	&dev_attr_ext_feature_sup.attr,
 	&dev_attr_wb_presv_us_en.attr,
 	&dev_attr_wb_type.attr,
@@ -473,6 +477,10 @@ UFS_GEOMETRY_DESC_PARAM(enh4_memory_max_alloc_units,
 	_ENM4_MAX_NUM_UNITS, 4);
 UFS_GEOMETRY_DESC_PARAM(enh4_memory_capacity_adjustment_factor,
 	_ENM4_CAP_ADJ_FCTR, 2);
+UFS_GEOMETRY_DESC_PARAM(hpb_region_size, _HPB_REGION_SIZE, 1);
+UFS_GEOMETRY_DESC_PARAM(hpb_number_lu, _HPB_NUMBER_LU, 1);
+UFS_GEOMETRY_DESC_PARAM(hpb_subregion_size, _HPB_SUBREGION_SIZE, 1);
+UFS_GEOMETRY_DESC_PARAM(hpb_max_active_regions, _HPB_MAX_ACTIVE_REGS, 2);
 UFS_GEOMETRY_DESC_PARAM(wb_max_alloc_units, _WB_MAX_ALLOC_UNITS, 4);
 UFS_GEOMETRY_DESC_PARAM(wb_max_wb_luns, _WB_MAX_WB_LUNS, 1);
 UFS_GEOMETRY_DESC_PARAM(wb_buff_cap_adj, _WB_BUFF_CAP_ADJ, 1);
@@ -510,6 +518,10 @@ static struct attribute *ufs_sysfs_geometry_descriptor[] = {
 	&dev_attr_enh3_memory_capacity_adjustment_factor.attr,
 	&dev_attr_enh4_memory_max_alloc_units.attr,
 	&dev_attr_enh4_memory_capacity_adjustment_factor.attr,
+	&dev_attr_hpb_region_size.attr,
+	&dev_attr_hpb_number_lu.attr,
+	&dev_attr_hpb_subregion_size.attr,
+	&dev_attr_hpb_max_active_regions.attr,
 	&dev_attr_wb_max_alloc_units.attr,
 	&dev_attr_wb_max_wb_luns.attr,
 	&dev_attr_wb_buff_cap_adj.attr,
@@ -923,6 +935,9 @@ UFS_UNIT_DESC_PARAM(provisioning_type, _PROVISIONING_TYPE, 1);
 UFS_UNIT_DESC_PARAM(physical_memory_resourse_count, _PHY_MEM_RSRC_CNT, 8);
 UFS_UNIT_DESC_PARAM(context_capabilities, _CTX_CAPABILITIES, 2);
 UFS_UNIT_DESC_PARAM(large_unit_granularity, _LARGE_UNIT_SIZE_M1, 1);
+UFS_UNIT_DESC_PARAM(hpb_lu_max_active_regions, _HPB_LU_MAX_ACTIVE_RGNS, 2);
+UFS_UNIT_DESC_PARAM(hpb_pinned_region_start_offset, _HPB_PIN_RGN_START_OFF, 2);
+UFS_UNIT_DESC_PARAM(hpb_number_pinned_regions, _HPB_NUM_PIN_RGNS, 2);
 UFS_UNIT_DESC_PARAM(wb_buf_alloc_units, _WB_BUF_ALLOC_UNITS, 4);
 
 
@@ -940,6 +955,9 @@ static struct attribute *ufs_sysfs_unit_descriptor[] = {
 	&dev_attr_physical_memory_resourse_count.attr,
 	&dev_attr_context_capabilities.attr,
 	&dev_attr_large_unit_granularity.attr,
+	&dev_attr_hpb_lu_max_active_regions.attr,
+	&dev_attr_hpb_pinned_region_start_offset.attr,
+	&dev_attr_hpb_number_pinned_regions.attr,
 	&dev_attr_wb_buf_alloc_units.attr,
 	NULL,
 };
diff --git a/drivers/scsi/ufs/ufs.h b/drivers/scsi/ufs/ufs.h
index bf1897a72532..65563635e20e 100644
--- a/drivers/scsi/ufs/ufs.h
+++ b/drivers/scsi/ufs/ufs.h
@@ -122,6 +122,7 @@ enum flag_idn {
 	QUERY_FLAG_IDN_WB_EN                            = 0x0E,
 	QUERY_FLAG_IDN_WB_BUFF_FLUSH_EN                 = 0x0F,
 	QUERY_FLAG_IDN_WB_BUFF_FLUSH_DURING_HIBERN8     = 0x10,
+	QUERY_FLAG_IDN_HPB_RESET                        = 0x11,
 };
 
 /* Attribute idn for Query requests */
@@ -195,6 +196,9 @@ enum unit_desc_param {
 	UNIT_DESC_PARAM_PHY_MEM_RSRC_CNT	= 0x18,
 	UNIT_DESC_PARAM_CTX_CAPABILITIES	= 0x20,
 	UNIT_DESC_PARAM_LARGE_UNIT_SIZE_M1	= 0x22,
+	UNIT_DESC_PARAM_HPB_LU_MAX_ACTIVE_RGNS	= 0x23,
+	UNIT_DESC_PARAM_HPB_PIN_RGN_START_OFF	= 0x25,
+	UNIT_DESC_PARAM_HPB_NUM_PIN_RGNS	= 0x27,
 	UNIT_DESC_PARAM_WB_BUF_ALLOC_UNITS	= 0x29,
 };
 
@@ -235,6 +239,8 @@ enum device_desc_param {
 	DEVICE_DESC_PARAM_PSA_MAX_DATA		= 0x25,
 	DEVICE_DESC_PARAM_PSA_TMT		= 0x29,
 	DEVICE_DESC_PARAM_PRDCT_REV		= 0x2A,
+	DEVICE_DESC_PARAM_HPB_VER		= 0x40,
+	DEVICE_DESC_PARAM_HPB_CONTROL		= 0x42,
 	DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP	= 0x4F,
 	DEVICE_DESC_PARAM_WB_PRESRV_USRSPC_EN	= 0x53,
 	DEVICE_DESC_PARAM_WB_TYPE		= 0x54,
@@ -283,6 +289,10 @@ enum geometry_desc_param {
 	GEOMETRY_DESC_PARAM_ENM4_MAX_NUM_UNITS	= 0x3E,
 	GEOMETRY_DESC_PARAM_ENM4_CAP_ADJ_FCTR	= 0x42,
 	GEOMETRY_DESC_PARAM_OPT_LOG_BLK_SIZE	= 0x44,
+	GEOMETRY_DESC_PARAM_HPB_REGION_SIZE	= 0x48,
+	GEOMETRY_DESC_PARAM_HPB_NUMBER_LU	= 0x49,
+	GEOMETRY_DESC_PARAM_HPB_SUBREGION_SIZE	= 0x4A,
+	GEOMETRY_DESC_PARAM_HPB_MAX_ACTIVE_REGS	= 0x4B,
 	GEOMETRY_DESC_PARAM_WB_MAX_ALLOC_UNITS	= 0x4F,
 	GEOMETRY_DESC_PARAM_WB_MAX_WB_LUNS	= 0x53,
 	GEOMETRY_DESC_PARAM_WB_BUFF_CAP_ADJ	= 0x54,
@@ -327,8 +337,10 @@ enum {
 
 /* Possible values for dExtendedUFSFeaturesSupport */
 enum {
+	UFS_DEV_HPB_SUPPORT		= BIT(7),
 	UFS_DEV_WRITE_BOOSTER_SUP	= BIT(8),
 };
+#define UFS_DEV_HPB_SUPPORT_VERSION		0x310
 
 #define POWER_DESC_MAX_ACTV_ICC_LVLS		16
 
@@ -538,6 +550,9 @@ struct ufs_dev_info {
 	u16	wspecversion;
 	u32	clk_gating_wait_us;
 
+	/* UFS HPB related flag */
+	bool	hpb_enabled;
+
 	/* UFS WB related flags */
 	bool    wb_enabled;
 	bool    wb_buf_flush_enabled;
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 80620c866192..49b3d5d24fa6 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -23,6 +23,7 @@
 #include "ufs-debugfs.h"
 #include "ufs_bsg.h"
 #include "ufshcd-crypto.h"
+#include "ufshpb.h"
 #include <asm/unaligned.h>
 #include <linux/blkdev.h>
 
@@ -4859,6 +4860,25 @@ static int ufshcd_change_queue_depth(struct scsi_device *sdev, int depth)
 	return scsi_change_queue_depth(sdev, depth);
 }
 
+static void ufshcd_hpb_destroy(struct ufs_hba *hba, struct scsi_device *sdev)
+{
+	/* skip well-known LU */
+	if ((sdev->lun >= UFS_UPIU_MAX_UNIT_NUM_ID) || !ufshpb_is_allowed(hba))
+		return;
+
+	ufshpb_destroy_lu(hba, sdev);
+}
+
+static void ufshcd_hpb_configure(struct ufs_hba *hba, struct scsi_device *sdev)
+{
+	/* skip well-known LU */
+	if ((sdev->lun >= UFS_UPIU_MAX_UNIT_NUM_ID) ||
+	    !(hba->dev_info.hpb_enabled) || !ufshpb_is_allowed(hba))
+		return;
+
+	ufshpb_init_hpb_lu(hba, sdev);
+}
+
 /**
  * ufshcd_slave_configure - adjust SCSI device configurations
  * @sdev: pointer to SCSI device
@@ -4868,6 +4888,8 @@ static int ufshcd_slave_configure(struct scsi_device *sdev)
 	struct ufs_hba *hba = shost_priv(sdev->host);
 	struct request_queue *q = sdev->request_queue;
 
+	ufshcd_hpb_configure(hba, sdev);
+
 	blk_queue_update_dma_pad(q, PRDT_DATA_BYTE_COUNT_PAD - 1);
 	if (hba->quirks & UFSHCD_QUIRK_ALIGN_SG_WITH_PAGE_SIZE)
 		blk_queue_update_dma_alignment(q, PAGE_SIZE - 1);
@@ -4889,6 +4911,9 @@ static void ufshcd_slave_destroy(struct scsi_device *sdev)
 	struct ufs_hba *hba;
 
 	hba = shost_priv(sdev->host);
+
+	ufshcd_hpb_destroy(hba, sdev);
+
 	/* Drop the reference as it won't be needed anymore */
 	if (ufshcd_scsi_to_upiu_lun(sdev->lun) == UFS_UPIU_UFS_DEVICE_WLUN) {
 		unsigned long flags;
@@ -6979,6 +7004,8 @@ static int ufshcd_host_reset_and_restore(struct ufs_hba *hba)
 	 * Stop the host controller and complete the requests
 	 * cleared by h/w
 	 */
+	ufshpb_reset_host(hba);
+
 	ufshcd_hba_stop(hba);
 
 	spin_lock_irqsave(hba->host->host_lock, flags);
@@ -7381,6 +7408,7 @@ static int ufs_get_device_desc(struct ufs_hba *hba)
 {
 	int err;
 	u8 model_index;
+	u8 b_ufs_feature_sup;
 	u8 *desc_buf;
 	struct ufs_dev_info *dev_info = &hba->dev_info;
 
@@ -7408,9 +7436,16 @@ static int ufs_get_device_desc(struct ufs_hba *hba)
 	/* getting Specification Version in big endian format */
 	dev_info->wspecversion = desc_buf[DEVICE_DESC_PARAM_SPEC_VER] << 8 |
 				      desc_buf[DEVICE_DESC_PARAM_SPEC_VER + 1];
+	b_ufs_feature_sup = desc_buf[DEVICE_DESC_PARAM_UFS_FEAT];
 
 	model_index = desc_buf[DEVICE_DESC_PARAM_PRDCT_NAME];
 
+	if (dev_info->wspecversion >= UFS_DEV_HPB_SUPPORT_VERSION &&
+	    (b_ufs_feature_sup & UFS_DEV_HPB_SUPPORT)) {
+		dev_info->hpb_enabled = true;
+		ufshpb_get_dev_info(hba, desc_buf);
+	}
+
 	err = ufshcd_read_string_desc(hba, model_index,
 				      &dev_info->model, SD_ASCII_STD);
 	if (err < 0) {
@@ -7639,6 +7674,10 @@ static int ufshcd_device_geo_params_init(struct ufs_hba *hba)
 	else if (desc_buf[GEOMETRY_DESC_PARAM_MAX_NUM_LUN] == 0)
 		hba->dev_info.max_lu_supported = 8;
 
+	if (hba->desc_size[QUERY_DESC_IDN_GEOMETRY] >=
+		GEOMETRY_DESC_PARAM_HPB_MAX_ACTIVE_REGS)
+		ufshpb_get_geo_info(hba, desc_buf);
+
 out:
 	kfree(desc_buf);
 	return err;
@@ -7781,6 +7820,7 @@ static int ufshcd_add_lus(struct ufs_hba *hba)
 	}
 
 	ufs_bsg_probe(hba);
+	ufshpb_init(hba);
 	scsi_scan_host(hba->host);
 	pm_runtime_put_sync(hba->dev);
 
@@ -7924,6 +7964,7 @@ static int ufshcd_probe_hba(struct ufs_hba *hba, bool async)
 	/* Enable Auto-Hibernate if configured */
 	ufshcd_auto_hibern8_enable(hba);
 
+	ufshpb_reset(hba);
 out:
 	spin_lock_irqsave(hba->host->host_lock, flags);
 	if (ret)
@@ -7971,6 +8012,9 @@ static void ufshcd_async_scan(void *data, async_cookie_t cookie)
 static const struct attribute_group *ufshcd_driver_groups[] = {
 	&ufs_sysfs_unit_descriptor_group,
 	&ufs_sysfs_lun_attributes_group,
+#ifdef CONFIG_SCSI_UFS_HPB
+	&ufs_sysfs_hpb_stat_group,
+#endif
 	NULL,
 };
 
@@ -8687,6 +8731,8 @@ static int ufshcd_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 		req_link_state = UIC_LINK_OFF_STATE;
 	}
 
+	ufshpb_suspend(hba);
+
 	/*
 	 * If we can't transition into any of the low power modes
 	 * just gate the clocks.
@@ -8822,6 +8868,7 @@ static int ufshcd_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 	hba->dev_info.b_rpm_dev_flush_capable = false;
 	ufshcd_clear_ua_wluns(hba);
 	ufshcd_release(hba);
+	ufshpb_resume(hba);
 out:
 	if (hba->dev_info.b_rpm_dev_flush_capable) {
 		schedule_delayed_work(&hba->rpm_dev_flush_recheck_work,
@@ -8926,6 +8973,8 @@ static int ufshcd_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 	/* Enable Auto-Hibernate if configured */
 	ufshcd_auto_hibern8_enable(hba);
 
+	ufshpb_resume(hba);
+
 	if (hba->dev_info.b_rpm_dev_flush_capable) {
 		hba->dev_info.b_rpm_dev_flush_capable = false;
 		cancel_delayed_work(&hba->rpm_dev_flush_recheck_work);
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index ee61f821f75d..961fc5b77943 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -645,6 +645,25 @@ struct ufs_hba_variant_params {
 	u32 wb_flush_threshold;
 };
 
+#ifdef CONFIG_SCSI_UFS_HPB
+/**
+ * struct ufshpb_dev_info - UFSHPB device related info
+ * @num_lu: the number of user logical unit to check whether all lu finished
+ *          initialization
+ * @rgn_size: device reported HPB region size
+ * @srgn_size: device reported HPB sub-region size
+ * @slave_conf_cnt: counter to check all lu finished initialization
+ * @hpb_disabled: flag to check if HPB is disabled
+ */
+struct ufshpb_dev_info {
+	int num_lu;
+	int rgn_size;
+	int srgn_size;
+	atomic_t slave_conf_cnt;
+	bool hpb_disabled;
+};
+#endif
+
 /**
  * struct ufs_hba - per adapter private structure
  * @mmio_base: UFSHCI base register address
@@ -832,6 +851,9 @@ struct ufs_hba {
 	struct request_queue	*bsg_queue;
 	struct delayed_work rpm_dev_flush_recheck_work;
 
+#ifdef CONFIG_SCSI_UFS_HPB
+	struct ufshpb_dev_info ufshpb_dev;
+#endif
 #ifdef CONFIG_SCSI_UFS_CRYPTO
 	union ufs_crypto_capabilities crypto_capabilities;
 	union ufs_crypto_cap_entry *crypto_cap_array;
diff --git a/drivers/scsi/ufs/ufshpb.c b/drivers/scsi/ufs/ufshpb.c
new file mode 100644
index 000000000000..a36ca89ccd8b
--- /dev/null
+++ b/drivers/scsi/ufs/ufshpb.c
@@ -0,0 +1,569 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Universal Flash Storage Host Performance Booster
+ *
+ * Copyright (C) 2017-2021 Samsung Electronics Co., Ltd.
+ *
+ * Authors:
+ *	Yongmyung Lee <ymhungry.lee@samsung.com>
+ *	Jinyoung Choi <j-young.choi@samsung.com>
+ */
+
+#include <asm/unaligned.h>
+#include <linux/async.h>
+
+#include "ufshcd.h"
+#include "ufshpb.h"
+#include "../sd.h"
+
+bool ufshpb_is_allowed(struct ufs_hba *hba)
+{
+	return !(hba->ufshpb_dev.hpb_disabled);
+}
+
+static struct ufshpb_lu *ufshpb_get_hpb_data(struct scsi_device *sdev)
+{
+	return sdev->hostdata;
+}
+
+static int ufshpb_get_state(struct ufshpb_lu *hpb)
+{
+	return atomic_read(&hpb->hpb_state);
+}
+
+static void ufshpb_set_state(struct ufshpb_lu *hpb, int state)
+{
+	atomic_set(&hpb->hpb_state, state);
+}
+
+static void ufshpb_init_subregion_tbl(struct ufshpb_lu *hpb,
+				      struct ufshpb_region *rgn, bool last)
+{
+	int srgn_idx;
+	struct ufshpb_subregion *srgn;
+
+	for (srgn_idx = 0; srgn_idx < rgn->srgn_cnt; srgn_idx++) {
+		srgn = rgn->srgn_tbl + srgn_idx;
+
+		srgn->rgn_idx = rgn->rgn_idx;
+		srgn->srgn_idx = srgn_idx;
+		srgn->srgn_state = HPB_SRGN_UNUSED;
+	}
+
+	if (unlikely(last && hpb->last_srgn_entries))
+		srgn->is_last = true;
+}
+
+static int ufshpb_alloc_subregion_tbl(struct ufshpb_lu *hpb,
+				      struct ufshpb_region *rgn, int srgn_cnt)
+{
+	rgn->srgn_tbl = kvcalloc(srgn_cnt, sizeof(struct ufshpb_subregion),
+				 GFP_KERNEL);
+	if (!rgn->srgn_tbl)
+		return -ENOMEM;
+
+	rgn->srgn_cnt = srgn_cnt;
+	return 0;
+}
+
+static void ufshpb_lu_parameter_init(struct ufs_hba *hba,
+				     struct ufshpb_lu *hpb,
+				     struct ufshpb_dev_info *hpb_dev_info,
+				     struct ufshpb_lu_info *hpb_lu_info)
+{
+	u32 entries_per_rgn;
+	u64 rgn_mem_size, tmp;
+
+	hpb->lu_pinned_start = hpb_lu_info->pinned_start;
+	hpb->lu_pinned_end = hpb_lu_info->num_pinned ?
+		(hpb_lu_info->pinned_start + hpb_lu_info->num_pinned - 1)
+		: PINNED_NOT_SET;
+
+	rgn_mem_size = (1ULL << hpb_dev_info->rgn_size) * HPB_RGN_SIZE_UNIT
+			* HPB_ENTRY_SIZE;
+	do_div(rgn_mem_size, HPB_ENTRY_BLOCK_SIZE);
+	hpb->srgn_mem_size = (1ULL << hpb_dev_info->srgn_size)
+		* HPB_RGN_SIZE_UNIT / HPB_ENTRY_BLOCK_SIZE * HPB_ENTRY_SIZE;
+
+	tmp = rgn_mem_size;
+	do_div(tmp, HPB_ENTRY_SIZE);
+	entries_per_rgn = (u32)tmp;
+	hpb->entries_per_rgn_shift = ilog2(entries_per_rgn);
+	hpb->entries_per_rgn_mask = entries_per_rgn - 1;
+
+	hpb->entries_per_srgn = hpb->srgn_mem_size / HPB_ENTRY_SIZE;
+	hpb->entries_per_srgn_shift = ilog2(hpb->entries_per_srgn);
+	hpb->entries_per_srgn_mask = hpb->entries_per_srgn - 1;
+
+	tmp = rgn_mem_size;
+	do_div(tmp, hpb->srgn_mem_size);
+	hpb->srgns_per_rgn = (int)tmp;
+
+	hpb->rgns_per_lu = DIV_ROUND_UP(hpb_lu_info->num_blocks,
+				entries_per_rgn);
+	hpb->srgns_per_lu = DIV_ROUND_UP(hpb_lu_info->num_blocks,
+				(hpb->srgn_mem_size / HPB_ENTRY_SIZE));
+	hpb->last_srgn_entries = hpb_lu_info->num_blocks
+				 % (hpb->srgn_mem_size / HPB_ENTRY_SIZE);
+
+	hpb->pages_per_srgn = DIV_ROUND_UP(hpb->srgn_mem_size, PAGE_SIZE);
+}
+
+static int ufshpb_alloc_region_tbl(struct ufs_hba *hba, struct ufshpb_lu *hpb)
+{
+	struct ufshpb_region *rgn_table, *rgn;
+	int rgn_idx, i;
+	int ret = 0;
+
+	rgn_table = kvcalloc(hpb->rgns_per_lu, sizeof(struct ufshpb_region),
+			    GFP_KERNEL);
+	if (!rgn_table)
+		return -ENOMEM;
+
+	hpb->rgn_tbl = rgn_table;
+
+	for (rgn_idx = 0; rgn_idx < hpb->rgns_per_lu; rgn_idx++) {
+		int srgn_cnt = hpb->srgns_per_rgn;
+		bool last_srgn = false;
+
+		rgn = rgn_table + rgn_idx;
+		rgn->rgn_idx = rgn_idx;
+
+		if (rgn_idx == hpb->rgns_per_lu - 1) {
+			srgn_cnt = ((hpb->srgns_per_lu - 1) %
+				    hpb->srgns_per_rgn) + 1;
+			last_srgn = true;
+		}
+
+		ret = ufshpb_alloc_subregion_tbl(hpb, rgn, srgn_cnt);
+		if (ret)
+			goto release_srgn_table;
+		ufshpb_init_subregion_tbl(hpb, rgn, last_srgn);
+
+		rgn->rgn_state = HPB_RGN_INACTIVE;
+	}
+
+	return 0;
+
+release_srgn_table:
+	for (i = 0; i < rgn_idx; i++) {
+		rgn = rgn_table + i;
+		if (rgn->srgn_tbl)
+			kvfree(rgn->srgn_tbl);
+	}
+	kvfree(rgn_table);
+	return ret;
+}
+
+static void ufshpb_destroy_subregion_tbl(struct ufshpb_lu *hpb,
+					 struct ufshpb_region *rgn)
+{
+	int srgn_idx;
+
+	for (srgn_idx = 0; srgn_idx < rgn->srgn_cnt; srgn_idx++) {
+		struct ufshpb_subregion *srgn;
+
+		srgn = rgn->srgn_tbl + srgn_idx;
+		srgn->srgn_state = HPB_SRGN_UNUSED;
+	}
+}
+
+static void ufshpb_destroy_region_tbl(struct ufshpb_lu *hpb)
+{
+	int rgn_idx;
+
+	for (rgn_idx = 0; rgn_idx < hpb->rgns_per_lu; rgn_idx++) {
+		struct ufshpb_region *rgn;
+
+		rgn = hpb->rgn_tbl + rgn_idx;
+		if (rgn->rgn_state != HPB_RGN_INACTIVE) {
+			rgn->rgn_state = HPB_RGN_INACTIVE;
+
+			ufshpb_destroy_subregion_tbl(hpb, rgn);
+		}
+
+		kvfree(rgn->srgn_tbl);
+	}
+
+	kvfree(hpb->rgn_tbl);
+}
+
+/* SYSFS functions */
+#define ufshpb_sysfs_attr_show_func(__name)				\
+static ssize_t __name##_show(struct device *dev,			\
+	struct device_attribute *attr, char *buf)			\
+{									\
+	struct scsi_device *sdev = to_scsi_device(dev);			\
+	struct ufshpb_lu *hpb = ufshpb_get_hpb_data(sdev);		\
+	if (!hpb)							\
+		return -ENODEV;						\
+									\
+	return sysfs_emit(buf, "%llu\n", hpb->stats.__name);		\
+}									\
+\
+static DEVICE_ATTR_RO(__name)
+
+ufshpb_sysfs_attr_show_func(hit_cnt);
+ufshpb_sysfs_attr_show_func(miss_cnt);
+ufshpb_sysfs_attr_show_func(rb_noti_cnt);
+ufshpb_sysfs_attr_show_func(rb_active_cnt);
+ufshpb_sysfs_attr_show_func(rb_inactive_cnt);
+ufshpb_sysfs_attr_show_func(map_req_cnt);
+
+static struct attribute *hpb_dev_attrs[] = {
+	&dev_attr_hit_cnt.attr,
+	&dev_attr_miss_cnt.attr,
+	&dev_attr_rb_noti_cnt.attr,
+	&dev_attr_rb_active_cnt.attr,
+	&dev_attr_rb_inactive_cnt.attr,
+	&dev_attr_map_req_cnt.attr,
+	NULL,
+};
+
+struct attribute_group ufs_sysfs_hpb_stat_group = {
+	.name = "hpb_sysfs",
+	.attrs = hpb_dev_attrs,
+};
+
+static void ufshpb_stat_init(struct ufshpb_lu *hpb)
+{
+	hpb->stats.hit_cnt = 0;
+	hpb->stats.miss_cnt = 0;
+	hpb->stats.rb_noti_cnt = 0;
+	hpb->stats.rb_active_cnt = 0;
+	hpb->stats.rb_inactive_cnt = 0;
+	hpb->stats.map_req_cnt = 0;
+}
+
+static int ufshpb_lu_hpb_init(struct ufs_hba *hba, struct ufshpb_lu *hpb)
+{
+	int ret;
+
+	ret = ufshpb_alloc_region_tbl(hba, hpb);
+
+	ufshpb_stat_init(hpb);
+
+	return 0;
+}
+
+static struct ufshpb_lu *
+ufshpb_alloc_hpb_lu(struct ufs_hba *hba, int lun,
+		    struct ufshpb_dev_info *hpb_dev_info,
+		    struct ufshpb_lu_info *hpb_lu_info)
+{
+	struct ufshpb_lu *hpb;
+	int ret;
+
+	hpb = kzalloc(sizeof(struct ufshpb_lu), GFP_KERNEL);
+	if (!hpb)
+		return NULL;
+
+	hpb->lun = lun;
+
+	ufshpb_lu_parameter_init(hba, hpb, hpb_dev_info, hpb_lu_info);
+
+	ret = ufshpb_lu_hpb_init(hba, hpb);
+	if (ret) {
+		dev_err(hba->dev, "hpb lu init failed. ret %d", ret);
+		goto release_hpb;
+	}
+
+	return hpb;
+
+release_hpb:
+	kfree(hpb);
+	return NULL;
+}
+
+static bool ufshpb_check_hpb_reset_query(struct ufs_hba *hba)
+{
+	int err = 0;
+	bool flag_res = true;
+	int try;
+
+	/* wait for the device to complete HPB reset query */
+	for (try = 0; try < HPB_RESET_REQ_RETRIES; try++) {
+		dev_dbg(hba->dev,
+			"%s start flag reset polling %d times\n",
+			__func__, try);
+
+		/* Poll fHpbReset flag to be cleared */
+		err = ufshcd_query_flag(hba, UPIU_QUERY_OPCODE_READ_FLAG,
+				QUERY_FLAG_IDN_HPB_RESET, 0, &flag_res);
+
+		if (err) {
+			dev_err(hba->dev,
+				"%s reading fHpbReset flag failed with error %d\n",
+				__func__, err);
+			return flag_res;
+		}
+
+		if (!flag_res)
+			goto out;
+
+		usleep_range(1000, 1100);
+	}
+	if (flag_res) {
+		dev_err(hba->dev,
+			"%s fHpbReset was not cleared by the device\n",
+			__func__);
+	}
+out:
+	return flag_res;
+}
+
+void ufshpb_reset(struct ufs_hba *hba)
+{
+	struct ufshpb_lu *hpb;
+	struct scsi_device *sdev;
+
+	shost_for_each_device(sdev, hba->host) {
+		hpb = sdev->hostdata;
+		if (!hpb)
+			continue;
+
+		if (ufshpb_get_state(hpb) != HPB_RESET)
+			continue;
+
+		ufshpb_set_state(hpb, HPB_PRESENT);
+	}
+}
+
+void ufshpb_reset_host(struct ufs_hba *hba)
+{
+	struct ufshpb_lu *hpb;
+	struct scsi_device *sdev;
+
+	shost_for_each_device(sdev, hba->host) {
+		hpb = sdev->hostdata;
+		if (!hpb)
+			continue;
+
+		if (ufshpb_get_state(hpb) != HPB_PRESENT)
+			continue;
+		ufshpb_set_state(hpb, HPB_RESET);
+	}
+}
+
+void ufshpb_suspend(struct ufs_hba *hba)
+{
+	struct ufshpb_lu *hpb;
+	struct scsi_device *sdev;
+
+	shost_for_each_device(sdev, hba->host) {
+		hpb = sdev->hostdata;
+		if (!hpb)
+			continue;
+
+		if (ufshpb_get_state(hpb) != HPB_PRESENT)
+			continue;
+		ufshpb_set_state(hpb, HPB_SUSPEND);
+	}
+}
+
+void ufshpb_resume(struct ufs_hba *hba)
+{
+	struct ufshpb_lu *hpb;
+	struct scsi_device *sdev;
+
+	shost_for_each_device(sdev, hba->host) {
+		hpb = sdev->hostdata;
+		if (!hpb)
+			continue;
+
+		if ((ufshpb_get_state(hpb) != HPB_PRESENT) &&
+		    (ufshpb_get_state(hpb) != HPB_SUSPEND))
+			continue;
+		ufshpb_set_state(hpb, HPB_PRESENT);
+	}
+}
+
+static int ufshpb_get_lu_info(struct ufs_hba *hba, int lun,
+			      struct ufshpb_lu_info *hpb_lu_info)
+{
+	u16 max_active_rgns;
+	u8 lu_enable;
+	int size;
+	int ret;
+	char desc_buf[QUERY_DESC_MAX_SIZE];
+
+	ufshcd_map_desc_id_to_length(hba, QUERY_DESC_IDN_UNIT, &size);
+
+	pm_runtime_get_sync(hba->dev);
+	ret = ufshcd_query_descriptor_retry(hba, UPIU_QUERY_OPCODE_READ_DESC,
+					    QUERY_DESC_IDN_UNIT, lun, 0,
+					    desc_buf, &size);
+	pm_runtime_put_sync(hba->dev);
+
+	if (ret) {
+		dev_err(hba->dev,
+			"%s: idn: %d lun: %d  query request failed",
+			__func__, QUERY_DESC_IDN_UNIT, lun);
+		return ret;
+	}
+
+	lu_enable = desc_buf[UNIT_DESC_PARAM_LU_ENABLE];
+	if (lu_enable != LU_ENABLED_HPB_FUNC)
+		return -ENODEV;
+
+	max_active_rgns = get_unaligned_be16(
+			desc_buf + UNIT_DESC_PARAM_HPB_LU_MAX_ACTIVE_RGNS);
+	if (!max_active_rgns) {
+		dev_err(hba->dev,
+			"lun %d wrong number of max active regions\n", lun);
+		return -ENODEV;
+	}
+
+	hpb_lu_info->num_blocks = get_unaligned_be64(
+			desc_buf + UNIT_DESC_PARAM_LOGICAL_BLK_COUNT);
+	hpb_lu_info->pinned_start = get_unaligned_be16(
+			desc_buf + UNIT_DESC_PARAM_HPB_PIN_RGN_START_OFF);
+	hpb_lu_info->num_pinned = get_unaligned_be16(
+			desc_buf + UNIT_DESC_PARAM_HPB_NUM_PIN_RGNS);
+	hpb_lu_info->max_active_rgns = max_active_rgns;
+
+	return 0;
+}
+
+void ufshpb_destroy_lu(struct ufs_hba *hba, struct scsi_device *sdev)
+{
+	struct ufshpb_lu *hpb = sdev->hostdata;
+
+	if (!hpb)
+		return;
+
+	ufshpb_set_state(hpb, HPB_FAILED);
+
+	sdev = hpb->sdev_ufs_lu;
+	sdev->hostdata = NULL;
+
+	ufshpb_destroy_region_tbl(hpb);
+
+	list_del_init(&hpb->list_hpb_lu);
+
+	kfree(hpb);
+}
+
+static void ufshpb_hpb_lu_prepared(struct ufs_hba *hba)
+{
+	struct ufshpb_lu *hpb;
+	struct scsi_device *sdev;
+	bool init_success;
+
+	init_success = !ufshpb_check_hpb_reset_query(hba);
+
+	shost_for_each_device(sdev, hba->host) {
+		hpb = sdev->hostdata;
+		if (!hpb)
+			continue;
+
+		if (init_success) {
+			ufshpb_set_state(hpb, HPB_PRESENT);
+		} else {
+			dev_err(hba->dev, "destroy HPB lu %d\n", hpb->lun);
+			ufshpb_destroy_lu(hba, sdev);
+		}
+	}
+}
+
+void ufshpb_init_hpb_lu(struct ufs_hba *hba, struct scsi_device *sdev)
+{
+	struct ufshpb_lu *hpb;
+	int ret;
+	struct ufshpb_lu_info hpb_lu_info = { 0 };
+	int lun = sdev->lun;
+
+	if (lun >= hba->dev_info.max_lu_supported)
+		goto out;
+
+	ret = ufshpb_get_lu_info(hba, lun, &hpb_lu_info);
+	if (ret)
+		goto out;
+
+	hpb = ufshpb_alloc_hpb_lu(hba, lun, &hba->ufshpb_dev,
+				  &hpb_lu_info);
+	if (!hpb)
+		goto out;
+
+	hpb->sdev_ufs_lu = sdev;
+	sdev->hostdata = hpb;
+
+out:
+	/* All LUs are initialized */
+	if (atomic_dec_and_test(&hba->ufshpb_dev.slave_conf_cnt))
+		ufshpb_hpb_lu_prepared(hba);
+}
+
+void ufshpb_get_geo_info(struct ufs_hba *hba, u8 *geo_buf)
+{
+	struct ufshpb_dev_info *hpb_info = &hba->ufshpb_dev;
+	int max_active_rgns = 0;
+	int hpb_num_lu;
+
+	hpb_num_lu = geo_buf[GEOMETRY_DESC_PARAM_HPB_NUMBER_LU];
+	if (hpb_num_lu == 0) {
+		dev_err(hba->dev, "No HPB LU supported\n");
+		hpb_info->hpb_disabled = true;
+		return;
+	}
+
+	hpb_info->rgn_size = geo_buf[GEOMETRY_DESC_PARAM_HPB_REGION_SIZE];
+	hpb_info->srgn_size = geo_buf[GEOMETRY_DESC_PARAM_HPB_SUBREGION_SIZE];
+	max_active_rgns = get_unaligned_be16(geo_buf +
+			  GEOMETRY_DESC_PARAM_HPB_MAX_ACTIVE_REGS);
+
+	if (hpb_info->rgn_size == 0 || hpb_info->srgn_size == 0 ||
+	    max_active_rgns == 0) {
+		dev_err(hba->dev, "No HPB supported device\n");
+		hpb_info->hpb_disabled = true;
+		return;
+	}
+}
+
+void ufshpb_get_dev_info(struct ufs_hba *hba, u8 *desc_buf)
+{
+	struct ufshpb_dev_info *hpb_dev_info = &hba->ufshpb_dev;
+	int version;
+	u8 hpb_mode;
+
+	hpb_mode = desc_buf[DEVICE_DESC_PARAM_HPB_CONTROL];
+	if (hpb_mode == HPB_HOST_CONTROL) {
+		dev_err(hba->dev, "%s: host control mode is not supported.\n",
+			__func__);
+		hpb_dev_info->hpb_disabled = true;
+		return;
+	}
+
+	version = get_unaligned_be16(desc_buf + DEVICE_DESC_PARAM_HPB_VER);
+	if (version != HPB_SUPPORT_VERSION) {
+		dev_err(hba->dev, "%s: HPB %x version is not supported.\n",
+			__func__, version);
+		hpb_dev_info->hpb_disabled = true;
+		return;
+	}
+
+	/*
+	 * Get the number of user logical unit to check whether all
+	 * scsi_device finish initialization
+	 */
+	hpb_dev_info->num_lu = desc_buf[DEVICE_DESC_PARAM_NUM_LU];
+}
+
+void ufshpb_init(struct ufs_hba *hba)
+{
+	struct ufshpb_dev_info *hpb_dev_info = &hba->ufshpb_dev;
+	int try;
+	int ret;
+
+	if (!ufshpb_is_allowed(hba))
+		return;
+
+	atomic_set(&hpb_dev_info->slave_conf_cnt, hpb_dev_info->num_lu);
+	/* issue HPB reset query */
+	for (try = 0; try < HPB_RESET_REQ_RETRIES; try++) {
+		ret = ufshcd_query_flag(hba, UPIU_QUERY_OPCODE_SET_FLAG,
+					QUERY_FLAG_IDN_HPB_RESET, 0, NULL);
+		if (!ret)
+			break;
+	}
+}
diff --git a/drivers/scsi/ufs/ufshpb.h b/drivers/scsi/ufs/ufshpb.h
new file mode 100644
index 000000000000..11f5b018af51
--- /dev/null
+++ b/drivers/scsi/ufs/ufshpb.h
@@ -0,0 +1,166 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Universal Flash Storage Host Performance Booster
+ *
+ * Copyright (C) 2017-2021 Samsung Electronics Co., Ltd.
+ *
+ * Authors:
+ *	Yongmyung Lee <ymhungry.lee@samsung.com>
+ *	Jinyoung Choi <j-young.choi@samsung.com>
+ */
+
+#ifndef _UFSHPB_H_
+#define _UFSHPB_H_
+
+/* hpb response UPIU macro */
+#define HPB_RSP_NONE				0x0
+#define HPB_RSP_REQ_REGION_UPDATE		0x1
+#define HPB_RSP_DEV_RESET			0x2
+#define MAX_ACTIVE_NUM				2
+#define MAX_INACTIVE_NUM			2
+#define DEV_DATA_SEG_LEN			0x14
+#define DEV_SENSE_SEG_LEN			0x12
+#define DEV_DES_TYPE				0x80
+#define DEV_ADDITIONAL_LEN			0x10
+
+/* hpb map & entries macro */
+#define HPB_RGN_SIZE_UNIT			512
+#define HPB_ENTRY_BLOCK_SIZE			4096
+#define HPB_ENTRY_SIZE				0x8
+#define PINNED_NOT_SET				U32_MAX
+
+/* hpb support chunk size */
+#define HPB_MULTI_CHUNK_HIGH			1
+
+/* hpb vender defined opcode */
+#define UFSHPB_READ				0xF8
+#define UFSHPB_READ_BUFFER			0xF9
+#define UFSHPB_READ_BUFFER_ID			0x01
+#define HPB_READ_BUFFER_CMD_LENGTH		10
+#define LU_ENABLED_HPB_FUNC			0x02
+
+#define HPB_RESET_REQ_RETRIES			10
+
+#define HPB_SUPPORT_VERSION			0x100
+
+enum UFSHPB_MODE {
+	HPB_HOST_CONTROL,
+	HPB_DEVICE_CONTROL,
+};
+
+enum UFSHPB_STATE {
+	HPB_PRESENT = 1,
+	HPB_SUSPEND,
+	HPB_FAILED,
+	HPB_RESET,
+};
+
+enum HPB_RGN_STATE {
+	HPB_RGN_INACTIVE,
+	HPB_RGN_ACTIVE,
+	/* pinned regions are always active */
+	HPB_RGN_PINNED,
+};
+
+enum HPB_SRGN_STATE {
+	HPB_SRGN_UNUSED,
+	HPB_SRGN_INVALID,
+	HPB_SRGN_VALID,
+	HPB_SRGN_ISSUED,
+};
+
+/**
+ * struct ufshpb_lu_info - UFSHPB logical unit related info
+ * @num_blocks: the number of logical block
+ * @pinned_start: the start region number of pinned region
+ * @num_pinned: the number of pinned regions
+ * @max_active_rgns: maximum number of active regions
+ */
+struct ufshpb_lu_info {
+	int num_blocks;
+	int pinned_start;
+	int num_pinned;
+	int max_active_rgns;
+};
+
+struct ufshpb_subregion {
+	enum HPB_SRGN_STATE srgn_state;
+	int rgn_idx;
+	int srgn_idx;
+	bool is_last;
+};
+
+struct ufshpb_region {
+	struct ufshpb_subregion *srgn_tbl;
+	enum HPB_RGN_STATE rgn_state;
+	int rgn_idx;
+	int srgn_cnt;
+};
+
+struct ufshpb_stats {
+	u64 hit_cnt;
+	u64 miss_cnt;
+	u64 rb_noti_cnt;
+	u64 rb_active_cnt;
+	u64 rb_inactive_cnt;
+	u64 map_req_cnt;
+};
+
+struct ufshpb_lu {
+	int lun;
+	struct scsi_device *sdev_ufs_lu;
+	struct ufshpb_region *rgn_tbl;
+
+	atomic_t hpb_state;
+
+	/* pinned region information */
+	u32 lu_pinned_start;
+	u32 lu_pinned_end;
+
+	/* HPB related configuration */
+	u32 rgns_per_lu;
+	u32 srgns_per_lu;
+	u32 last_srgn_entries;
+	int srgns_per_rgn;
+	u32 srgn_mem_size;
+	u32 entries_per_rgn_mask;
+	u32 entries_per_rgn_shift;
+	u32 entries_per_srgn;
+	u32 entries_per_srgn_mask;
+	u32 entries_per_srgn_shift;
+	u32 pages_per_srgn;
+
+	struct ufshpb_stats stats;
+
+	struct list_head list_hpb_lu;
+};
+
+struct ufs_hba;
+struct ufshcd_lrb;
+
+#ifndef CONFIG_SCSI_UFS_HPB
+static void ufshpb_resume(struct ufs_hba *hba) {}
+static void ufshpb_suspend(struct ufs_hba *hba) {}
+static void ufshpb_reset(struct ufs_hba *hba) {}
+static void ufshpb_reset_host(struct ufs_hba *hba) {}
+static void ufshpb_init(struct ufs_hba *hba) {}
+static void ufshpb_init_hpb_lu(struct ufs_hba *hba, struct scsi_device *sdev) {}
+static void ufshpb_destroy_lu(struct ufs_hba *hba, struct scsi_device *sdev) {}
+static bool ufshpb_is_allowed(struct ufs_hba *hba) { return false; }
+static void ufshpb_get_geo_info(struct ufs_hba *hba, u8 *geo_buf) {}
+static void ufshpb_get_dev_info(struct ufs_hba *hba, u8 *desc_buf) {}
+#else
+void ufshpb_resume(struct ufs_hba *hba);
+void ufshpb_suspend(struct ufs_hba *hba);
+void ufshpb_reset(struct ufs_hba *hba);
+void ufshpb_reset_host(struct ufs_hba *hba);
+void ufshpb_init(struct ufs_hba *hba);
+void ufshpb_init_hpb_lu(struct ufs_hba *hba, struct scsi_device *sdev);
+void ufshpb_destroy_lu(struct ufs_hba *hba, struct scsi_device *sdev);
+bool ufshpb_is_allowed(struct ufs_hba *hba);
+void ufshpb_get_geo_info(struct ufs_hba *hba, u8 *geo_buf);
+void ufshpb_get_dev_info(struct ufs_hba *hba, u8 *desc_buf);
+extern struct attribute_group ufs_sysfs_hpb_stat_group;
+#endif
+
+#endif /* End of Header */
-- 
2.25.1

